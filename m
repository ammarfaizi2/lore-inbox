Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVCLL41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVCLL41 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 06:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVCLL40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 06:56:26 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:50630 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S261684AbVCLL4R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 06:56:17 -0500
Date: Sat, 12 Mar 2005 03:56:14 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: nfs@lists.sourceforge.net
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, <mc@cs.Stanford.EDU>
Subject: [CHECKER] inconsistent NFS stat cache (NFS on ext3, 2.6.11)
Message-ID: <Pine.GSO.4.44.0503120335160.12085-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We checked NFS on top of ext3 using FiSC (our file system model checker)
and found a case where NFS stat cache can contain inconsistent entries.

Basically, to trigger this inconsistency, just do the following steps:
1. create a file A1, write a few bytes to it, so A1 is 4 words
2. create a hard link A2, pointing to A1
3. stat on A2. A2's size is 4 words
4. truncate A1 to a larger size, write a few bytes at the end. now it's
1031 words.
5. stat on A2. it's size is still 4 words, which should be 1031 words

We have a test case to re-create this warning.  You can download it at
http://fisc.stanford.edu/bug16/crash.c.  It includes some sudo commands
to mount nfs partitions, which you might want to change according to your
local settings.

cat /etc/exports shows:
/mnt/sbd0-export          localhost(rw,sync)
/mnt/sbd1-export          localhost(rw,sync)

Let me know if you have any problems reproducing the warning. We'd
appreciate any confirmations/clarifications.

-Junfeng

