Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbVGFXxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbVGFXxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVGFXv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 19:51:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:28106 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261807AbVGFXuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 19:50:13 -0400
Date: Wed, 6 Jul 2005 16:40:34 -0700
From: Greg KH <greg@kroah.com>
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: Add Dell Systems Management Base driver
Message-ID: <20050706234034.GA18993@kroah.com>
References: <20050706001333.GA3569@sysman-doug.us.dell.com> <20050706041702.GA10253@kroah.com> <20050706155734.GA4271@sysman-doug.us.dell.com> <20050706160737.GC13115@kroah.com> <20050706234119.GA5949@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706234119.GA5949@sysman-doug.us.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 06:41:19PM -0500, Doug Warzecha wrote:
> On Wed, Jul 06, 2005 at 09:07:37AM -0700, Greg KH wrote:
> > On Wed, Jul 06, 2005 at 10:57:35AM -0500, Doug Warzecha wrote:
> > > On Tue, Jul 05, 2005 at 11:17:03PM -0500, Greg KH wrote:
> > > >    > +static void dcdbas_device_release(struct device *dev)
> > > >    > +{
> > > >    > +     /* nothing to release */
> > > >    > +}
> > > > 
> > > >    This is a symptom of a broken driver.
> > > > 
> > > >    Hm, I wonder if there's some way for the compiler to check the fact that
> > > >    a function pointer passed to another function, is really a null
> > > >    function.  That would stop this kind of nonsense...
> > > 
> > > There are other drivers in the kernel tree with null device release functions.
> > 
> > Where?
> 
> Here's a couple:
> 
> drivers/video/vfb.c: vfb_platform_release
> drivers/video/epson1355fb.c: epson1355fb_platform_release

Platform devices are a pain.  That being said, these are wrong and
should be fixed up to use platform_device_register_simple() instead.

It still doesn't justify you doing it in your driver :)

Thanks for pointing it out to me,

greg k-h
