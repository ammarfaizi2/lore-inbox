Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269335AbRGaQEb>; Tue, 31 Jul 2001 12:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269331AbRGaQEV>; Tue, 31 Jul 2001 12:04:21 -0400
Received: from 209-221-203-158.dsl.qnet.com ([209.221.203.158]:51460 "HELO
	divino.rinspin.com") by vger.kernel.org with SMTP
	id <S269335AbRGaQEM>; Tue, 31 Jul 2001 12:04:12 -0400
Message-ID: <3B66D63E.2954C181@rinspin.com>
Date: Tue, 31 Jul 2001 09:01:02 -0700
From: Scott Bronson <bronson@rinspin.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver.Neukum@lrz.uni-muenchen.de, linux-kernel@vger.kernel.org
Subject: Re: Conflict between v4l and adi module
In-Reply-To: <Pine.SOL.4.33.0107310128350.2079-100000@sun3.lrz-muenchen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> > Immediately after booting, if I fire up my BT848-based TV
> > tuner, quit, then try to open /dev/js0, [it fails].
> Can you confirm by strace that the open() fails ?

Absolutely:

...
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\210\324"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1149960, ...}) = 0
old_mmap(NULL, 1166404, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40025000
mprotect(0x40138000, 40004, PROT_NONE)  = 0
old_mmap(0x40138000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x112000) = 0x40138000
old_mmap(0x4013e000, 15428, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4013e000
close(3)                                = 0
munmap(0x40016000, 59758)               = 0
getpid()                                = 665
open("/dev/js0", O_RDONLY)              = -1 ENODEV (No such device)
write(2, "jstest: No such device\n", 23jstest: No such device
) = 23
_exit(1)                                = ?


>> [after rmmoding and modprobing adi]
> Can you confirm that it actually works as opposed to open() working ?
> Does it produce correct values ?

Yes, open() now works and it also produces correct values.
It will continue to work, even if I use v4l again, until
I reboot.


> Do you know whether this occurs with all joysticks ?

Alas, I don't know.  I'd especially like to know if USB joysticks
work like this.  Maybe somebody else on this list could try to
reproduce the problem.


> Do you use your soundcard the joystick is attached to to play sound from
> the TV card ?

Nope.  It goes to some dedicated $5 computer speakers.  The v4l-based
webcams that also cause this problem don't have any audio either.
That was a good thought, but I'm pretty sure it's not audio related.


> Could you try compiling the joystick drivers into the kernel ?

Sure.  It didn't change anything.  /dev/jso: No such device.  However,
now I can't rmmod and insmod adi to fix it.  :)

	- Scott


> > To summarize, the failure (/dev/js0: No such device) only happens
> > if I use v4l before opening /dev/js0 after booting the computer.
> > Once /dev/js0 is successfully opened, it always works from then on.
> > rmmoding and insmoding adi always resolves the conflict.  Rebooting
> > and then using v4l before opening the joystick always causes it.
