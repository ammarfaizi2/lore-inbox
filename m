Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVAWRwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVAWRwO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 12:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVAWRwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 12:52:14 -0500
Received: from waste.org ([216.27.176.166]:7044 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261336AbVAWRwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 12:52:07 -0500
Date: Sun, 23 Jan 2005 09:52:04 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] core-small: Introduce CONFIG_CORE_SMALL from -tiny
Message-ID: <20050123175204.GV12076@waste.org>
References: <1.464233479@selenic.com> <20050123004042.09f7f8eb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050123004042.09f7f8eb.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 12:40:42AM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > This set of patches introduces a new config option CONFIG_CORE_SMALL
> > from the -tiny tree for small systems. This series should apply
> > cleanly against 2.6.11-rc1-mm2.
> > 
> > When selected, it enables various tweaks to miscellaneous core data
> > structures to shrink their size on small systems. While each tweak is
> > fairly small, in aggregate they can save a substantial amount of
> > memory.
> 
> You know what I'm going to ask ;)  How much memory?

This stuff is mostly pretty small, a few K per patch. I think these 8
are about 40k total but my notes are several months old. 

> I wish it didn't have "core" in the name.  A little misleading.

Well I've got another set called NET_SMALL. BASE?

> Did you think of making CONFIG_CORE_SMALL an integer which has values zero
> or one?
> 
> Then you can lose all those ifdefs:
> 
> #define MAX_PROBE_HASH (255 - CONFIG_CORE_SMALL * 254)	/* dorky */

Ew.

> #define PID_MAX_DEFAULT (CONFIG_CORE_SMALL ? 0x1000 : 0x8000)
> #define UIDHASH_BITS (CONFIG_CORE_SMALL ? 3 : 8)
> #define FUTEX_HASHBITS (CONFIG_CORE_SMALL ? 4 : 8)
> etc.

Hmm. I think we'd want a hidden config variable for this and I'm not
sure how well the config language allows setting an int from a bool.
And then it would need another name. On the whole, seems more complex
than what I've done.

-- 
Mathematics is the supreme nostalgia of our time.
