Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbUAFNFg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 08:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbUAFNFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 08:05:36 -0500
Received: from openoffice.demon.nl ([212.238.150.237]:49157 "EHLO
	sahara.openoffice.nl") by vger.kernel.org with ESMTP
	id S263345AbUAFNFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 08:05:20 -0500
Date: Tue, 6 Jan 2004 14:05:18 +0100
From: Valentijn Sessink <linux-kernel-1073394249@mail.v.sessink.nl>
To: linux-kernel@vger.kernel.org
Subject: HiSax freezes 2.6.0-test11
Message-ID: <20040106130518.GA1182@openoffice.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

My 2.6.0-test11 "hisax" module freezes my PC, but seems to handle
interrupts, as ICMP and keyboard leds keep functioning. I sent mail to kkeil
and kai.germaschewski and to the ISDN mailing list, but no reply. I'm
willing to test and/or hunt for the bug, but don't know where to look. As
this interrupt behaviour seems rather specific, maybe someone could help me
out where to look?

I tested three HiSax cards: a Sedlbauer speed card, a Sedlbauer
Speed Win (both ISA cards, the first is non-PnP, the second PnP), and a HFC
PCI card (Dolphin PCTA128). The Sedlbauer cards do:

Sedlbauer: resetting card
Sedlbauer: speed card/win: defined at 0x280-288 IRQ 5
get_drv 0: 1->2
put_drv 0: 2->1
get_drv 0: 1->2
put_drv 0: 2->1
get_drv 0: 1->2
put_drv 0: 2->1
   ... this repeats, totalling to 9 times
Sedlbauer Speed Card: IRQ 5 count 0
get_drv 0: 1->2
put_drv 0: 2->1
get_drv 0: 1->2
put_drv 0: 2->1
... etcetera, 9 x "get_drv... put_drv".

Then a freeze occurs. Please note that this is "modprobe hisax irq=5
io=0x280", just as the previous kernel.

The HFC card is less chatty, but it detects IRQ4, then freezes after "IRQ 4
count 0"

Reading from the source, this is from config.c. line 766,
        printk(KERN_INFO "%s: IRQ %d count %d\n", CardType[cs->typ],
               cs->irq, irq_cnt);

but I don't know enough about IRQ handling (and more generally, kernel
programming) to grasp what's going on here. I tried two kernel
configurations, the last one without CAPI support (as there's no CAPI for my
ISDN cards anyway), but that doesn't help.

I'd be glad to solve this, but don't know where to look now. You probably
know what's going on - do you have patches that I can try? I'm willing to
recompile my kernel and/or perform tests.

HW info: IBM Aptiva with Cyrix processor, 3 PCI and 3 ISA slots, one
harddisk. Most of the on board hardware is turned off (no parport, no
serial, no USB). This machine used to run a rather ancient 2.2.16 (which is
no problem as it doesn't have any outside connections and runs no user
services), ISDN worked under that. The machine runs Debian 3.0 with
module-init-tools. I compiled the kernel with gcc version 2.95.4
20011002 (Debian prerelease). If recompiling with gcc3.2 is necessary,
please say so.
CONFIG_ISDN=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_ISDN_PPP_BSDCOMP=m
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y
# CONFIG_ISDN_DRV_LOOP is not set
CONFIG_ISDN_DRV_HISAX=m
CONFIG_HISAX_EURO=y
all passive hisax cards are "y", rest is "n". If you need the complete
kernel info or if you need other information, please say so.

=======
On a completely unrelated sidenote and very low on my priority list: I had
some problems with 3c509 on 2.6.0. Compiling CONFIG_PNP=Y, CONFIG_ISAPNP=N
resulted in a non working driver (I assume this is by design). Then "rmmod
3c509" on a working driver resulted in oopses and a - when configured with
IP addresses on a local network - a real panic. It seems the unload code
leaves things around - if I find time I'll try to find out where.

Best regards,

Valentijn
-- 
http://www.openoffice.nl/   Open Office - Linux Office Solutions
Valentijn Sessink  valentyn+sessink@nospam.openoffice.nl
