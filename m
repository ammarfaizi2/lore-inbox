Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbUCXAXX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 19:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbUCXAXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 19:23:22 -0500
Received: from d64-180-152-77.bchsia.telus.net ([64.180.152.77]:15890 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S262944AbUCXAXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 19:23:15 -0500
Date: Tue, 23 Mar 2004 16:14:45 -0800
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: [DEAD BOX] Assert failure fs/jbd/transaction.c
Message-ID: <20040324001445.GA9580@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got an assert failure while I was in X, and was unable to do anything
that'll hit disk (like run dmesg -- couldn't read dmesg in from disk).

Not sure what else was in the dmesg buffer.

handle_t *journal_start(journal_t *journal, int nblocks)
{
...
        if (handle) {
                J_ASSERT(handle->h_transaction->t_journal == journal);
                handle->h_ref++;
                return handle;
        }

This is against a bk pull of 2.6.4-rc1, somewhere around... 2004/03/02.

No idea how to trigger it.

Only file systems that use jbd are:

/dev/hda5 on / type ext3 (rw,data=journal,errors=remount-ro)
/dev/hda6 on /usr type ext3 (rw,nodev,data=journal)
/dev/hda7 on /home type ext3 (rw,nosuid,nodev,data=journal)

Stuff that *might* have affected it:
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y
CONFIG_PREEMPT=y
CONFIG_REGPARM=y

ramune@hasenpfeffer:ramune: cat /proc/version 
Linux version 2.6.4-rc1 (ramune@hasenpfeffer) (gcc version 3.3.1) #12
Mon Mar 1 08:54:17 PST 2004

Debian/Woody, P4 2.4GHz system.

ramune@hasenpfeffer:ramune: lsmod|tail +2|wc -l
    193
(Yeah, that's a lot of stuff -- it gets to the login: prompt faster
 that way if everything I can rip out is a module, bootup decompression
 is obscenely slow on this system).

It's the first time I ever saw this error, so no idea how to trigger
it.  All disk access went dead.

-- DN
Daniel
