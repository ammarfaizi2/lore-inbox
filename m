Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262937AbVFVI0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbVFVI0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbVFVIWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 04:22:30 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:57924 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262894AbVFVITS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 04:19:18 -0400
Date: Wed, 22 Jun 2005 01:19:11 -0700
From: Greg KH <gregkh@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
       mochel@digitalimplant.org, cohuck@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/16] s390: klist bus_find_device & driver_find_device callback.
Message-ID: <20050622081911.GA30952@suse.de>
References: <20050621162213.GA6053@localhost.localdomain> <20050622081102.GA3976@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050622081102.GA3976@infradead.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 09:11:02AM +0100, Christoph Hellwig wrote:
> > +struct device * bus_find_device(struct bus_type * bus, struct device * start,
> > +				void * data, int (*match)(struct device *, void *))
> > +{
> > +	struct klist_iter i;
> > +	struct device * dev;
> > +
> > +	if (!bus)
> > +		return NULL;
> > +
> > +	klist_iter_init_node(&bus->klist_devices, &i,
> > +			     (start ? &start->knode_bus : NULL));
> > +	while ((dev = next_device(&i)))
> > +		if (match(dev, data))
> > +			break;
> > +	klist_iter_exit(&i);
> > +	return dev;
> 
> does the klist magic somehow grab a reference for you?

No, see my previous comment about the need for this to be fixed for
these two functions.

thanks,

greg k-h
