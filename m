Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315221AbSEDWLf>; Sat, 4 May 2002 18:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315222AbSEDWLe>; Sat, 4 May 2002 18:11:34 -0400
Received: from adsl-63-207-97-74.dsl.snfc21.pacbell.net ([63.207.97.74]:62191
	"EHLO nova.botz.org") by vger.kernel.org with ESMTP
	id <S315221AbSEDWLe> convert rfc822-to-8bit; Sat, 4 May 2002 18:11:34 -0400
X-Mailer: exmh version 2.5_20020419 04/19/2002 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Reproducible SMP kernel deadlock in SCSI generic driver (sg)
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Sat, 04 May 2002 15:08:38 -0700
Message-ID: <4595.1020550118@localhost>
From: Jurgen Botz <jurgen@botz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sg module reproducibly deadlocks the kernel for me after some time
of heavy I/O on an SMP system.  This appears to be true in /all/ kernel
versions... I can reproduce it very reliably now in 2.4.19-pre8 and
2.5.13, and I've had problems with CD ripping on my SMP workstation at
least throughout the 2.4 series (I just never fully investigated before).
The bug is almost certainly in sg.c; here is what I've narrowed down...

- Deadlock when ripping CDs using generic device under SMP after some
  amount of heavy I/O; higher transfer rate seems to make it happen
  sooner.
- Happens with SCSI CD drives as well as IDE drives using ide-scsi or
  USB drives using usb-storage.
- Deadlock happens sooner with usb-storage than with real SCSI device,
  but will eventually happen in either case.  In worst case I've seen
  the deadlock after ~100MB transferred, in the best case after ~3-4GB
  (i.e. ripped about 5-6 CDs).
- No deadlock when using sr device on SMP kernel
- No deadlock with sg or sr on UP kernel

Searching lkml didn't turn up any recent reports of anything like this,
but I suspect that's because not too many people are ripping CDs on
SMP systems these days... however, if anyone out there /does/ and
doesn't see lockups, please let me know.

:j

-- 
Jürgen Botz                       | While differing widely in the various
jurgen@botz.org                   | little bits we know, in our infinite
                                  | ignorance we are all equal. -Karl Popper


