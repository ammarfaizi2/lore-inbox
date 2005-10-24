Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVJXIib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVJXIib (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 04:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVJXIib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 04:38:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32956 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750792AbVJXIia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 04:38:30 -0400
Date: Mon, 24 Oct 2005 01:37:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, linux-kernel@vger.kernel.org, ak@suse.de,
       torvalds@osdl.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset bitmap and mask remap operators
Message-Id: <20051024013713.25770d14.akpm@osdl.org>
In-Reply-To: <20051024011613.691e28f4.pj@sgi.com>
References: <20051024072744.10390.35722.sendpatchset@jackhammer.engr.sgi.com>
	<20051024004833.50d9676b.akpm@osdl.org>
	<20051024011613.691e28f4.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Andrew wrote:
> > >  +#define node_remap(oldbit, old, new) \
> > >  +		__node_remap((oldbit), &(old), &(new), MAX_NUMNODES)
> > >  +static inline int __node_remap(int oldbit, ...
> >
> > What's the reason for the wrapper macro?
> 
> Most all the nodemask/cpumask operators are like that.  It allows
> writing *mask code as if masks were pass by value (which is how the
> vast majority of kernel hackers, working on systems with one-word
> masks, think of them), while actually passing by reference, to
> avoid unnecessary stack copies of multiword masks.
> 

hm.  That hides what's really going on from the programmer.

Oh well - you're the only guy who dinks with that stuff anyway ;)

> > +EXPORT_SYMBOL(bitmap_bitremap);
> > 
> > Is that deliberately not EXPORT_SYMBOL_GPL?
> 
> It's not deliberate that I am aware of.
> 
> But it does seem to be the common practice ....
> 
> All the bitmap routines are that way - no GPL.  In fact it seems that
> almost all the EXPORT_SYMBOLS in the lib/*.c routines are that way - 12
> with GPL and 174 without GPL, or some such.  The only lib/*.c GPL
> exports are in lib/klist.c and lib/kobject_uevent.c.
> 
> Is this bad?
> 

Ah, the bitmap library - sorry I thought it was in the cpuset code.

Making the bitmap library non-GPL makes sense I guess.
