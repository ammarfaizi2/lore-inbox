Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262872AbVFVIRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbVFVIRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVFVINW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 04:13:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48079 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262816AbVFVILI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:11:08 -0400
Date: Wed, 22 Jun 2005 09:11:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, mochel@digitalimplant.org, gregkh@suse.de,
       cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/16] s390: klist bus_find_device & driver_find_device callback.
Message-ID: <20050622081102.GA3976@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	mochel@digitalimplant.org, gregkh@suse.de, cohuck@de.ibm.com,
	linux-kernel@vger.kernel.org
References: <20050621162213.GA6053@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050621162213.GA6053@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +struct device * bus_find_device(struct bus_type * bus, struct device * start,
> +				void * data, int (*match)(struct device *, void *))
> +{
> +	struct klist_iter i;
> +	struct device * dev;
> +
> +	if (!bus)
> +		return NULL;
> +
> +	klist_iter_init_node(&bus->klist_devices, &i,
> +			     (start ? &start->knode_bus : NULL));
> +	while ((dev = next_device(&i)))
> +		if (match(dev, data))
> +			break;
> +	klist_iter_exit(&i);
> +	return dev;

does the klist magic somehow grab a reference for you?

