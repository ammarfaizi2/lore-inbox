Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUCNRAM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 12:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbUCNRAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 12:00:12 -0500
Received: from mail.kroah.org ([65.200.24.183]:2700 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261443AbUCNRAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 12:00:08 -0500
Date: Sat, 13 Mar 2004 18:55:04 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] kref, a tiny, sane, reference count object
Message-ID: <20040314025504.GA5071@kroah.com>
References: <20040313082003.GA13084@kroah.com> <20040313163451.3c841ac2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313163451.3c841ac2.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 04:34:51PM -0800, Andrew Morton wrote:
> > +struct kref * kref_get(struct kref *kref)
> > +{
> > +	if (kref) {
> > +		WARN_ON(!atomic_read(&kref->refcount));
> > +		atomic_inc(&kref->refcount);
> > +	}
> > +	return kref;
> > +}
> 
> Why is a NULL arg permitted here?

Because kobjects permitted it?  :)

I think you are correct, if we are passing a NULL pointer to these
functions, we deserve the oops we get, as other, much worse things could
happen (as a kref lives inside another structure.)

I'll go take those checks out.

thanks,

greg k-h
