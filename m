Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVJCKEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVJCKEk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 06:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVJCKEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 06:04:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40719 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750731AbVJCKEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 06:04:40 -0400
Date: Mon, 3 Oct 2005 11:04:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] release_resource() check for NULL resource
Message-ID: <20051003100431.GA16717@flint.arm.linux.org.uk>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	Ben Dooks <ben-linux@fluff.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <20051002170318.GA22074@home.fluff.org> <20051002103922.34dd287d.rdunlap@xenotime.net> <20051003094803.GC3500@home.fluff.org> <9a8748490510030259o43646cbbo22b37f1791d267e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490510030259o43646cbbo22b37f1791d267e@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 11:59:01AM +0200, Jesper Juhl wrote:
> On 10/3/05, Ben Dooks <ben-linux@fluff.org> wrote:
> > On Sun, Oct 02, 2005 at 10:39:22AM -0700, Randy.Dunlap wrote:
> > > On Sun, 2 Oct 2005 18:03:18 +0100 Ben Dooks wrote:
> > >
> > > > If release_resource() is passed a NULL resource
> > > > the kernel will OOPS.
> > >
> > > does this actually happen?  you are fixing a real oops?
> > > if so, what driver caused it?
> >
> > I was developing a couple of new drivers, and found
> > that this does not behave like kfree() which does check
> > for NULL paramemters. I belive it would be helpful if
> > functions like this followed the example of kfree().
> >
> I would agree that it makes sense for resource release functions to be
> written defensively and be able to cope with being passed a NULL
> resource, just like kfree(), vfree(), crypto_free_tfm() and others are
> already doing.
> Seems safer and allows us to get rid of checks for NULL before calling
> such functions thus making code simpler, more readable and in some
> cases smaller.

I'm not convinced - release_resource() isn't like kfree() - it's more
like device_unregister().

It makes sense for kfree() to ignore NULL pointers, but does it really
make sense for *_unregister() to do so too?  Surely you want to only
unregister things which you know have previously been registered?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
