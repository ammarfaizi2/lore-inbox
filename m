Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVCGWLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVCGWLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVCGWF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:05:57 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:32683 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261341AbVCGV2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:28:25 -0500
Date: Mon, 7 Mar 2005 16:26:14 -0500
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel hangs on PCI config register access ???
Message-ID: <20050307212613.GF16456@neo.rr.com>
Mail-Followup-To: amb@neo.rr.com,
	Matthias Urlichs <smurf@smurf.noris.de>, linux-kernel@vger.kernel.org
References: <pan.2005.02.18.07.49.57.620452@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2005.02.18.07.49.57.620452@smurf.noris.de>
User-Agent: Mutt/1.5.6+20040907i
From: amb@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 08:49:58AM +0100, Matthias Urlichs wrote:
> Hi,
> 
> we have a bunch of systems which semi-reproducibly (chance of 1:1000) hang
> when a PCMCIA card is removed from its PCI->PCMCIA interface via "cardctl
> eject". Right *here*, in fact:
> 
> static int pci_conf1_read (int seg, int bus, int devfn, int reg, int
> len, + u32 *value) {
>     [...]
>     case 2:
>         debug("you see me \n");
>         *value = inw(0xCFC + (reg & 2));
>         debug("but you don't get here \n");
>         break;
>     [...]
> 
> Does anybody have *any* idea what could possibly be the cause of this?
> Using pci=bios still hangs; pci=conf2 doesn't work.
> 
> FWIW, the call sequence is:
> 
> shutdown_socket
> yenta_sock_init
> yenta_clear_maps
> yenta_set_socket
> pci_bus_read_config_word
> pci_conf1_read
> 
> The systems in question are wildly different (VIA vs. Intel CPUs, standard
> mainboard vs. PCI backplane, Ricoh vs. ENE cardbus bridges), so I'm
> inclined to rule out hardware problems. The NMI monitor doesn't trigger
> (yes I tested it), kgdb is unresponsive -- the system hangs hard at that
> point, as far as I can determine.
> 
> Kernel: tested with various 2.6.1? plus -rc* and/or -mm*, no change.

Is this still an issue with recent kernels?

Where in the PCI configuration space is it reading?  In other words, could you
show me the line that calls pci_bus_read_config_word.

Thanks,
Adam
