Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130531AbQLGTlM>; Thu, 7 Dec 2000 14:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130536AbQLGTlC>; Thu, 7 Dec 2000 14:41:02 -0500
Received: from zeus.kernel.org ([209.10.41.242]:46092 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130531AbQLGTkx>;
	Thu, 7 Dec 2000 14:40:53 -0500
Date: Thu, 7 Dec 2000 19:55:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Bernd Kischnick <kisch@mindless.com>, "Theodore Ts'o" <tytso@mit.edu>
Subject: patch: test12-pre7 cd stuff
Message-ID: <20001207195539.P6832@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've put up a modified cd patch set against 2.4.0-test12-pre7. The
changes are roughly as follows:

o Fix SCSI CD-ROM on fs with < 2KB block size. I've briefly tested
  with ext2 (1KB) and msdos (512b) and it appears to work. Would
  the HFS folks try this too?
o Per command timeout for CD-ROM generic packet
o Per command quiet bit, as not to print a lot of sense stuff when
  we know that something may fail
o Major CDROM_SEND_PACKET cleanup
o ide-cd shut up stuff (- sense logging in some cases)
o Make sure that cdrom_sleep actually does that, sleeps
o Let sr retry a PLAYTRKIND command with PLAYMSF for ide-scsi
  and ATAPI.
o Minor sr cleanups

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-test12-pre7/cd-2.bz2

In addition I made another small fix after uploading this one. Audio
ripping can fail with the vm failing to allocate enough contigous
pages, if ripping programs specify large bites of frames to be ripped.
Always default to allocating just a single page.

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.0-test12-pre7/cd-2-cdda_alloc.bz2

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
