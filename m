Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129247AbRBAGtx>; Thu, 1 Feb 2001 01:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129495AbRBAGtn>; Thu, 1 Feb 2001 01:49:43 -0500
Received: from ellpspace.math.ualberta.ca ([129.128.207.67]:5445 "EHLO
	ellpspace.math.ualberta.ca") by vger.kernel.org with ESMTP
	id <S129247AbRBAGt3>; Thu, 1 Feb 2001 01:49:29 -0500
Date: Wed, 31 Jan 2001 23:49:25 -0700
From: Michal Jaegermann <michal@ellpspace.math.ualberta.ca>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1 not fully sane on Alpha - file systems
Message-ID: <20010131234925.A14300@ellpspace.math.ualberta.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried to boot 2.4.1 kernel on Alpha UP1100.  This machine
happens to have two SCSI disks on sym53c875 controller and two IDE
drives hooked to a builtin "Acer Laboratories Inc. [ALi] M5229 IDE".
It boots and in the first moment makes even a pretty good impression
of beeing healthy.  But an attempt to compile something causes the
whole setup to start behaving weird, with a compiler obviously unable
to find both itself and the right sources, and the whole thing ends in
a silent lockup.

On the second boot I tried to copy kernel sources from a SCSI to an
IDE drive.  This time I got something in my logs and the same stuff
was printed on my screen before everything lockded up really tight
again (no sysrq).  Here it is:

 kernel: attempt to access beyond end of device
 kernel: 08:05: rw=0, want=198500353, limit=5779456
 kernel: attempt to access beyond end of device
 kernel: 08:05: rw=0, want=4294934529, limit=5779456
 kernel: attempt to access beyond end of device
 kernel: 08:05: rw=0, want=198500353, limit=5779456
 kernel: EXT2-fs error (device sd(8,5)): ext2_readdir: bad entry in
 directory #250255: directory entry across blocks - offset=0,
 inode=198505472, rec_len=32768, name_len=255

(and the machine dies at this point).

There is nothing wrong with this device and a file system on it.
Copying the same way, or compiling the same sources, but when booted
with 2.2.18 does not present a whiff of trouble and e2fsck, luckily
enough, finds my file systems still in place.  One should be grateful
for small favours.

Anybody have seen something similar?

  Michal
  michal@harddata.com

p.s. I find a bit humorous the fact that the code required to
recognize that one has _some_ partition table (I happen to have two
kinds at the moment) is billed in a config file as ADVANCED.
It did the job anyway. :-)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
