Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264227AbTE1Hvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 03:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTE1Hvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 03:51:54 -0400
Received: from gw.enyo.de ([212.9.189.178]:50192 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S264227AbTE1Hvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 03:51:53 -0400
To: linux-kernel@vger.kernel.org
Subject: [2.5.69] ext3 error: rec_len %% 4 != 0
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Wed, 28 May 2003 10:05:07 +0200
Message-ID: <8765nva43w.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, our 2.5 test machine (actually, it's a production machine,
please don't ask why we can't use 2.4 *sigh*) stops with an ext3 error
message.  We have now activated proper logging, and that's what we
got:

May 28 03:23:00 kernel: EXT3-fs error (device md0): ext3_readdir: bad entry in directory #16056745: rec_len %% 4 != 0 - offset=52, inode=431743, rec_len=37017, name_len=41 
May 28 03:23:00 kernel: Aborting journal on device md0. 
May 28 03:23:00 kernel: ext3_abort called. 
May 28 03:23:00 kernel: EXT3-fs abort (device md0): ext3_journal_start: Detected aborted journal 
May 28 03:23:00 kernel: Remounting filesystem read-only 
May 28 03:23:00 kernel: EXT3-fs error (device md0) in ext3_commit_write: IO failure 
May 28 03:23:00 kernel: EXT3-fs error (device md0) in start_transaction: Journal has aborted 

What could cause this?  Spurious data transmission errors?  md0 is a
RAID-5, the machine is a Siemens Primergy H450 (Quad Pentium 4/Xeon, 4
GB RAM, two-channel Adaptec aic7899 Ultra160 SCSI adapter).

According to fsck.ext3, the on-disk data structures are clean, and if
I run "find" across the file system after the reboot, it doesn't
complain about bad directory entries, either.
