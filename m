Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUBNEVi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 23:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUBNEVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 23:21:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29588 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263584AbUBNEVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 23:21:36 -0500
Date: Sat, 14 Feb 2004 04:21:34 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: jt@hpl.hp.com
Cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 2.6 IrDA] new driver : stir4200
Message-ID: <20040214042134.GG8858@parcelfarce.linux.theplanet.co.uk>
References: <20040214015059.GA25979@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040214015059.GA25979@bougret.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 05:50:59PM -0800, Jean Tourrilhes wrote:

> +static void stir_disconnect(struct usb_interface *intf)
> +{
> +	struct stir_cb *stir = usb_get_intfdata(intf);
> +	struct net_device *net;
> +
> +	usb_set_intfdata(intf, NULL);
> +	if (!stir)
> +		return;
> +
> +	/* Stop transmitter */
> +	net = stir->netdev;
> +	netif_device_detach(net);
> +
> +	/* Remove netdevice */
> +	unregister_netdev(net);
> +
> +	/* No longer attached to USB bus */
> +	stir->usbdev = NULL;
> +
> +	free_netdev(net);
> +}

1)  Do we need netif_device_detach() there?  
2)  Shouldn't we leave usb_set_intfdata() until after unregister_netdev()?
