Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVF0IMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVF0IMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 04:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVF0IMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 04:12:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42769 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261901AbVF0ILx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 04:11:53 -0400
Date: Mon, 27 Jun 2005 09:11:46 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm2
Message-ID: <20050627091146.B7934@flint.arm.linux.org.uk>
Mail-Followup-To: Grant Coady <grant_lkml@dodo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050626040329.3849cf68.akpm@osdl.org> <20050626124219.G14862@flint.arm.linux.org.uk> <didub15c1ucfs9t23opuvvm3a0rapikeoq@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <didub15c1ucfs9t23opuvvm3a0rapikeoq@4ax.com>; from grant_lkml@dodo.com.au on Mon, Jun 27, 2005 at 09:17:34AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 09:17:34AM +1000, Grant Coady wrote:
> Not the case for where I'm having problems, Toshiba laptop, more 
> info on http://scatter.mine.nu/test/linux-2.6/tosh/

Yes in this case.  The PCI resources are the ones which say either
PCI CardBus, PCI Bus, or are of the format: xxxx:xx:xx.x, and all
of them are missing.

The ESS Maestro and others which were below these are driver
resources created by the drivers themselves, not the PCI subsystem.
Hence these still show up.

> --- ioports-2.6.12.1a   2005-06-27 09:00:21.000000000 +1000
> +++ ioports-2.6.12-mm2a 2005-06-27 09:03:44.000000000 +1000
> @@ -10,20 +10,13 @@
>  00f0-00ff : fpu
>  0170-0177 : ide1
>  01f0-01f7 : ide0
> -02f8-02ff : 0000:00:07.0
>  0376-0376 : ide1
>  0378-037a : parport0
>  03c0-03df : vesafb
>  03f6-03f6 : ide0
>  03f8-03ff : serial
>  0cf8-0cff : PCI conf1
> -1c00-1cff : 0000:00:07.0
> -4000-40ff : PCI CardBus #02
> -  4000-407f : 0000:02:00.0
> -    4000-407f : xircom_cb
> -4400-44ff : PCI CardBus #02
> -fc00-fcff : 0000:00:0c.0
> -  fc00-fcff : ESS Maestro
> +fc00-fcff : ESS Maestro
>  fd00-fd3f : motherboard
>  fe00-fe3f : 0000:00:05.3
>    fe00-fe3f : motherboard
> @@ -40,8 +33,6 @@
>  fe90-fe97 : motherboard
>  fe9e-fe9e : motherboard
>  feac-feac : motherboard
> -ff80-ff9f : 0000:00:05.2
> -  ff80-ff9f : uhci_hcd
> -fff0-ffff : 0000:00:05.1
> -  fff0-fff7 : ide0
> -  fff8-ffff : ide1
> +ff80-ff9f : uhci_hcd
> +fff0-fff7 : ide0
> +fff8-ffff : ide1
> 
> lilo.conf:
> image = /boot/bzImage-2.6.12-mm2a
>   optional
>   label = 2.6.12-mm2ap
>   append="pci=assign-busses"
> 
> --- ioports-2.6.12.1a   2005-06-27 09:00:21.000000000 +1000
> +++ ioports-2.6.12-mm2ap        2005-06-27 09:06:31.000000000 +1000
> @@ -10,20 +10,13 @@
>  00f0-00ff : fpu
>  0170-0177 : ide1
>  01f0-01f7 : ide0
> -02f8-02ff : 0000:00:07.0
>  0376-0376 : ide1
>  0378-037a : parport0
>  03c0-03df : vesafb
>  03f6-03f6 : ide0
>  03f8-03ff : serial
>  0cf8-0cff : PCI conf1
> -1c00-1cff : 0000:00:07.0
> -4000-40ff : PCI CardBus #02
> -  4000-407f : 0000:02:00.0
> -    4000-407f : xircom_cb
> -4400-44ff : PCI CardBus #02
> -fc00-fcff : 0000:00:0c.0
> -  fc00-fcff : ESS Maestro
> +fc00-fcff : ESS Maestro
>  fd00-fd3f : motherboard
>  fe00-fe3f : 0000:00:05.3
>    fe00-fe3f : motherboard
> @@ -40,8 +33,6 @@
>  fe90-fe97 : motherboard
>  fe9e-fe9e : motherboard
>  feac-feac : motherboard
> -ff80-ff9f : 0000:00:05.2
> -  ff80-ff9f : uhci_hcd
> -fff0-ffff : 0000:00:05.1
> -  fff0-fff7 : ide0
> -  fff8-ffff : ide1
> +ff80-ff9f : uhci_hcd
> +fff0-fff7 : ide0
> +fff8-ffff : ide1
> 
> --Grant.
> 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
