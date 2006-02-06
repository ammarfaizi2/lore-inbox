Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWBFEUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWBFEUK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 23:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWBFEUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 23:20:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51396 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750957AbWBFEUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 23:20:09 -0500
Date: Sun, 5 Feb 2006 20:19:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Richard Purdie <rpurdie@rpsys.net>, jbowler@acm.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [PATCH 8/12] LED: Add LED device support for ixp4xx devices]
In-Reply-To: <20060205192025.4006a554.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0602052014060.3854@g5.osdl.org>
References: <1139154997.14624.20.camel@localhost.localdomain>
 <20060205192025.4006a554.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Feb 2006, Andrew Morton wrote:
>
> Richard Purdie <rpurdie@rpsys.net> wrote:
> >
> > +MODULE_AUTHOR("John Bowler <jbowler@acm.org>");
> > +MODULE_DESCRIPTION("IXP4XX GPIO LED driver");
> > +MODULE_LICENSE("MIT");
> 
> MIT license is unusual.  There's one other file in the kernel which uses it
> and that's down in MTD where nobody dares look.
> 
> I don't know whether MIT is GPL-compatible-for-kernel-purposes or not.  Help.

The FSF considers the normal MIT license (the original X license) to be 
GPL-compatible, but suggests not using the name (because there have been 
multiple licenses used at MIT).

The real problem is that it will taint the kernel, because the kernel 
won't _recognize_ it as being GPL-compatible. See module.c: function
"license_is_gpl_compatible()". 

For that reason, if no other, I would suggest changing it to

	"Dual MIT/GPL"

and adding that to the list of recognized licenses (the "Dual xxx/GPL" 
because by the time it is linked into the kernel it _will_ be GPL for any 
license that is compatible with the GPL).

Otherwise most kernel developers will discard any bug reports due to the 
oops showing the kernel as "tainted".

		Linus
