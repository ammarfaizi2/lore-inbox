Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263502AbUDEXgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbUDEXgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:36:37 -0400
Received: from waste.org ([209.173.204.2]:18080 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263502AbUDEXgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 19:36:36 -0400
Date: Mon, 5 Apr 2004 18:36:24 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca
Subject: Re: [PATCH] Drop exported symbols list if !modules
Message-ID: <20040405233624.GL6248@waste.org>
References: <20040405205539.GG6248@waste.org> <1081205099.15272.7.camel@bach> <20040405230723.GK6248@waste.org> <1081207046.15272.44.camel@bach> <20040405163019.4e3ab546.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405163019.4e3ab546.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 04:30:19PM -0700, Andrew Morton wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > On Tue, 2004-04-06 at 09:07, Matt Mackall wrote:
> > > On Tue, Apr 06, 2004 at 08:45:01AM +1000, Rusty Russell wrote:
> > > > On Tue, 2004-04-06 at 06:55, Matt Mackall wrote:
> > > > > Drop ksyms if we've built without module support
> > > > > 
> > > > > From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
> > > > > Subject: Re: 2.6.1-rc1-tiny2
> > > > 
> > > > Other than saving a little compile time, does this actually do anything?
> > > > 
> > > > I'm not against it, I just don't think I see the point.
> > > 
> > > Well it obviously saves memory and image size too;
> > 
> > Please measure it.  It's not obvious to me at all.
> 
> Miniscule savings
> 
>    text    data     bss     dec     hex filename
> 3221815  862456       0 4084271  3e522f vmlinux-before
> 3221591  862456       0 4084047  3e514f vmlinux-after

I was seeing this when I added it to my tree circa 2.6.1: 

 701262   58619   15616  775497   bd549 vmlinux before 
 700530   58619   15616  774765   bd26d vmlinux after

..which I would expect to grow with code size.

On the other hand, I'm now seeing:

      0       0       0       0       0 arch/i386/kernel/i386_ksyms.o

So something's changed.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
