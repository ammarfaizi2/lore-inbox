Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVAEVuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVAEVuT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVAEVsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:48:31 -0500
Received: from mail.dif.dk ([193.138.115.101]:17341 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262611AbVAEVqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:46:47 -0500
Date: Wed, 5 Jan 2005 22:58:07 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pedantic correctness cleanup for conf.c in scripts/kconfig/
 .
In-Reply-To: <200501051326.56959.zippel@linux-m68k.org>
Message-ID: <Pine.LNX.4.61.0501052250550.3492@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0501040031460.3529@dragon.hygekrogen.localhost>
 <200501051326.56959.zippel@linux-m68k.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005, Roman Zippel wrote:

> Hi,
> 
> On Tuesday 04 January 2005 00:35, Jesper Juhl wrote:
> 
> > @@ -305,8 +305,8 @@ static int conf_choice(struct menu *menu
> >    printf("%*s%s\n", indent - 1, "", menu_get_prompt(menu));
> >    def_sym = sym_get_choice_value(sym);
> >    cnt = def = 0;
> > -  line[0] = '0';
> > -  line[1] = 0;
> > +  line[0] = '\0';
> > +  line[1] = '\0';
> >    for (child = menu->list; child; child = child->next) {
> >     if (!menu_is_visible(child))
> >      continue;
> 
> This would make a difference and even the other change is not an improvement, 
> 0 is special string marker and not a character.
> 
You are right. that bit actually makes a difference, that was not my 
intention but a silly error. I didn't spot it at the time for some reason 
and the testing I did didn't show any behavioral differences so it slipped 
through.
As to 0 vs \0 I know \0 ("the null character") has the value 0 (zero) so 
the compiled code will be identical, but using \0 is IMO a good idea to 
emphazise the character nature of it. But, I don't care greatly, I just 
saw it and thought "ohh, why 0 and not the null char? Let's fix that up", 
so I wrote a patch to make that change in case others agreed with me.


-- 
Jesper


