Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273405AbRINO4V>; Fri, 14 Sep 2001 10:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273406AbRINO4M>; Fri, 14 Sep 2001 10:56:12 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:15055 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S273405AbRINO4E>;
	Fri, 14 Sep 2001 10:56:04 -0400
Date: Fri, 14 Sep 2001 16:54:37 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Matthias Haase <matthias_haase@bennewitz.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: repeatable SMP lockups - kernel 2.4.9
In-Reply-To: <20010914143021.0a5c9791.matthias_haase@bennewitz.com>
Message-ID: <Pine.LNX.4.21.0109141634490.1830-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2001, Matthias Haase wrote:

> Our new SMP file- and printserver locks always hard up, if higher load
> come on the NIC. True stable without networking (X11, DRI

I have the similar problems with 4 routers here, they get quite high
network load sometimes... not really good.

> 1. First, I have changed the NIC from 3Com (vortex-driver) to noname,
> driven by Realtek
> RTL-8139 (rev 10) and the lockup occurs some later, but it occurs
> repeatable if I copy large file on LAN, or export an X11 environment to
> another box.

I used to be able to get the routers to hang in under 30minutes, but with
2.4.8-ac12 one of them survived my testing for over 36hours.

But when I put it into production thinking that it's more stable than the
other kernels it hung after 5-10minutes of operation.

> 2. Changing the kernel to 2.2.19 results the same thing.

Havn't tried any 2.2 kernels here because I want iptables.

> Donald Becker wrote, that he think, this apparently could be a bug with
> the interrupt handling in the 2.4.9 kernel, not inside
> the (his) driver itself.
> 
> The boot on the mainboard (Asus CUV266-D, 2x PIII 1 GHz, 512 mb DDR-RAM)
> is always o.k. with APIC, excepting the 'unexpected IO-APIC, please mail'
> - warning.
> The lockup occurs too with 'noapic' on boot.

Our routers consists of Asus P3C-D (i820 chipset), 2xpIII 800MHz, 256MB
rimm. As a lot of people know, the i820 chipset is very unstable _if_ you
have SDRAM but not with rimm as it was built for.

Running with 'noapic' still freezes but I don't think it occurs as
frequently as when runnign with IOAPIC.

> At third stage I can try another and 'smp-cleaner' (I think)  NIC, D-Link
> DFE-500 TX, based on DEC-Chip, using the tulip-driver.

I'm using D-Link DFE-570TX which is a quad tulip (DECchip 21143 rev 65).
I've been using both the stock driver in the kernels and an optimzed one,
I get a lockup with both.

> Nothing is wrote about this in /var/log messages. The box is SCSI only,

Just a hard lockup, it doesn't say anything at all, just a freeze,
keyboard doesn't work (not even numlock).

I also have a Adaptec 29160 card in our routers for logging to a
scsi-disk. Now that I think of it, the one I thought was stable didn't
have a SCSI-disk in it, and then I moved the flashdisk to the other router
that was in production and that died (but the logging isn't running).

> /proc/interrupts:
> 
>            CPU0       CPU1       
>   0:     273705     282423    IO-APIC-edge  timer
>   1:       4891       5117    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   8:          0          1    IO-APIC-edge  rtc
>  10:       8578       8328   IO-APIC-level  aic7xxx
>  11:     962066     961390   IO-APIC-level  mga@PCI:1:0:0, es1371
>  12:     109685     111089    IO-APIC-edge  PS/2 Mouse
>  15:       2273       2295   IO-APIC-level  eth0
> NMI:          0          0 
> LOC:     556044     556060 
> ERR:          0
> MIS:          0
> 
> 
> Looks clean :-(

Looks as clean as in my routers and then suddenly a freeze comes along and
ruins my day (I have watchdogcards but it still ruins my day knowing that
the router froze)

> Are there any patches, hints or recommendations known about this?

I havn't found anything about this at all :(

I have two of these routers right here next to my desk and I'm going to do
some heavy testing on them, one of them is the one I thought was stable
and the other one is virtually untested. I'm going to try with and without
scsi-cards and comparing BIOS-settings om them (But with my luck I'm
probably going to manage to make the "maybe stable" router freeze too.

/Martin

