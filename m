Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278631AbRJ1QaG>; Sun, 28 Oct 2001 11:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278609AbRJ1Q34>; Sun, 28 Oct 2001 11:29:56 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:34677 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S278665AbRJ1Q3n>; Sun, 28 Oct 2001 11:29:43 -0500
Message-ID: <3BDC331E.50B8DB5E@shark-linux.de>
Date: Sun, 28 Oct 2001 17:32:30 +0100
From: Alexander Schulz <alex@shark-linux.de>
Organization: Private Linux Site
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i586)
X-Accept-Language: de-DE,de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [RFC] RTC policy questions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am currently working on porting the linux kernel to
the Shark, a StrongARM based computer (DNARD from digital)
that contains many parts known from PCs.

On the Shark I have to use the (PC-like) RealTimeClock as a
heartbeat source. This has two consequences:

1) No user may be allowed to alter the frequency of
   the RTC interrupt or even turn it off.
   AFAIK the alarm cannot be used, because it uses
   the same irq.
2) I would like to use the set_rtc_irq_bit and
   get_rtc_time functions from drivers/char/rtc.c in
   include/asm-arm/arch-shark/time.h to setup the
   rtc at bootup. That means that they cannot be
   static in rtc.c.

a) I could avoid 2) by duplicating the functions in time.h
   (it seems arch-ebsa285/time.h implements its own setup),
   but I hate duplicating code.
b) I solved 1) by patching rtc.c to exclude the offending
   code if CONFIG_ARCH_SHARK is defined. The only other way
   I can think of would be to have a complete rtc driver
   for the shark but that again would mean duplicating code.

What do you think? Is it ok to patch the rtc.c or would it be
better to duplicate the code? Are there more possible solutions
that I cannot think of?

I am using 2.4.12-ac6-rmk2 at the moment but the problem is
mostly version independent.

Thanks for all comments
   Alexander
