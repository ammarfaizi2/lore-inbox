Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbTDHCKI (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 22:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263872AbTDHCKI (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 22:10:08 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:37700
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263869AbTDHCKH (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 22:10:07 -0400
Date: Mon, 7 Apr 2003 22:16:55 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Jeff Garzik <jgarzik@pobox.com>, "" <linux-kernel@vger.kernel.org>,
       "" <hch@infradead.org>
Subject: Re: SET_MODULE_OWNER? 
In-Reply-To: <20030408021239.1155C2C4EE@lists.samba.org>
Message-ID: <Pine.LNX.4.50.0304072212310.21025-100000@montezuma.mastecende.com>
References: <20030408021239.1155C2C4EE@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Apr 2003, Rusty Russell wrote:

> I still don't understand: please demonstrate a use in existing source.
> Rusty.

I do agree it only does something which we do manually with a lot of the 
other members, however i'm not quite sure wether the compatibility thing 
still holds since a number of drivers have a lot of 2.5 specific stuff 
(e.g. pci-dma api changes). Regardless, here is a typical use in a 
netdriver.

	/* dev and dev->priv zeroed in alloc_etherdev */
	dev = alloc_etherdev (sizeof (*tp));
	if (dev == NULL) {
		printk (KERN_ERR PFX "%s: Unable to alloc new net device\n", pdev->slot_name);
		return -ENOMEM;
	}
	SET_MODULE_OWNER(dev);
	tp = dev->priv;
	
	/* followed by ... */
	dev->foo = __foo;
	dev->bar = __bar;


	Zwane

--
function.linuxpower.ca
