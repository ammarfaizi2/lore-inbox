Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbVKWWxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbVKWWxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVKWWxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:53:12 -0500
Received: from mail.dvmed.net ([216.237.124.58]:35718 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030454AbVKWWxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:53:08 -0500
Message-ID: <4384F2D1.9090900@pobox.com>
Date: Wed, 23 Nov 2005 17:53:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Grover <andrew.grover@intel.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, christopher.leech@intel.com
Subject: Re: [RFC] [PATCH 3/3] ioat: testclient
References: <Pine.LNX.4.44.0511231217340.32487-100000@isotope.jf.intel.com>
In-Reply-To: <Pine.LNX.4.44.0511231217340.32487-100000@isotope.jf.intel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Andrew Grover wrote: > diff --git
	a/drivers/dma/testclient.c b/drivers/dma/testclient.c > new file mode
	100644 > index 0000000..9bfb979 > --- /dev/null > +++
	b/drivers/dma/testclient.c > @@ -0,0 +1,132 @@ > +/ > + > + > +
	Copyright(c) 2004 - 2005 Intel Corporation. All rights reserved. > + >
	+ This program is free software; you can redistribute it and/or modify
	it > + under the terms of the GNU General Public License as published
	by the Free > + Software Foundation; either version 2 of the License,
	or (at your option) > + any later version. > + > + This program is
	distributed in the hope that it will be useful, but WITHOUT > + ANY
	WARRANTY; without even the implied warranty of MERCHANTABILITY or > +
	FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
	for > + more details. > + > + You should have received a copy of the
	GNU General Public License along with > + this program; if not, write
	to the Free Software Foundation, Inc., 59 > + Temple Place - Suite 330,
	Boston, MA 02111-1307, USA. > + > + The full GNU General Public License
	is included in this distribution in the > + file called LICENSE. > + >
	+/ > + > +#include <linux/module.h> > +#include <linux/init.h> >
	+#include <linux/device.h> > +#include <linux/dmaengine.h> > +#include
	<linux/delay.h> > +#include <asm/io.h> > + > +/* MODULE API */ > + >
	+static volatile u8 *buffer1; > +static volatile u8 *buffer2; [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Grover wrote:
> diff --git a/drivers/dma/testclient.c b/drivers/dma/testclient.c
> new file mode 100644
> index 0000000..9bfb979
> --- /dev/null
> +++ b/drivers/dma/testclient.c
> @@ -0,0 +1,132 @@
> +/*******************************************************************************
> +
> +  
> +  Copyright(c) 2004 - 2005 Intel Corporation. All rights reserved.
> +  
> +  This program is free software; you can redistribute it and/or modify it 
> +  under the terms of the GNU General Public License as published by the Free 
> +  Software Foundation; either version 2 of the License, or (at your option) 
> +  any later version.
> +  
> +  This program is distributed in the hope that it will be useful, but WITHOUT 
> +  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
> +  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for 
> +  more details.
> +  
> +  You should have received a copy of the GNU General Public License along with
> +  this program; if not, write to the Free Software Foundation, Inc., 59 
> +  Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> +  
> +  The full GNU General Public License is included in this distribution in the
> +  file called LICENSE.
> +  
> +*******************************************************************************/
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/dmaengine.h>
> +#include <linux/delay.h>
> +#include <asm/io.h>
> +
> +/* MODULE API */
> +
> +static volatile u8 *buffer1;
> +static volatile u8 *buffer2;

why do you think volatile is needed?


> +struct dma_client *test_dma_client;
> +struct dma_chan *test_dma_chan;
> +static dma_cookie_t cookie;
> +
> +void
> +test_added_chan(void)
> +{
> +	int i;
> +
> +	printk("buffer1 = %p\n", buffer1);
> +	printk("buffer2 = %p\n", buffer2);
> +	for (i = 0; i < 20; i+=4)
> +		printk("%u %u %u %u\n", buffer2[i], buffer2[i+1], buffer2[i+2], buffer2[i+3]);
> +
> +//	for (i = 0; i < 10; i++) {
> +	cookie = dma_async_memcpy_buf_to_buf(test_dma_chan, 
> +		(void *)buffer2,
> +		(void *)buffer1,
> +		2000);
> +	dma_async_memcpy_issue_pending(test_dma_chan);
> +//	}
> +//	printk("dma cookie = %i\n", cookie);
> +	if (dma_async_memcpy_complete(test_dma_chan, cookie, NULL, NULL) == DMA_IN_PROGRESS)
> +		printk("DMA cookie == IN PROGRESS\n");
> +	else
> +		printk("DMA cookie == SUCCESS\n");
> +#if 0
> +	for (i = 0; i < 1000; i++) {
> +		if (buffer2[1] != 0)
> +			break;
> +		mdelay(1);

ummm....


> +	printk("i = %d\n", i);
> +	for (i = 0; i < 20; i+=4)
> +		printk("%u %u %u %u\n", buffer2[i], buffer2[i+1], buffer2[i+2], buffer2[i+3]);
> +	for (i = 0; i < 20; i+=4)
> +		printk("%u %u %u %u\n", buffer1[i], buffer1[i+1], buffer1[i+2], buffer1[i+3]);
> +#endif
> +}
> +
> +void test_dma_event(struct dma_client *client, struct dma_chan *chan, enum dma_event_t event)
> +{
> +	switch (event) {
> +	case DMA_RESOURCE_ADDED:
> +		test_dma_chan = chan;
> +		test_added_chan();
> +		break;
> +	case DMA_RESOURCE_REMOVED:
> +		test_dma_chan = NULL;
> +		break;
> +	default:
> +		break;
> +	}
> +}

what keeps DMA_RESOURCE_ADDED from being called multiple times?
What happens when there is more than one resource?
dma_async_client_chan_request(...,1) prevents this, perhaps?


> +static int __init
> +testclient_init_module(void)
> +{
> +	int i;
> +
> +	buffer1 = kmalloc(sizeof(u8) * 2000, SLAB_KERNEL);
> +	buffer2 = kmalloc(sizeof(u8) * 2000, SLAB_KERNEL);
> +	memset((void *)buffer2, 0, 2000);

1) GFP_KERNEL not SLAB_KERNEL

2) kzalloc()

3) be consistent:  either use "2000" or "sizeof * 2000"


> +	for (i = 0; i < 2000; i++)
> +		buffer1[i] = i;
> +	test_dma_client = dma_async_client_register(test_dma_event);
> +	if (!test_dma_client) {
> +		printk(KERN_ERR "Could not register dma client!\n");
> +		return 0;
> +	}
> +
> +	dma_async_client_chan_request(test_dma_client, 1);
> +
> +	return 0;
> +}
> +
> +module_init(testclient_init_module);
> +
> +static void __exit
> +testclient_exit_module(void)
> +{
> +	int i;
> +	for (i = 0; i < 20; i+=4)
> +		printk("%u %u %u %u\n", buffer2[i], buffer2[i+1], buffer2[i+2], buffer2[i+3]);
> +	if (dma_async_memcpy_complete(test_dma_chan, cookie, NULL, NULL) == DMA_SUCCESS)
> +		printk("DMA cookie == SUCCESS\n");
> +	else
> +		printk("DMA cookie == IN PROGRESS\n");
> +
> +	dma_async_client_unregister(test_dma_client);
> +}
> +
> +module_exit(testclient_exit_module);
> +
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

