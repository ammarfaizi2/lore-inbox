Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVCHGNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVCHGNY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVCHGMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:12:47 -0500
Received: from waste.org ([216.27.176.166]:44714 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261610AbVCHGMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:12:10 -0500
Date: Mon, 7 Mar 2005 22:11:55 -0800
From: Matt Mackall <mpm@selenic.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] unified device list allocator
Message-ID: <20050308061155.GK3120@waste.org>
References: <20050308051818.GI3120@waste.org> <20050307213302.560de053.akpm@osdl.org> <20050308054325.GA1262@infradead.org> <20050307215035.345c3f63.akpm@osdl.org> <20050308055627.GA1515@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308055627.GA1515@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 05:56:27AM +0000, Christoph Hellwig wrote:
> On Mon, Mar 07, 2005 at 09:50:35PM -0800, Andrew Morton wrote:
> > > register_blkdev only happens at module_init time (and in fact should go
> > > away completely, so I'm not happy wit hthe surgey to keep it barely alive
> > > at all)
> > 
> > Is anyone working on that?
> 
> I had a patch from a long time ago that just killed it, but that one isn't
> useable for current users anymore.
> 
> There's two things it's doing currently:
> 
>  - when called with the major argument as 0 it returns an unused major number
>    from the top of the old 255 entries major list.  This should be replaced
>    by a real dynamic dev_t allocator, similar to alloc_chrdev_region.

Umm, this replaces alloc_chrdev_region too. If instead you mean "let's
migrate all the users to a sensible interface", I agree. And that
means killing alloc_chrdev_region too. (baseminor makes no sense for
dynamic allocation - you either know your prefered major and minor or
you know neither.)

>  - /proc/devices.  This interface has traditionally been used by things
>    like installer but these day's it's totally bogus as the one major, one
>    driver limitation got lifeted.  We'll probably have to deprecate it and
>    kill it in half a year or a similar timespan.

I think killing /proc/devices has to wait until after devfs removal,
when everyone is more or less comfortable with its alternatives.

-- 
Mathematics is the supreme nostalgia of our time.
