Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281660AbRKVBhz>; Wed, 21 Nov 2001 20:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282007AbRKVBhq>; Wed, 21 Nov 2001 20:37:46 -0500
Received: from [24.112.39.102] ([24.112.39.102]:12303 "EHLO
	cr416993-a.ym1.on.wave.home.com") by vger.kernel.org with ESMTP
	id <S281660AbRKVBhg>; Wed, 21 Nov 2001 20:37:36 -0500
Date: Wed, 21 Nov 2001 20:36:25 -0500 (EST)
From: "D. Hugh Redelmeier" <hugh@mimosa.com>
Reply-To: <hugh@mimosa.com>
To: John Jasen <jjasen1@umbc.edu>
cc: Anders Peter Fugmann <afu@fugmann.dhs.org>,
        John Jasen <jjasen@realityfailure.org>, <linux-kernel@vger.kernel.org>
Subject: Re: SiS630 chipsets && linux 2.4.x kernel == snails pace?
In-Reply-To: <Pine.SGI.4.31L.02.0111182144150.12243284-100000@irix2.gl.umbc.edu>
Message-ID: <Pine.LNX.4.33.0111212028590.19382-100000@redshift.mimosa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| From: John Jasen <jjasen1@umbc.edu>

| grep comsumes about 25% of CPU on 2.2.19, with the following times:
| 1.50user 2.79system 0:12.61elapsed 34%CPU (0avgtext+0avgdata 0maxresident)k
| 0inputs+0outputs (178major+79minor)pagefaults 0swaps
| 
| on 2.4.12, it consumes between 60 and 80% of cpu, and I'm still waiting
| for times ...
| 
| 101.48user 4.11system 3:22.85elapsed 52%CPU (0avgtext+0avgdata 0maxresident)k
| 0inputs+0outputs (130major+138minor)pagefaults 0swaps

That sounds like something "invisible" is eating your CPU.  Perhaps
some interrupt handling.

Do a "cat /proc/interrupts", wait a few seconds and do it again.  See
if any count jumped by a lot.  I assume, but don't actually know, that
interrupts that are not handled are still counted.

Hugh Redelmeier
hugh@mimosa.com  voice: +1 416 482-8253

On my machine, when not doing anything, I get a lot of timer
interrupts.

RFC $ cat /proc/interrupts ; sleep 10 ; cat /proc/interrupts
           CPU0       CPU1       
  0:   13363128   13480402    IO-APIC-edge  timer
  1:      78903      77330    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 12:     376841     390230    IO-APIC-edge  PS/2 Mouse
 14:     183020     166039    IO-APIC-edge  ide0
 15:        236        450    IO-APIC-edge  ide1
 16:       2321       2395   IO-APIC-level  bttv
 17:       2166       2170   IO-APIC-level  es1371
 18:          7          7   IO-APIC-level  aic7xxx
 19:     619226     619253   IO-APIC-level  usb-uhci, eth0
NMI:          0          0 
LOC:   26844734   26844733 
ERR:         43
MIS:          0
           CPU0       CPU1       
  0:   13363381   13481153    IO-APIC-edge  timer
  1:      78903      77331    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 12:     376841     390230    IO-APIC-edge  PS/2 Mouse
 14:     183026     166062    IO-APIC-edge  ide0
 15:        236        450    IO-APIC-edge  ide1
 16:       2321       2395   IO-APIC-level  bttv
 17:       2166       2170   IO-APIC-level  es1371
 18:          7          7   IO-APIC-level  aic7xxx
 19:     619226     619253   IO-APIC-level  usb-uhci, eth0
NMI:          0          0 
LOC:   26845738   26845737 
ERR:         43
MIS:          0

