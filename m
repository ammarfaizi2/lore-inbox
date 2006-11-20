Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934243AbWKTPjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934243AbWKTPjW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933938AbWKTPjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:39:22 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:53090 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S934244AbWKTPjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:39:12 -0500
Date: Mon, 20 Nov 2006 16:39:46 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [Patch -mm 1/1] driver core: Introduce device_move(): move a
 device to a new parent.
Message-ID: <20061120163946.38c878d7@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <1164032103.5541.12.camel@min.off.vrfy.org>
References: <20061116154210.217f2e04@gondolin.boeblingen.de.ibm.com>
	<1163695657.7900.9.camel@min.off.vrfy.org>
	<20061117042338.GA11131@kroah.com>
	<20061120090537.6d59dbc5@gondolin.boeblingen.de.ibm.com>
	<20061120135515.38298bf5@gondolin.boeblingen.de.ibm.com>
	<1164032103.5541.12.camel@min.off.vrfy.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 15:15:03 +0100,
Kay Sievers <kay.sievers@vrfy.org> wrote:

> > +void kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
> > +			int num_envp, char *envp[])
> 
> We usually use a NULL terminated array for things like this. Does
> passing the number of entries give us an advantage?

In do_kobject_uevent:

  envp = kzalloc((NUM_ENVP + num_envp) * sizeof (char *), GFP_KERNEL);

We would either need to allocate (NUM_ENVP + NUM_EXT_ENVP) or NUM_ENVP
(as before).
 
> > +{
> > +	/* Disallow dumb users. */
> > +	if (num_envp > NUM_EXT_ENVP)
> > +		return;
> 
> Why do we need such a limit? There are still thousand other ways to
> screw things up. :)

If we removed this, we could also use only NUM_ENVP in the allocation
above and kill NUM_EXT_ENVP. Hm.

> And kobject_uevent() can just call kobject_uevent_env(), there is no
> need for the indirection with do_*, right?

OK, may look nicer. I'll respin.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
