Return-Path: <linux-kernel-owner+willy=40w.ods.org-S277261AbVBDEsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S277261AbVBDEsh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 23:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S277255AbVBDEsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 23:48:35 -0500
Received: from mailhub2.une.edu.au ([129.180.1.142]:49595 "EHLO
	mailhub2.une.edu.au") by vger.kernel.org with ESMTP id S277110AbVBDEri
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 23:47:38 -0500
Date: Fri, 4 Feb 2005 15:47:36 +1100
From: Norman Gaywood <norm@turing.une.edu.au>
To: linux-kernel@vger.kernel.org
Subject: slowdown with 2.6.10 when using NFS client
Message-ID: <20050204044736.GA8406@turing.une.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is with the fedora kernel 2.6.10-1.760_FC3smp

I've reproduced this on 2 SMP systems with different NFS servers and
several Fedora 2.6.10 kernels. I could not reproduce the problem with a
non-SMP kernel or a 2.4 kernel. I have not tried with a pre 2.6.10 kernel.

I think some others have seen similar things in this old thread:

http://lkml.org/lkml/2005/1/17/201

Running john the ripper (dictionary password cracker) from an NFS mounted
directory causes the system to become very sluggish. Copying the same
directory to local disk and running john from there, the system runs
smoothly.

In an NFS mounted dir I start "vmstat 1", then start "./john -restore",
and then kill john after a few seconds. vmstat output follows. sy cpu
time looks interesting to me.

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0 1828124  28636 142444    0    0    80    17  279    72  2  2 93  3
 0  0      0 1828124  28636 142444    0    0     0     0 1115    54  0  0 100  0
 0  0      0 1828124  28636 142444    0    0     0     0 1005    16  0  0 100  0
 0  0      0 1828124  28636 142444    0    0     0     0 1119    46  0  0 100  0
 0  0      0 1828124  28636 142444    0    0     0     0 1027    32  0  0 100  0
 0  0      0 1827996  28644 142436    0    0     0    36 1107    40  0  0 100  0
 0  1      0 1827996  28644 142436    0    0     0     4 1013    26  0  0 100  0
 0  0      0 1828060  28644 142436    0    0     0     0 1119    57  0  0 100  0
 0  0      0 1828060  28644 142436    0    0     0     0 1042    42  0  0 100  0
 0  0      0 1827932  28644 142436    0    0     0     0 1109    47  0  0 100  0
 0  0      0 1827932  28644 142436    0    0     0     0 1029    48  0  0 100  0
 0  1      0 1827932  28652 142428    0    0     0    16 1106    40  0  0 100  0
 0  0      0 1827932  28652 142428    0    0     0     0 1006    20  0  0 100  0
 2  0      0 1822804  28652 142948    0    0     0     0 2080   296  9  9 82  0
 2  0      0 1822804  28652 142948    0    0     0     0 1006    10 25  0 75  0
 1  0      0 1822804  28652 142948    0    0     0     0 1075    30 25 23 51  0
 1  0      0 1822804  28652 142948    0    0     0     0 1037    28 25 23 52  0
 2  0      0 1822804  28652 142948    0    0     0     0 1061    25 25 14 61  0
 1  0      0 1822812  28660 142940    0    0     0    24 1050    25 25 32 43  0
 2  0      0 1822812  28660 142940    0    0     0     0 1033    17 25 18 57  0
 2  0      0 1822812  28660 142940    0    0     0     0 1078    32 25 17 59  0
 1  0      0 1822748  28660 142940    0    0     0     0 1105    40 25 16 59  0
 3  0      0 1822748  28660 142940    0    0     0     0 1263    17 25 52 23  0
 1  0      0 1822684  28660 142940    0    0     0     0 1303    41 25 21 54  0
 2  0      0 1822684  28660 142940    0    0     0     0 1165    15 25 25 50  0
 2  0      0 1822684  28660 142940    0    0     0     0 1240    26 25  6 69  0
 0  0      0 1826964  28668 142932    0    0     0    20 1242    79  7 12 80  0
 0  0      0 1826964  28668 142932    0    0     0     0 1014    22  0  0 100  0
 0  0      0 1826964  28668 142932    0    0     0     0 1108    42  0  0 100  0

If I then copy the same directory to local disk (/tmp) and do the same
thing, system has no slowdown, vmstat looks like:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0 1809692  28812 159688    0    0    65    17  281    62  2  2 93  3
 0  0      0 1809692  28812 159688    0    0     0     0 1107    36  0  0 100  0
 0  0      0 1809692  28820 159680    0    0     0    76 1011    20  0  0 99  1
 0  0      0 1809692  28820 159680    0    0     0     0 1113    60  0  0 100  0
 0  0      0 1809756  28820 159680    0    0     0     0 1018    32  0  0 100  0
 0  0      0 1809756  28820 159680    0    0     0     0 1111    40  0  0 100  0
 0  0      0 1809756  28820 159680    0    0     0     0 1006    18  0  0 100  0
 0  1      0 1809756  28824 159676    0    0     0    16 1105    40  0  0 100  0
 0  0      0 1809756  28828 159672    0    0     0     8 1017    22  0  0 100  0
 0  0      0 1809756  28828 159672    0    0     0     0 1104    30  0  0 100  0
 0  0      0 1809756  28828 159672    0    0     0     0 1007    14  0  0 100  0
 0  0      0 1809756  28828 159672    0    0     0     0 1104    30  0  0 100  0
 0  1      0 1809628  28832 159668    0    0     0    20 1010    27  0  0 100  0
 0  0      0 1809628  28836 159664    0    0     0   100 1143    61  0  0 100  0
 0  0      0 1809628  28836 159664    0    0     0     0 1018    35  0  0 100  0
 0  0      0 1809628  28836 159664    0    0     0     0 1125    68  0  0 99  0
 0  1      0 1808860  28836 159664    0    0     0     8 1015    36  2  0 98  0
 1  0      0 1805404  28852 159648    0    0     0    56 1114    56 23  0 75  2
 1  0      0 1805404  28852 159648    0    0     0     0 1006    16 25  0 75  0
 1  0      0 1805404  28852 159648    0    0     0     0 1102    30 25  0 75  0
 1  0      0 1805404  28852 159648    0    0     0     0 1005    12 25  0 75  0
 1  0      0 1805404  28852 159648    0    0     0     0 1103    30 25  0 75  0
 1  1      0 1805404  28852 159648    0    0     0     4 1007    22 25  0 75  0
 1  0      0 1805404  28860 159640    0    0     0    12 1106    39 25  0 75  0
 1  0      0 1805404  28860 159640    0    0     0     0 1005    10 25  0 75  0
 1  0      0 1805404  28860 159640    0    0     0     0 1105    38 25  0 75  0
 1  0      0 1805404  28860 159640    0    0     0     0 1007    16 25  0 75  0
 1  1      0 1805340  28860 159640    0    0     0     8 1107    41 25  0 75  0
 1  0      0 1805340  28868 159632    0    0     0    16 1010    18 25  0 74  0
 1  0      0 1805340  28868 159632    0    0     0     0 1106    37 25  0 75  0
 1  0      0 1805340  28868 159632    0    0     0     0 1008    14 25  0 75  0
 1  0      0 1805340  28868 159632    0    0     0     0 1104    30 25  0 75  0
 1  1      0 1805404  28868 159632    0    0     0     8 1007    20 25  0 75  0
 1  0      0 1805404  28876 159624    0    0     0    16 1107    38 25  0 74  1
 1  0      0 1805404  28876 159624    0    0     0     0 1005    10 25  0 75  0
 1  0      0 1805404  28876 159624    0    0     0     0 1103    30 25  0 75  0
 0  0      0 1809820  28884 159616    0    0     0    20 1019    40  8  0 92  1
 0  0      0 1809812  28884 159616    0    0     0     0 1110    50  0  0 100  0
 0  0      0 1809812  28884 159616    0    0     0     0 1011    22  0  0 100  0

-- 
Norman Gaywood, Systems Administrator
School of Mathematics, Statistics and Computer Science
University of New England, Armidale, NSW 2351, Australia

norm@turing.une.edu.au            Phone: +61 (0)2 6773 2412
http://turing.une.edu.au/~norm    Fax:   +61 (0)2 6773 3312

Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
