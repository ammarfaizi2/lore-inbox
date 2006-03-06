Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752461AbWCFW4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbWCFW4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbWCFW4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:56:10 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:138 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1752461AbWCFW4J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:56:09 -0500
Date: Mon, 6 Mar 2006 14:55:55 -0800
From: Greg KH <greg@kroah.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Dave Peterson <dsp@llnl.gov>, Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-ID: <20060306225555.GA21127@kroah.com>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603061052.57188.dsp@llnl.gov> <20060306195348.GB8777@kroah.com> <200603061301.37923.dsp@llnl.gov> <20060306213203.GJ27946@ftp.linux.org.uk> <20060306215344.GB16825@kroah.com> <20060306222400.GK27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306222400.GK27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 10:24:00PM +0000, Al Viro wrote:
> On Mon, Mar 06, 2006 at 01:53:44PM -0800, Greg KH wrote:
> > > 	rmmod your_turd </sys/spew/from/your_turd
> > > and there you go.  rmmod can _NOT_ wait for sysfs references to go away.
> > 
> > To be fair, the only part of the kernel that supports the above process,
> > is the network stack.  And they implemented a special kind of lock to
> > handle just this kind of thing.
> > 
> > That is not something that I want the rest of the kernel to have to use.
> > If your code blocks when doing the above thing, that's fine with me.
> 
> One word: fail.  With -EBUSY.
>  
> > Note, you better have the module owner reference right for the above to
> > not oops the kernel, deadlock is fine.
> 
> Never is.

My apologies, you are right, for some reason I thought rmmod would just
wait for the reference count to go away.  I just tested this on a lot of
different things in sysfs and it works properly and rmmod will return an
error saying the module is in use at this time.

> > There is no rule that we _have_
> > to allow rmmod to always succeed.
> 
> Quite so, which means we can have it fail saying that module removal has
> failed.  Deadlock is not the same thing.

Agreed.

thanks,

greg k-h
