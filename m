Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVJDCQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVJDCQJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 22:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVJDCQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 22:16:09 -0400
Received: from xenotime.net ([66.160.160.81]:54437 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932259AbVJDCQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 22:16:08 -0400
Date: Mon, 3 Oct 2005 19:15:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: jesper.juhl@gmail.com, ben-linux@fluff.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] release_resource() check for NULL resource
Message-Id: <20051003191542.299d15e8.rdunlap@xenotime.net>
In-Reply-To: <20051003100431.GA16717@flint.arm.linux.org.uk>
References: <20051002170318.GA22074@home.fluff.org>
	<20051002103922.34dd287d.rdunlap@xenotime.net>
	<20051003094803.GC3500@home.fluff.org>
	<9a8748490510030259o43646cbbo22b37f1791d267e@mail.gmail.com>
	<20051003100431.GA16717@flint.arm.linux.org.uk>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005 11:04:31 +0100 Russell King wrote:

> On Mon, Oct 03, 2005 at 11:59:01AM +0200, Jesper Juhl wrote:
> > On 10/3/05, Ben Dooks <ben-linux@fluff.org> wrote:
> > > On Sun, Oct 02, 2005 at 10:39:22AM -0700, Randy.Dunlap wrote:
> > > > On Sun, 2 Oct 2005 18:03:18 +0100 Ben Dooks wrote:
> > > >
> > > > > If release_resource() is passed a NULL resource
> > > > > the kernel will OOPS.
> > > >
> > > > does this actually happen?  you are fixing a real oops?
> > > > if so, what driver caused it?
> > >
> > > I was developing a couple of new drivers, and found
> > > that this does not behave like kfree() which does check
> > > for NULL paramemters. I belive it would be helpful if
> > > functions like this followed the example of kfree().
> > >
> > I would agree that it makes sense for resource release functions to be
> > written defensively and be able to cope with being passed a NULL
> > resource, just like kfree(), vfree(), crypto_free_tfm() and others are
> > already doing.
> > Seems safer and allows us to get rid of checks for NULL before calling
> > such functions thus making code simpler, more readable and in some
> > cases smaller.
> 
> I'm not convinced - release_resource() isn't like kfree() - it's more
> like device_unregister().
> 
> It makes sense for kfree() to ignore NULL pointers, but does it really
> make sense for *_unregister() to do so too?  Surely you want to only
> unregister things which you know have previously been registered?

I agree.  The driver should know the state of such registrations
or allocations and act accordingly.  Having foo_release() check its
parameter before acting on it just encourages sloppy programming.
kfree() is an exception IMO, not the rule.  


---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
