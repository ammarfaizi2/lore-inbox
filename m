Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbUB1A6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 19:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbUB1A6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 19:58:39 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:56330 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263180AbUB1A6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 19:58:38 -0500
Date: Sat, 28 Feb 2004 00:58:32 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: arief# <arief_m_utama@telkomsel.co.id>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Radeon Framebuffer Driver in 2.6.3?
In-Reply-To: <1077921806.22962.43.camel@gaston>
Message-ID: <Pine.LNX.4.44.0402280048120.2216-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Just a couple of things. The idea of adding another field to 
> > con_blank bothers me. I think the better approach is to add more flags.
> 
> Linus proposed the additional parameter approach ;

Still don't care for it. 

> > > -	if (memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
> > > +	if ((var->activate & FB_ACTIVATE_FORCE) ||
> > > +	    memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
> > >  		if (!info->fbops->fb_check_var) {
> > >  			*var = info->var;
> > >  			return 0;
> > 
> > Ug!!! Another flag. How about instead in fbcon.c we call set_par directly 
> > instead of messing with fb_set_var. 
> 
> Because fb_set_par is the proper interface, I want to get rid of all
> the direct calls to the fbdev made by fbcon in the end. Calling
> set_par directly will also skip the notification of the clients,
> which may be just what we want for fbcon and harmful the day some
> other client relies on that mecanism (and I already have one example
> on ppc).

Rememeber we have to modify every driver then to support FB_ACTIVATE_FORCE.
You have to ask yourself what do you want to do exactly? 


