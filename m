Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261544AbSLJTLl>; Tue, 10 Dec 2002 14:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSLJTLl>; Tue, 10 Dec 2002 14:11:41 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:44046 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261544AbSLJTLj> convert rfc822-to-8bit; Tue, 10 Dec 2002 14:11:39 -0500
From: Steve Brueggeman <xioborg@yahoo.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5][Trivial] VIA Rhine Kconfig entry
Date: Tue, 10 Dec 2002 13:19:33 -0600
Organization: XIOtech
Message-ID: <tffcvu8iled7p71rg15m73o1bslo6q0qmm@4ax.com>
References: <20021208003456.GA12234@k3.hellgate.ch> <3DF2B95E.5060706@pobox.com> <20021210132814.GA10409@k3.hellgate.ch>
In-Reply-To: <20021210132814.GA10409@k3.hellgate.ch>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible that this may be related to this thread???

To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: /proc/pci deprecation?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: 09 Dec 2002 14:11:07 +0000
Cc: Richard Henderson <rth@twiddle.net>,
	Patrick Mochel <mochel@osdl.org>,
	Willy Tarreau <willy@w.ods.org>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jgarzik@pobox.com

On Mon, 2002-12-09 at 01:54, Linus Torvalds wrote:
>  - we should _never_ update the PCI_INTERRUPT_LINE register, because it
>    destroys boot loader information (the same way we need to not overwrite
>    BIOS extended areas and ACPI areas etc in order to be able to reboot
>    cleanly)

I wonder if this is why we have all these problems with VIA chipset
interrupt handling. According to VIA docs they _do_ use
PCI_INTERRUPT_LINE on integrated devices to select the IRQ routing
between APIC and PCI/ISA etc, as well as 0 meaning "IRQ disabled"

Alan



On Tue, 10 Dec 2002 14:28:14 +0100, you wrote:

>On Sat, 07 Dec 2002 22:15:42 -0500, Jeff Garzik wrote:
>> I agree about IO-APIC -- though I also think the reports that replacing 
>> via-rhine with linuxfet, and changing nothing else, helps the situation.
>> 
>> It might be something cosmetic like silly dev->tx_timeout handling, or 
>> it might be something useful like a chip-specific patch [often happens 
>> with on-mobo chips] or even a north/south-bridge-specific fixup.
>
>There are two different kinds of Rhine problems that are reportedly fixed
>by turning apic support off:
>
>a) No link, card's dead in the water
>b) Netdev watchdog triggered despite recent Tx abort fix
>
>No telling whether the cause is the same for both cases. I don't have
>sufficient data on mobos or chip sets involved and where linuxfet helps. As
>I am currently short on APIC hardware myself, I'll focus on clean ups and
>improved diagnostics for now.
>
>Roger
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

