Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966248AbWKTRfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966248AbWKTRfw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966267AbWKTRfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:35:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36361 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S966248AbWKTRfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:35:51 -0500
Date: Mon, 20 Nov 2006 18:35:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Paul Sokolovsky <pmiscml@gmail.com>
Cc: Greg KH <gregkh@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
       kernel-discuss@handhelds.org
Subject: Re: Where did find_bus() go in 2.6.18?
Message-ID: <20061120173550.GV31879@stusta.de>
References: <1154868495.20061120003437@gmail.com> <4560ECAF.1030901@gmail.com> <20061120001212.GA28427@suse.de> <1148526308.20061120161322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148526308.20061120161322@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 04:13:22PM +0200, Paul Sokolovsky wrote:
>...
>   But note that I don't really ask mainline kernel developers how to
> fix this driver - I would actually be ashamed to do so, as I myself a
> (newbie) kernel hacker. So, the question stays the same, though I
> probably reformulate it a bit stronger now: how it came that ability
> to query buses (at all) was removed from 2.6.18?
> 
>   As it was before, it was clear that LDM consists of multiple layers,
> and each layer offers consistent and complete set of operations on it,
> like adding new object on this layer, removing, adding child, removing
> child, *and* query objects on this level or among childs. I may miss
> some accidental gaps in that picture of course, but it still was an
> integral, complete design paradigm offering full dynamicity and
> introspection.
> 
>   And suddenly - oops, in 2.6.18 we lose ability to query the highest
> level of hierarchy, namely bus set. And on what criterion? "unused". I
> would really dream that such core, the most basic APIs are not being
> defined in terms of "someone does use it right now". A method to query
> objects of core kernel data sets is just integral part of interface to
> these datasets, you cannot remove it and not cripple such interface.
> Again, it's loss of introspection, and that's not just "cleanup", it's
> a paradigm shift.
>...

As Documentation/stable_api_nonsense.txt explains, there is no stable 
kernel API. If you don't want to get the APIs your driver uses 
changed/removed you should really try to get it merged into mainline.

The find_bus() case is even more interesting since you are using it in a 
driver although it has never been exported to modules. Considering that 
you anyway have to patch the kernel for getting your driver running 
(since it won't run as a module against an unmodified kernel), you could 
simply undo my patch locally until you submit your driver for inclusion 
in mainline.

>  Paul

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

