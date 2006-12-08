Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164184AbWLHAGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164184AbWLHAGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 19:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164191AbWLHAGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 19:06:40 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:54204 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164184AbWLHAGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 19:06:39 -0500
X-Originating-Ip: 74.102.209.62
Date: Thu, 7 Dec 2006 19:02:34 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sound : Replace kmalloc()+memset(0) with kzalloc().
In-Reply-To: <200612080055.14488.m.kozlowski@tuxland.pl>
Message-ID: <Pine.LNX.4.64.0612071902010.22886@localhost.localdomain>
References: <Pine.LNX.4.64.0612071553580.22255@localhost.localdomain>
 <200612080055.14488.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.541, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, SARE_SUB_OBFU_Z 0.26)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006, Mariusz Kozlowski wrote:

> Hello,
>
>
> >   Replace all appropriate kmalloc() + memset() combinations with
> > kzalloc() throughout the sound/ directory.
>
> [... cut ...]
>
> > diff --git a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
> > index c3c8a72..f5e31f1 100644
> > --- a/sound/oss/i810_audio.c
> > +++ b/sound/oss/i810_audio.c
> > @@ -2580,10 +2580,9 @@ static int i810_open(struct inode *inode
> >  		for (i = 0; i < NR_HW_CH && card && !card->initializing; i++) {
> >  			if (card->states[i] == NULL) {
> >  				state = card->states[i] = (struct i810_state *)
> > -					kmalloc(sizeof(struct i810_state), GFP_KERNEL);
> > +					kzalloc(sizeof(struct i810_state), GFP_KERNEL);
>
> You can remove those casts while you're at it.

i actually thought about that, but decided to restrict that submission
to just the kmalloc/memset replacement.  a subsequent patch could do a
global change of all k*alloc calls to get rid of superfluous casts.

rday
