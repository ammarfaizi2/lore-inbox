Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264978AbTFYT3l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 15:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbTFYT3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 15:29:40 -0400
Received: from pushme.nist.gov ([129.6.16.92]:48537 "EHLO postmark.nist.gov")
	by vger.kernel.org with ESMTP id S264978AbTFYT3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 15:29:24 -0400
To: linux-kernel@vger.kernel.org
Subject: Relieving lowmem pressure on a highmem box, 2.4
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Wed, 25 Jun 2003 15:43:11 -0400
Message-ID: <m3k7balz8w.fsf@nist.gov>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a Dell server with 12GB of RAM in it which is having a lot of
trouble with lowmem pressure.  wli's bloatmeter script shows that it's
a lot of buffer-heads and inodes.

$ bloatmost | head -4
         buffer_head:   191316KB   211893KB   90.28
         inode_cache:    64813KB    66097KB   98.5
             size-64:       82KB    10871KB    0.75
             size-32:       95KB     5694KB    1.68

$ cat /proc/slabinfo | sort -k 2,2n | tail
size-512            1052   1176    512  132  147    1 :  124   62
dentry_cache        1068   2580    128   86   86    1 :  252  126
blkdev_requests     1200   1200    128   40   40    1 :  252  126
filp                1230   1230    128   41   41    1 :  252  126
size-32             1532  91118     64   42 1571    1 :  252  126
pte_chain           2466  13050    128  157  435    1 :  252  126
size-128            2946   3450    128  115  115    1 :  252  126
vm_area_struct      3192   4830    128  138  161    1 :  252  126
inode_cache       129503 132195    512 18885 18885    1 :  124   62
buffer_head       2043732 2260200     96 56450 56505    1 :  252  126

What's a good solution for this?  I'm not ready to move to 2.5, since
stability is pretty important for us, but patching 2.4 should be OK.
The current kernel is RedHat's 2.4.20-18.8 (SMP, BIGMEM; HIGHMEM
option set to 64GB).

Thanks in advance,
Ian

