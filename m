Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269692AbUJMNC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269692AbUJMNC7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 09:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269694AbUJMNC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 09:02:59 -0400
Received: from wine.ocn.ne.jp ([220.111.47.146]:6353 "EHLO smtp.wine.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S269692AbUJMNC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 09:02:57 -0400
To: linux-kernel@vger.kernel.org
Subject: Bug? R/W mount succeeds on a write protected media!
From: <200410@i-love.sakura.ne.jp>
Message-Id: <200410132202.JAF46725.213151@i-love.sakura.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Wed, 13 Oct 2004 22:02:56 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

I found a strange behavior with kernel 2.4.27 .
I installed GRUB into a USB flash memory (BUFFALO's RUF-X, USB2.0, 1GB),
and it boots normally. (Although I need to insert "sleep" inside /linuxrc
so that "mount /dev/root /sysroot" doesn't fail with errno = 6 .)

This USB memory has a "write protect tab" and if it is on,
the kernel message "Write protect is on." appears when the media is recognized.
However, I can remount the root fs (stored in this media) as R/W when the tab is on!
Also, I can create and delete files within the root fs,
although the files are not written to the media.
(The kernel message "write protected" appears
some seconds after any write operations.)

The media is recognized as /dev/sda, and has only one partition /dev/sda1
formatted as ext2.

The kernel includes all drivers that is needed for mounting USB flash memory
formatted as ext2. (SCSI disk modules, USB storage modules, ext2 modules etc.)

I think the R/W mount attempt should fail if the write protect is on.
The problem occurs because the SCSI driver ( or something else ?) doesn't check
whether the media is write protected or not when R/W mount attempt occurs.

When I boot this media with SYSLINUX and mount the root fs image (stored in this
media) using loopback, the R/W mount attempt fails if the write protect is on.

The PC is IBM ThinkPad X31 . (I eject the HDD when I boot from USB memory.)
The kernel is 2.4.27 . (I don't know how to compile non-vanilla kernels.)
Using devfs and automatically mounted. (Because root fs is in a write protected media.)

What information do I need to provide?

Regards...

-------

By the way ...
I subscribe this ML as digest mode to save POP3'ing time and disk spaces.
But the digested message has no Message-Id: for individual messages,
so I can't reply to individual messages to keep a thread tree.
Is "subscribing this ML as non digest mode" the only way to track Message-Id:
for individual messages to keep a thread tree?
Please tell me if there is another way.

-------
  Tetsuo Handa
