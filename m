Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266476AbUF3RGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266476AbUF3RGV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266478AbUF3RGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:06:21 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:56826 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S266476AbUF3RGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:06:19 -0400
Date: Wed, 30 Jun 2004 19:06:45 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Patches for -bk/-mm4.
Message-ID: <20040630170645.GA3189@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
today I've 7 patches for you to consider. One is common code,
6 are s390 bug fixes. I've another one which adds experimental
cpu hotplug support for s390 which works on the -bk tree but
not one the -mm4 tree. I could track it down to two patches
in -mm4, if I remove sched-cleanup-improve-sched-fork-apis.patch
and sched-cleanup-init_idle.patch the hotplugging works on -mm4.
I'll have to investigate further what's wrong here.

The common code problem is in lib/radix-tree.c where an int
is shifted by more then 32 bits. We stumbled over this problem
with the efi partition code. After a dasd device is freshly
formatted it has 0 blocks. The efi partition code tries to load
the last block of the device which turns out to number -1. A
mapping for page at index (~0UL >> 3) related to a bdev inode
is established. Due to the bug in the radix tree code the page
isn't found when the bdev gets released and the nrpages counter
stays 1 -> "kernel BUG() at fs/inode.c:238!".

Have fun & blue skies,
  Martin.

