Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268665AbUHaOdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268665AbUHaOdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 10:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268671AbUHaOdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 10:33:51 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:11935 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S268665AbUHaOdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 10:33:49 -0400
Date: Tue, 31 Aug 2004 16:33:36 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Yuval Turgeman <yuvalt@gmail.com>
cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Searching parameters in menuconfig
In-Reply-To: <9ae345c0040831005257c245da@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0408311427110.981@scrub.home>
References: <9ae345c0040831005257c245da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 31 Aug 2004, Yuval Turgeman wrote:

> Added support for searching parameters in make menuconfig.
> Can be compiled with gcc-2.95 now...

Andrew already commented on the coding style, so I can skip that.

> +static struct menu *do_search(struct menu *menu, struct symbol *sym)
> +{
> +       struct menu *child, *ret;
> +       /* Ignore invisible menus ?
> +       if (!menu_is_visible(menu))
> +               return NULL;
> +       */
> +
> +       if ( menu->sym ) {
> +               if ( menu->sym->name && !strcmp(menu->sym->name, sym->name )) {
> +                       return menu;
> +               }
> +       }
> +       for (child = menu->list; child; child = child->next) {
> +               ret = do_search(child, sym);
> +               if ( ret ) return ret;
> +       }
> +       return NULL;
> +}

You get to this information easier by iterating over the properties 
attached to a symbol (sym->prop) and a symbol can have multiple menu 
prompts, you show only the first one (which might not be the right one) 
and sym->prop->text might not even be a menu prompt at all.
It would be nice to actually make it really useful, by first building a 
list of found symbols (and possibly allow wildcards for searching) and 
generate a menu of this. After a symbol is selected, build a new menu with 
all the prompts, which could also include the option to change parent 
symbols.

bye, Roman
