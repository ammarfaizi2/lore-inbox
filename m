Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289070AbSAGBnF>; Sun, 6 Jan 2002 20:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289073AbSAGBnB>; Sun, 6 Jan 2002 20:43:01 -0500
Received: from cptf-adsl.demon.co.uk ([62.49.1.93]:5779 "HELO
	boatman.intrepid.co.uk") by vger.kernel.org with SMTP
	id <S289070AbSAGBmT>; Sun, 6 Jan 2002 20:42:19 -0500
Date: Mon, 7 Jan 2002 01:42:14 +0000 (GMT)
From: Chris Pitchford <cpitchford@intrepid.co.uk>
X-X-Sender: <cpitchford@boatman.intrepnet>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Ethernet/SCSI/PCI problems when enabling SMP on 2.4.17: VP6, 
 aix7xxx& 3c595
In-Reply-To: <3C38F077.32064893@zip.com.au>
Message-ID: <Pine.LNX.4.33.0201070135190.23157-100000@boatman.intrepnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Jan 2002, Andrew Morton wrote:

> Chris Pitchford wrote:
> >
> > Hi all,
> >
> > ....
> >
> > NETDEV WATCHDOG: eth0: transmit timed out
> > eth0: transmit timed out, tx_status 00 status e000.
> >   diagnostics: net 0c80 media 88c0 dma ffffffff.
> > eth0: Updating statistics failed, disabling stats as an interrupt source.
> >
>
> I've never seen that one before.  There's this comment in the source:
>
>         update_stats(ioaddr, dev);
>         /* HACK: Disable statistics as an interrupt source. */                                    /* This occurs when we have the wrong media type! */
>         if (DoneDidThat == 0  &&
>             inw(ioaddr + EL3_STATUS) & StatsFull) {
>             printk(KERN_WARNING "%s: Updating statistics failed, disabling "
>                    "stats as an interrupt source.\n", dev->name);
>
> But it looks like you don't have the wrong media type?  Please check
> this.
>
>
> The 3c595 is ancient, and there are numerous reports of PCI bus
> problems with it.  Fiddling with the PCI latency timers sometimes
> helps.
>
> My advice: buy another NIC.  Even a ten-dollar rtl8139 will
> perform better than the 3c595.  Sorry.


I'm going to see if I can't get my hands on an intel card from work.. but
my point was this does not happen when I run a UP processor kernel, only
when SMP.. However, specifying "noapic" on the kernel cmdline dropped me
back to the traditional 0-15 IRQ mappings and the problems disappeared.
Does this mean it is an APIC problem with this VIA chipset? I like a
challenge, I'll look at more kernel source!

I also tried changing the latency settings in the BIOS from 32 to 64 as
suggested, but my machine hard hung (possibly a SCSI problem since the
tap drive was doing something at the time) and on a reboot my ext3 root
file system (and it was raid-1 too ) was completely foobar'd. I'm
currently restoring from a backup, hurray for DDS3! Note that this was NOT
with the noapic option at the time. Still, win some, lose some. My first
serious failure in 4 years! nice going really!

Anyway, back to the point. It seems that these problems are as a result of
having apic turned on. I'm going to try enabling the local-apic on
uni-processors option and giving that a go with one CPU, see if the
problem recurs. At the moment I really feel I'm grasping at straws and
perhaps shouldn't be fiddling with kernel code on a fileserver :)

Thanks for all the help though. If any more suggestions of things I can
look at it'd be much appreciated!

Cheers

Chris





