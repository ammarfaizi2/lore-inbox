Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUIDRN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUIDRN7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbUIDRN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:13:58 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:25541 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264571AbUIDRNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:13:38 -0400
Message-ID: <9ae345c0040904101365a1ca63@mail.gmail.com>
Date: Sat, 4 Sep 2004 20:13:36 +0300
From: Yuval Turgeman <yuvalt@gmail.com>
Reply-To: Yuval Turgeman <yuvalt@gmail.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] Menuconfig search changes - pt. 3
Cc: sam@ravnborg.org, rddunlap@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0409040152160.877@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040903190023.GA8898@aduva.com>
	 <Pine.LNX.4.61.0409040152160.877@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sep 2004 02:47:29 +0200 (CEST), Roman Zippel
<zippel@linux-m68k.org> wrote:

> Please send a complete patch, it makes commenting on it easier.

Ok, will do.

> You shouldn't compute the pattern at every search.
You are correct, I fixed it.

> menu->dep contains only temporary information. The real information is in
> prop->visible.expr.
Fixed that also... 

> sym->dep doesn't contain user relevant information.
Fixed.

> With this you print all selection with every menu entry.
> You probably also want to print sym->rev_dep, which is used to calculate
> the selections for this symbol.
I wasn't really aware of rev_dep - very cool! Added a "Selected by" tag also.

> 
> >                       while (submenu) {
> >                               menu[j++] = submenu;
> >                               submenu = submenu->parent;
> >                       }
> 
> This loop should stop when you find root_menu.
It does stop when it gets to rootmenu (rootmenu's parent is NULL).

> 
> >                       if (j > 0) {
> > +                             if (!hit)
> > +                                     hit = true;
> > +                             if (prop->text)
> > +                                     fprintf(fp, "%s (%s)\n", prop->text,
> > +                                                             sym->name);
> >                               else
> >                                       fprintf(fp, "%s\n", sym->name);
> 
> This test isn't necessary, every prompt has a text.
Left overs from the old menu search.  Removed.

> 
> > +                     space = (char*)malloc(sizeof(char)*j);
> 
> This isn't necessary, just use "%*c" like the other indentations.
Ok - I keep learning new stuff.... :) - Done also.

I'll submit a final patch against mm3 soon.
Thanks for the help!


-- 
Yuval Turgeman
