Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289067AbSAGAyc>; Sun, 6 Jan 2002 19:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289065AbSAGAyW>; Sun, 6 Jan 2002 19:54:22 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:6418 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289063AbSAGAyN>; Sun, 6 Jan 2002 19:54:13 -0500
Message-ID: <3C38F077.32064893@zip.com.au>
Date: Sun, 06 Jan 2002 16:48:55 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Pitchford <cpitchford@intrepid.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Ethernet/SCSI/PCI problems when enabling SMP on 2.4.17: VP6, 
 aix7xxx& 3c595
In-Reply-To: <Pine.LNX.4.33.0201062057400.18876-100000@boatman.intrepnet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Pitchford wrote:
> 
> Hi all,
> 
> I am experiencing problems using a 3Com Network card and Adaptec SCSI
> card under 2.4.17 in SMP mode. Since the only other PCI card in my system
> is a very under used sound card I am wondering if this is a deeper
> problem with SMP under Linux on my system.
> 
> I recently installed two Intel P3 Coppermine processors onto my Abit
> VP6 motherboard and recompiled my kernel as SMP. I am seeing
> problems that never once occured during the month I ran the system
> with one P3 processor in UP mode.
> 
> During light network load I am seeing messages appear frequently in the
> kernel messages and the network card stop receiving/transmitting traffic
> out onto the network. This did not happen (and does not happen) when
> running Uni-processor:
> 
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out, tx_status 00 status e000.
>   diagnostics: net 0c80 media 88c0 dma ffffffff.
> eth0: Updating statistics failed, disabling stats as an interrupt source.
>

I've never seen that one before.  There's this comment in the source:

        update_stats(ioaddr, dev);
        /* HACK: Disable statistics as an interrupt source. */                                    /* This occurs when we have the wrong media type! */
        if (DoneDidThat == 0  &&
            inw(ioaddr + EL3_STATUS) & StatsFull) {
            printk(KERN_WARNING "%s: Updating statistics failed, disabling "
                   "stats as an interrupt source.\n", dev->name);

But it looks like you don't have the wrong media type?  Please check
this.


The 3c595 is ancient, and there are numerous reports of PCI bus
problems with it.  Fiddling with the PCI latency timers sometimes
helps.

My advice: buy another NIC.  Even a ten-dollar rtl8139 will
perform better than the 3c595.  Sorry.

-
