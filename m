Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbTFEJGK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 05:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTFEJGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 05:06:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34568 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264543AbTFEJGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 05:06:09 -0400
Date: Thu, 5 Jun 2003 10:19:36 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
Message-ID: <20030605101936.D960@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	pcihpd-discuss@lists.sourceforge.net
References: <10547787473026@kroah.com> <10547787472263@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <10547787472263@kroah.com>; from greg@kroah.com on Wed, Jun 04, 2003 at 07:05:47PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 07:05:47PM -0700, Greg KH wrote:
> diff -Nru a/drivers/pci/bus.c b/drivers/pci/bus.c
> --- a/drivers/pci/bus.c	Wed Jun  4 18:11:51 2003
> +++ b/drivers/pci/bus.c	Wed Jun  4 18:11:51 2003
> @@ -129,6 +129,5 @@
>  	}
>  }
>  
> -EXPORT_SYMBOL(pci_bus_alloc_resource);
>  EXPORT_SYMBOL(pci_bus_add_devices);
>  EXPORT_SYMBOL(pci_enable_bridges);

Please don't remove this one.  Its there for stuff like:

drivers/pcmcia/cardbus.c

struct resource *
cb_alloc_io(unsigned long base, unsigned long num,
            unsigned long align, char *name, socket_info_t *s)
{
...
                ret = pci_bus_alloc_resource(bridge->bus, res, num, 1,
                                             min, 0, cardbus_adjust, &ca);
}

ie, so cardbus can decently allocate resources from the parent bus.

(Unfortunately there's a huge pile of other changes which the above
cardbus code relies on, and I fear that its getting rather late to
get them into 2.5.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

