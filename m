Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269572AbRHAAhx>; Tue, 31 Jul 2001 20:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269574AbRHAAho>; Tue, 31 Jul 2001 20:37:44 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:8964 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S269571AbRHAAhi>; Tue, 31 Jul 2001 20:37:38 -0400
Date: Tue, 31 Jul 2001 20:36:14 -0400
Message-Id: <200108010036.f710aEO00457@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
X-Also-Posted-To: comp.os.linux.development.system
Subject: Loopback problems in 2.4.x kernels
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Reply-To: davidsen@tmr.com (bill davidsen)
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I regularly get CDs written with binary data at the front followed by an
iso9660 image. And I have always read then by:

  mount -o ro,offset=17000 /dev/cdrom /cdrom

which works in 2.0 and 2.2 kernels. However, it doesn't work in 2.4.x
kernels, at least anything recent enough for me to try, and certainly
not in 2.4.[67].

I have already tried:

- boot a 2.2 kernel on the same hardware. WORKS
- dd the data to a file and offset mount that. WORKS
- try both atapi and ide-scsi for device. FAILS
- use losetup. FAILS

I think the success at mounting the copy of the file shows that the
kernels are built correctly, the loop module loads if I build as a
module, no errors from the kernel in terms of operation, just an unknown
file type.

Based on looking at the data, I think the offset is being moved to some
multiple of a sector or page size. It's not what I see in the copy on
disk in a file.

I have been doing this since 2.0.33 and it's been working. I think I
remember early 2.4 kernels, or late test releases, working fine, but I
don't have a machine to test until the weekend at the earliest.

Unless someone has some trick to get by this, consider it a warning and
bug report.

REPEAT BY:

  mkisofs -dDRNLJ -o /tmp/small.iso /etc
  dd if=/dev/random bs=6 count=1 of=/tmp/rxx
  cat /tmp/rxx /tmp/samll.iso | cdrecord dev=0,0,4 -pad
  mount -o ro,offset=6 /dev/cdrom /cdrom

or whatever is similar on your system.

-- 
  bill davidsen <davidsen@tmr.com>  CTO, TMR Associates, Inc
You have moved your mouse. Before this change can take effect you must
reboot your system. Press ENTER now to reboot your system, or any other
key to repartition your hard disk and reinstall Windows.
