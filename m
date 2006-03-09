Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWCIGA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWCIGA2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWCIGA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:00:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:23694 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751486AbWCIGA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:00:27 -0500
Date: Wed, 8 Mar 2006 21:51:46 -0800
From: Greg KH <greg@kroah.com>
To: Dave Peterson <dsp@llnl.gov>
Cc: Arjan van de Ven <arjan@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-ID: <20060309055146.GA9013@kroah.com>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603061301.37923.dsp@llnl.gov> <1141679261.5568.13.camel@laptopd505.fenrus.org> <200603081919.59763.dsp@llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603081919.59763.dsp@llnl.gov>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 07:19:59PM -0800, Dave Peterson wrote:
> On Monday 06 March 2006 13:07, Arjan van de Ven wrote:
> > > Is it more desirable to dynamically allocate kobjects than to declare
> > > them statically?
> >
> > Yes
> >
> > >  If so, I'd be curious to know why dynamic
> > > allocation is preferred over static allocation.
> >
> > because the lifetime of the kobject is independent of the lifetime of
> > the memory of your static allocation.
> > Separate lifetimes -> separate memory is a very good design principle.
> 
> I'm not familiar with the internals of the module unloading code.
> However, my understanding of the discussion so far is that the kernel
> will refuse to unload a module while any of its kobjects still have
> nonzero reference counts (either by waiting for the reference counts
> to hit 0 or returning -EBUSY).

There is no tie between kobjects and modules.  Only between attributes
and modules _if_ you have properly set them up.

That is the main problem, kobjects are data and modules are code, you
need to be careful to handle their reference counting properly.

good luck,

greg k-h
