Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWDCIEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWDCIEz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 04:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWDCIEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 04:04:55 -0400
Received: from cicero0.cybercity.dk ([212.242.40.52]:14288 "EHLO
	cicero0.cybercity.dk") by vger.kernel.org with ESMTP
	id S932355AbWDCIEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 04:04:55 -0400
Date: Mon, 3 Apr 2006 09:04:46 +0100 (BST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: linux-kernel@vger.kernel.org
Subject: [2.6.16.1 BUG?] EXT3 error on encrypted volume on top of RAID5
Message-ID: <Pine.LNX.4.40.0604030848420.23478-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I set up a new file server with 4*250GB SATA disks, on top of that I run
RAID5 (and RAID1 for the boot partition).

There is a RAID5 volume of 332GB, on top of that I created an encrypted
volume with cryptsetup like this:

cryptsetup create vol1s /dev/md4 -h sha256 -y

On the encrypted volume I have a standard EXT3 file system. Everything
seems okay. I then copied a lot of files from Windows with Samba, and
suddenly this error occurred about halfway through copying a large file
(about 8GB):

Apr  3 01:28:54 localhost kernel: EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #6275075: rec_len %% 4 != 0 - offset=0, inode=1896112483, rec_len=55802, name_len=122
Apr  3 01:28:55 localhost kernel: Aborting journal on device dm-0.
Apr  3 01:28:55 localhost kernel: ext3_abort called.
Apr  3 01:28:55 localhost kernel: EXT3-fs error (device dm-0): ext3_journal_start_sb: Detected aborted journal
Apr  3 01:28:55 localhost kernel: Remounting filesystem read-only
Apr  3 01:28:56 localhost kernel: __journal_remove_journal_head: freeing b_frozen_data
Apr  3 01:28:56 localhost kernel: __journal_remove_journal_head: freeing b_frozen_data
Apr  3 01:28:56 localhost kernel: __journal_remove_journal_head: freeing b_committed_data
Apr  3 01:28:56 localhost kernel: __journal_remove_journal_head: freeing b_frozen_data
Apr  3 01:31:07 localhost kernel: EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #6275075: rec_len %% 4 != 0 - offset=0, inode=1896112483, rec_len=55802, name_len=122

Then in the morning I unmounted the file system and ran fsck on it. There wasn't any errors found, but I got this in the syslog:

Apr  3 08:20:46 localhost kernel: __journal_remove_journal_head: freeing b_committed_data
Apr  3 08:20:46 localhost kernel: __journal_remove_journal_head: freeing b_frozen_data
Apr  3 08:20:46 localhost last message repeated 2 times

After running fsck, I mounted it back online and copied the big file again, this time there was no error and no messages in the syslog.

If more info is needed, please CC me at thomas dot horsten, append '@' and gmail.com.

Thomas

