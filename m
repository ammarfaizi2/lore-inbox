Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132859AbQL3Dxm>; Fri, 29 Dec 2000 22:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132862AbQL3Dxb>; Fri, 29 Dec 2000 22:53:31 -0500
Received: from cd168990-a.ctjams1.mb.wave.home.com ([24.108.112.42]:27397 "EHLO
	cd168990-a.ctjams1.mb.wave.home.com") by vger.kernel.org with ESMTP
	id <S132859AbQL3DxR>; Fri, 29 Dec 2000 22:53:17 -0500
Date: Fri, 29 Dec 2000 21:28:00 -0600
From: Evan Thompson <evaner@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: (REPOST-sorry) PCI VIA IDE Strangeness w/2.4.0-test12/test13-pre5
Message-ID: <20001229212800.A631@evaner.penguinpowered.com>
Reply-To: evaner@bigfoot.com
Mail-Followup-To: Evan Thompson <evaner@bigfoot.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=problems
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

REPOST: People have asked me to repost this message because their e-mail clients
don't wrap lines.  I'd like to know which ones don't, but this isn't the list
for that kind of question, unless it is, which then means I'm posting to the
wrong list to start with and then I wouldn't have to repost.  Anyways...

---(CC answer please)---

I'm having a strange problem with my IDE controller.  I believe (and that's
what Windows and the m/b manufaturer -- PC Chips -- say) that I have a VIA PCI
BusMaster IDE controller, and I've had some strange history with it.  I've
asked many people before on various help services, and I was able to fix my
problem with the 2.2 series, but now my fix does not work.

THE PROBLEM:
------------

Ever since the 2.2 kernel series (I remeber this working properly in 2.0.36,
without the conflicts), I would get hdc: lost interrupt during boot up, and my
system would take bloody ages to boot up and load a CD.  I tracked it down to a
strange IRQ conflict in which Linux would try to assign both the primary and
secondary IDE channels IRQ 14, causing IRQ conflicts galore.  I was able to fix
this by giving the kernel

ide1=0x170,0x376,15

at boot time.  This has worked for 2.2.12-.17 and Alan's 2.2.18pre21 (I haven't
compiled the official 2.2.18 yet, but I'm sure it will work).

I wanted to try the new 2.4.0-test series, and the first I tried was -test11,
and from what I recall (other things weren't working properly then), this fix
still worked, but now, with -test12, I am now getting the following error
repeated for a very long time (then I reboot) with the same parameters:

ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hdb: lost interrupt

Also, I get "spurious 8259A interrupt: IRQ 7" if I leave it for a while.  I
tried -test13-pre5 on somebody on #KernelNewbies' suggestion, and I get the
same error.  Scrolling up, I see that the kernel messages show that ide0 is on
IRQ 14 and ide1 is on 15.  I noticed that hda is using DMA, and hdb is using
UDMA33, but I don't believe that that is the problem.

THE QUESTION:
-------------

How do I fix this, or is it a (un)known problem in the newer development
versions?  If you have the answer, could you please CC me as well for I don't
subscribe to this mailing list (sorry!).  Thanks a bunch.
-- 
| Evan A. Thompson                     | He's more fun than trying to skinny  | 
| evaner@bigfoot.com                   | dip in the beach in winter...        |
| http://evaner.penguinpowered.com     |    ...in Winnipeg.                   |
| ICQ: 2233067 / AIM + MSN: Evaner517  |  (GnuPG key avaiable upon request.)  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
