Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbVJVDON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbVJVDON (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 23:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVJVDON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 23:14:13 -0400
Received: from mailhub.hp.com ([192.151.27.10]:13523 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S932576AbVJVDOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 23:14:12 -0400
Message-ID: <60987.24.9.204.52.1129950852.squirrel@mail.atl.hp.com>
In-Reply-To: <1129930114.5932.6.camel@whizzy>
References: <59D45D057E9702469E5775CBB56411F190A57F@pdsmsx406> 
    <1129053267.15526.9.camel@whizzy> <1129679877.30588.5.camel@whizzy> 
    <200510190929.06728.bjorn.helgaas@hp.com> 
    <1129740711.31966.21.camel@whizzy>  <20051019165940.GA2177@kroah.com>
    <1129930114.5932.6.camel@whizzy>
Date: Fri, 21 Oct 2005 21:14:12 -0600 (MDT)
Subject: Re: [ACPI] Re: [Pcihpd-discuss] RE: [patch 2/2] acpi: add ability 
     to derive irq when doing a surpriseremoval of an adapter
From: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
To: "Kristen Accardi" <kristen.c.accardi@intel.com>
Cc: "Greg KH" <greg@kroah.com>, "Bjorn Helgaas" <bjorn.helgaas@hp.com>,
       acpi-devel@lists.sourceforge.net, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, "Shah, Rajesh" <rajesh.shah@intel.com>,
       "Brown, Len" <len.brown@intel.com>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
> +
> +	/*
> +	 * If a device has been "surprise" removed via
> +	 * hotplug, the pin value will be invalid
> +	 * In this case, we should use the stored
> +	 * pin value from the pci_dev structure
> +	 */
> +	if (pin == 0xff)
> +		pin = dev->pin;

I think you should just always use dev->pin, and don't even
bother trying the pci_read_config_byte().  Fewer code paths
to worry about that way.

Bjorn

