Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTDHE1h (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 00:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263931AbTDHE1h (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 00:27:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8597 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263930AbTDHE1e (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 00:27:34 -0400
Message-ID: <3E925292.8060104@pobox.com>
Date: Tue, 08 Apr 2003 00:39:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: SET_MODULE_OWNER?
References: <20030408035211.12EA02C225@lists.samba.org>
In-Reply-To: <20030408035211.12EA02C225@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <Pine.LNX.4.50.0304072212310.21025-100000@montezuma.mastecende.com> 
> you write:
> 
>>(e.g. pci-dma api changes). Regardless, here is a typical use in a 
>>netdriver.
>>
>>	/* dev and dev->priv zeroed in alloc_etherdev */
>>	dev = alloc_etherdev (sizeof (*tp));
>>	if (dev == NULL) {
>>		printk (KERN_ERR PFX "%s: Unable to alloc new net device\n", pd
> 
> ev->slot_name);
> 
>>		return -ENOMEM;
>>	}
>>	SET_MODULE_OWNER(dev);
>>	tp = dev->priv;
>>	
>>	/* followed by ... */
>>	dev->foo = __foo;
>>	dev->bar = __bar;
> 
> 
> I don't understand how that helps compatibility over:
> 
> 	dev->owner = THIS_MODULE;
> 
> Both will:
> 1) Work on 2.4 and 2.5
> 2) Break on 2.2.


Wrong.

SET_MODULE_OWNER works in 2.2 _and earlier_... given some compat glue in 
a "#include <kcompat>" macros.

You may take a look at "kcompat" for further examples. 
http://sf.net/projects/gkernel/   I provide an example of how to get a 
net driver from 2.4 running under 2.2, such that the 2.4 driver 
-appears- to be completely free of compatibility glue.

The only sticking points in such glue are when structure members are 
directly exposed in the source code.  That cannot be worked around with 
cpp magic.  This is why SET_MODULE_OWNER exists, this is why 
pci_{get,set}_drvdata() exist, and so on.

	Jeff



