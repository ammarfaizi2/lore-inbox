Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310376AbSCGQKG>; Thu, 7 Mar 2002 11:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310381AbSCGQJ6>; Thu, 7 Mar 2002 11:09:58 -0500
Received: from mailgate.bodgit-n-scarper.com ([62.49.233.146]:40967 "HELO
	mailgate.bodgit-n-scarper.com") by vger.kernel.org with SMTP
	id <S310376AbSCGQJl>; Thu, 7 Mar 2002 11:09:41 -0500
Date: Thu, 7 Mar 2002 16:09:34 +0000
From: Matt <matt@bodgit-n-scarper.com>
To: linux-kernel@vger.kernel.org
Subject: sunhme.o+SMP, the fourth QFE port interrupt mystery
Message-ID: <20020307160934.A19885@mould.bodgit-n-scarper.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 on i686 SMP (mould)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After plugging in a Sun QFE card into an HP LH6000r, with the kernel
compiled for SMP support, the fourth port can't get an interrupt. I can
get all four ports to come up if I don't compile SMP support in, but my
interrupt allocation ends up looking like this:

root@spud:~# cat /proc/interrupts 
           CPU0       
  0:      63234          XT-PIC  timer
  1:        521          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       2395          XT-PIC  megaraid
  8:          1          XT-PIC  rtc
  9:       2029          XT-PIC  aacraid, aic7xxx, eth0, HAPPY MEAL, HAPPY MEAL, HAPPY MEAL, HAPPY MEAL
 12:          0          XT-PIC  PS/2 Mouse
 14:          3          XT-PIC  ide0
NMI:          0 
ERR:          8

...which I don't believe is conducive to an efficient system :-).

I've also tried enabling Local APIC support but that causes problems
elsewhere on this particular box, so I've left that alone. 2.4.16 is
the current kernel version on here.

Anyone have a fix for this?

Cheers

Matt

PS. Being a Sun card, all of the ports have a MAC of 00:00:00:00:00:00, I
can see four unique codes on the card that must be the last six digits of
each MAC, but what is the first six for a Sun QFE? I don't have another
plugged into a Sun box to see...
