Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265819AbSL3UAT>; Mon, 30 Dec 2002 15:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265830AbSL3UAT>; Mon, 30 Dec 2002 15:00:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:263 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265819AbSL3UAS>; Mon, 30 Dec 2002 15:00:18 -0500
Date: Mon, 30 Dec 2002 12:03:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] 2.5 fix link with fbcon built-in
In-Reply-To: <1041244796.4330.14.camel@zion.wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0212301201090.2812-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 30 Dec 2002, Benjamin Herrenschmidt wrote:
>
> In current bk 2.5, drivers/video/console/fonts.c exports an
> init_module() symbol when built-in, which prevents the kernel from
> linking. Here's a quick fix.

This is not correct.

The functions should either be removed completely (preferred, since they 
aren't even proper C syntax in the first place - since when do we put 
semicolons at the end of a function?) or the file should be taught to use 
proper "module_init()/module_exit()" semantics that work _correctly_ for 
both modules and built-in.

The patch just hides just _how_ crap this file is, and as such should not 
be applied. Crap doesn't get better from being hidden.

		Linus

> +#ifdef MODULE
>  int init_module(void) { return 0; };
>  void cleanup_module(void) {};
> +#endif

