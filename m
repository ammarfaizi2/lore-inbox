Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUDNVIJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 17:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUDNVII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 17:08:08 -0400
Received: from cpe-024-033-224-95.neo.rr.com ([24.33.224.95]:64132 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261746AbUDNVHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 17:07:52 -0400
Date: Wed, 14 Apr 2004 05:08:38 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Confused about 2.6 PnP support
Message-ID: <20040414050838.GB8473@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20040412170515.GA670@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040412170515.GA670@DervishD>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 07:05:15PM +0200, DervishD wrote:
>     Hi all :)
> 
>     I'm on the way of upgrading to 2.6.x kernel, and since I don't
> have ISA cards (I don't even have an ISA bus in my mobo), I disabled
> ISA support in my config (CONFIG_ISA), but I've noticed that PnP
> support (CONFIG_PNP) depends on it :?
> 
>     AFAIK, PnP, strictly speaking, has nothing to do with the PCI
> bus, but I think is common notation to talk about PnP referring
> autoconfiguration of PCI cards, and I want to know if I need to
> select PCI support for having my PCI cards correctly detected and
> configured (currently my BIOS does the work), or if the PnP support
> in kernel 2.6 is just for ISA cards. In addition to this, the PnP
> BIOS support (which I think I may need so Linux correctly gets the
> IO, IRQ and DMA settings for my parallel port) is marked as
> EXPERIMENTAL (at least in 2.6.5)

In this context PnP is refering to configuration of system and ISA
devices.  PnPBIOS support should be safe but faults on boot for a few
buggy systems.  Because the recovery code has been fixed, this should
be less of a problem.  If you see a message indicating that a pnp
device was activated as the parport driver loads then you need PnPBIOS
support to properly use it.  If not, then PnPBIOS will still aid in the
device's detection process.

>
>     I want to know if I must tell my BIOS I don't have a PnP OS or
> if, on the contrary, I should tell my BIOS that my OS is not PnP (I
> only use Linux) and deselect PnP support (as well as ISA support) in
> my 2.6.x kernel. Personally, I don't mind setting 'Non PnP OS' in my
> BIOS and remove both CONFIG_ISA and CONFIG_PNP.

If you are using PnPBIOS support then set PNP OS to "yes", otherwise use
"no".

>
>     BTW, ?does Linux support rebalancing of PnP bus resources or I
> better avoid conflicts...?

Yes, see sysfs and drivers/pnp/interface.c.  Resources can be reallocated
but only if the device is not bound to a driver (modules are useful for this).

>
>     Thanks a lot in advance :)
>
>     Ra?l N??ez de Arenas Coronado
>

Regards,
Adam
