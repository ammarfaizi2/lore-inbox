Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265792AbUG1W7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUG1W7L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266780AbUG1W7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:59:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:17062 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267317AbUG1W6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:58:39 -0400
Date: Wed, 28 Jul 2004 16:00:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg Howard <ghoward@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix system controller communication driver
Message-Id: <20040728160033.63205d60.akpm@osdl.org>
In-Reply-To: <Pine.SGI.4.58.0407281641210.1656@gallifrey.americas.sgi.com>
References: <Pine.SGI.4.58.0407271457240.1364@gallifrey.americas.sgi.com>
	<20040728085737.26e0bfd2.akpm@osdl.org>
	<Pine.SGI.4.58.0407281641210.1656@gallifrey.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Howard <ghoward@sgi.com> wrote:
>
> > > +static unsigned int
> > > +scdrv_poll(struct file *file, struct poll_table_struct *wait)
> > > +{
> > > +	unsigned int mask = 0;
> > > +	int status = 0;
> > > +	struct subch_data_s *sd = (struct subch_data_s *) file->private_data;
> > > +	unsigned long flags;
> > > +
> > > +	scdrv_lock_all(sd, &flags);
> > > +	poll_wait(file, &sd->sd_rq, wait);
> > > +	poll_wait(file, &sd->sd_wq, wait);
> >
> > This function will sleep with spinlocks held, won't it?
> 
> My understanding is that poll_wait just sets up a poll_table
> structure; it doesn't sleep itself.

It calls into __pollwait(), which can perform sleeping memory allocations.
