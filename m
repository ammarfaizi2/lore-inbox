Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129823AbRABDEx>; Mon, 1 Jan 2001 22:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbRABDEo>; Mon, 1 Jan 2001 22:04:44 -0500
Received: from cd168990-a.ctjams1.mb.wave.home.com ([24.108.112.42]:1920 "EHLO
	cd168990-a.ctjams1.mb.wave.home.com") by vger.kernel.org with ESMTP
	id <S129823AbRABDEg>; Mon, 1 Jan 2001 22:04:36 -0500
Date: Mon, 1 Jan 2001 20:34:09 -0600
From: Evan Thompson <evaner@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: Additional info. for PCI VIA IDE crazyness.  Please read.
Message-ID: <20010101203409.A335@evaner.penguinpowered.com>
Reply-To: evaner@bigfoot.com
Mail-Followup-To: Evan Thompson <evaner@bigfoot.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IN ADVANCE:  I'm sorry for this being so long, but I'm just trying to
make sure people understand what my problem is.  If you need more info,
I'll be happy to give as much as I can, just give me a reply.

Okay.  Many of you already know the problems I'm having with my PCI VIA
IDE controller.  I've done a bit of additional testing and I think I
have found out what the problem is.  The only problem is that I'm not
too versed in kernel programming (I'm getting there, but still don't
understand some more complex C ideas), and therefore cannot fix this.

-- THE PROBLEM --

I know that any kernel version in the 2.2, 2.3, 2.3.99pre series and
2.4.0-test kernels =<2.4.0-test11, I need to append
'ide1=0x170,0x376,15' to get my (so called) PCI VIA IDE controller to
put the secondary channel on IRQ 15 (otherwise, it'd put it on IRQ 14,
causing hdc/hdd: lost interrupt errors and would take 5 or so minutes
too boot).

--

WHAT I HAVE FOUND NOW, is that something has changed from 2.4.0-test11
to 2.4.0-test12 in either the ide implimentation or with IRQ handling
(although there was only one change in irq.c -- something going from
and int to a long) that has caused my system to complain about hdb:
lost interrupt, and refuses to boot.

I used the EXACT SAME configuration for both -test11 and -test12, and
11 worked properly, and 12 causes problems (see above).  I was clever
enough to add printer console support to my kernel, and was able to
print out the kernel messages for -test12 (I didn't need to print out
-test11's messages, but the support was still in the kernel).  After
comparing the output, the only relavent change I found was the addition
of this line in the kernel message:

2.4.0-test11:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: 100% native mode on irq 14

TO 2.4.0-test12:

 Uniform Multi-Platform E-IDE driver Revision: 6.31
 ide: Assuming 33MHz system bus speed for PIO modes; override with
     idebus=xx
 VP_IDE: IDE controller on PCI bus 00 dev 39
+PCI: Assigned IRQ 14 for device 00:07.1 
 VP_IDE: chipset revision 6
 VP_IDE: 100% native mode on irq 14

(notice the new line idicated with the '+').

--

If I haven't given enough information, don't hesitate to ask for more.
I'd like some reply to this situation because it just seems odd for
this to happen.  Like I said eariler, if I knew what to do, I'd be
happy to submit a patch, but I'm still learning C, so I'm not capable
to do that yet.  Thanks in advance,
-- 
| Evan Thompson                    | ICQ:    2233067   |
| Freelance Computer Nerd          | AIM:    Evaner517 |
| evaner@bigfoot.com               | Yahoo!: evanat    |
| http://evaner.penguinpowered.com | MSN:    evaner517 |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
