Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVJXIQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVJXIQd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 04:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVJXIQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 04:16:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27591 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750737AbVJXIQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 04:16:32 -0400
Date: Mon, 24 Oct 2005 01:16:13 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, linux-kernel@vger.kernel.org, ak@suse.de,
       torvalds@osdl.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset bitmap and mask remap operators
Message-Id: <20051024011613.691e28f4.pj@sgi.com>
In-Reply-To: <20051024004833.50d9676b.akpm@osdl.org>
References: <20051024072744.10390.35722.sendpatchset@jackhammer.engr.sgi.com>
	<20051024004833.50d9676b.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> >  +#define node_remap(oldbit, old, new) \
> >  +		__node_remap((oldbit), &(old), &(new), MAX_NUMNODES)
> >  +static inline int __node_remap(int oldbit, ...
>
> What's the reason for the wrapper macro?

Most all the nodemask/cpumask operators are like that.  It allows
writing *mask code as if masks were pass by value (which is how the
vast majority of kernel hackers, working on systems with one-word
masks, think of them), while actually passing by reference, to
avoid unnecessary stack copies of multiword masks.


> +EXPORT_SYMBOL(bitmap_bitremap);
> 
> Is that deliberately not EXPORT_SYMBOL_GPL?

It's not deliberate that I am aware of.

But it does seem to be the common practice ....

All the bitmap routines are that way - no GPL.  In fact it seems that
almost all the EXPORT_SYMBOLS in the lib/*.c routines are that way - 12
with GPL and 174 without GPL, or some such.  The only lib/*.c GPL
exports are in lib/klist.c and lib/kobject_uevent.c.

Is this bad?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
