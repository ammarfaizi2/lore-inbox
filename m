Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbULVTyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbULVTyW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 14:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbULVTyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 14:54:22 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:61150 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262026AbULVTyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 14:54:01 -0500
Message-ID: <41C9D0B8.9000208@sgi.com>
Date: Wed, 22 Dec 2004 13:53:28 -0600
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, matthew@wil.cx
Subject: Re: [PATCH] 2.6.10 Altix : ioc4 serial driver support
References: <200412220028.iBM0SB3d299993@fsgi900.americas.sgi.com> <20041222134423.GA11750@infradead.org>
In-Reply-To: <20041222134423.GA11750@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> So both claim the same PCI ID?  In this case you need to creat a small
> shim driver that exports a pseudo-bus to the serial and ide driver using
> the driver model.  You must never return an error from ->probe if you
> actually use that particular device.
> 

Has this been done before ? Any example I can use ??


> 
> +/* defining this will force the driver to run in polled mode */
> +//#define POLLING_FOR_CHARACTERS
> 
> Again, what's the need for these conditionals?
> 

Most of these are compile options to use/not use particular things/"features". Some were
used during debugging. It's a small thing, I'll delete.


> 
> +/* a table to keep the card names as passed to request_region */
> +static struct {
> +	char c_name[20];
> +} Table_o_cards[IOC4_NUM_CARDS];
> 
> Completely superflous.  Just pass "ioc4_serial" as argument to request_region.
> 

WHAT ?!?!?!?  Then I get nice output that actually identifies each card when I have >1. 8^) Not a 
big thing, I'll delete.


> +
> +	switch (type) {
> +	case IOC4_SIO_INTR_TYPE:
> +		switch (which) {
> +		case IOC4_W_IES:
> +			writel(val, (void *)&mem->sio_ies_ro);
> 
> The second argumnet to writeX (and readX) is actually void __iomem *,
> but to see the difference you need to run sparse (from sparse.bkbits.net)
> over the driver.  Please store all I/O addresses in void __iomem * pointers
> in your structures and avoid the cast here and in all the other places.
> 

So then I'd have to declare the end elements as:
void __iomem foo;

They are 32 bit values, so it's OK to assume that void __iomem is 32bits ?

FWIW I did run sparse and it didn't complain about the readX/writeX.....


> no need to cast the return value from kmalloc (dito for the other places)
> 

Why is that ? Seems if kmalloc returns a void * and the left side is not, a casting is appropriate ?

-- Pat
