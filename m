Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbTDHDkg (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 23:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263925AbTDHDkg (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 23:40:36 -0400
Received: from dp.samba.org ([66.70.73.150]:57511 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263923AbTDHDkd (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 23:40:33 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, "" <linux-kernel@vger.kernel.org>,
       "" <hch@infradead.org>
Subject: Re: SET_MODULE_OWNER? 
In-reply-to: Your message of "Mon, 07 Apr 2003 22:16:55 -0400."
             <Pine.LNX.4.50.0304072212310.21025-100000@montezuma.mastecende.com> 
Date: Tue, 08 Apr 2003 13:41:12 +1000
Message-Id: <20030408035211.12EA02C225@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.50.0304072212310.21025-100000@montezuma.mastecende.com> 
you write:
> (e.g. pci-dma api changes). Regardless, here is a typical use in a 
> netdriver.
> 
> 	/* dev and dev->priv zeroed in alloc_etherdev */
> 	dev = alloc_etherdev (sizeof (*tp));
> 	if (dev == NULL) {
> 		printk (KERN_ERR PFX "%s: Unable to alloc new net device\n", pd
ev->slot_name);
> 		return -ENOMEM;
> 	}
> 	SET_MODULE_OWNER(dev);
> 	tp = dev->priv;
> 	
> 	/* followed by ... */
> 	dev->foo = __foo;
> 	dev->bar = __bar;

I don't understand how that helps compatibility over:

	dev->owner = THIS_MODULE;

Both will:
1) Work on 2.4 and 2.5
2) Break on 2.2.

Confused,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
