Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030627AbWKUSEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030627AbWKUSEb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 13:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031246AbWKUSEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 13:04:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9992 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030627AbWKUSEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 13:04:30 -0500
Date: Tue, 21 Nov 2006 19:04:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Paul Sokolovsky <pmiscml@gmail.com>
Cc: Greg KH <gregkh@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org,
       kernel-discuss@handhelds.org
Subject: Re: Where did find_bus() go in 2.6.18?
Message-ID: <20061121180430.GD5200@stusta.de>
References: <1154868495.20061120003437@gmail.com> <4560ECAF.1030901@gmail.com> <20061120001212.GA28427@suse.de> <1148526308.20061120161322@gmail.com> <20061120173550.GV31879@stusta.de> <1697835939.20061121170846@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697835939.20061121170846@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 05:08:46PM +0200, Paul Sokolovsky wrote:

> Hello Adrian,

Hello Paul,

> Monday, November 20, 2006, 7:35:50 PM, you wrote:
> 
> []
> 
> >>   And suddenly - oops, in 2.6.18 we lose ability to query the highest
> >> level of hierarchy, namely bus set.
> 
> []
> 
> > As Documentation/stable_api_nonsense.txt explains, there is no stable 
> > kernel API.
> 
>   Thanks, Adrian, from the first mail I really counted which reply #
> (if I would get them at all) will point me to that "bible" of kernel
> developers, and just wondered, would it be too ugly to ask for an answer
> which wouldn't recourse to that doc.
> 
>   But now that you mentioned it, let me make you laugh at jaundiced
> eye's look on the issue: it appears it's just itch for kernel
> developers to make APIs not stable. When some API is stable, because
> it's both trivial and complete (like that bus methods which are just
> based on generic container object idea - you can't add or take from
> that), some artificial criteria are employed, like "unused", to still
> find a way to destabilize API ;-).


if API changes in the kernel break external modules that's not 
intentional, but a positive side effect reminding people that they 
should submit their modules for inclusion in mainline.


> > If you don't want to get the APIs your driver uses 
> > changed/removed you should really try to get it merged into mainline.
> 
>   Would this really be the case? I guess, most people would think that
> getting something into mainline is indeed the end of battle. And yet
> for others, it may be the case that single driver using some API is
> almost just the same as 0 drivers doing that. If 1001 is almost 1000,
> why 1 can't be almost 0? Why this would be worse than "Well, noone
> uses that call now - let's make noone use it ever, at all."


The rule is roughly:
If you change/remove a kernel API, you have to fix all in-kernel 
users.

As an example, the irqreturn_t change in 2.6.19 will require changes to 
your driver. It also broke at about 1000 in-kernel drivers, but all of 
them have been fixed as part of the change (the commit changed 1079 
different files).


>   So that's what I'm trying to argue - let the change which needs to
> be done, be based on the high-level ideas of the meaning of the thing
> being changed, not on purely quantitative, and thus, subject to
> separate interpretation, parameters.
>...


Many people are still using kernel 2.4 for new kernel development 
because kernel 2.6 images are significantly bigger. Every unused byte 
removed from the kernel images makes this space regression smaller.


> > The find_bus() case is even more interesting since you are using it in a
> > driver although it has never been exported to modules. Considering that
> > you anyway have to patch the kernel for getting your driver running 
> > (since it won't run as a module against an unmodified kernel), you could
> > simply undo my patch locally until you submit your driver for inclusion
> > in mainline.
> 
>   Well, I believe you expected and cared to get such feedback, because
> otherwise, you wouldn't use #if 0, but killed unlucky function
> completely ;-(. I don't hold breath for those #if 0 to be removed
> based on the above right now, but I hope the function at least won't
> be removed completely for now, to indeed let whoever may have need for
> it still use it somehow (and submit code to mainline, if that is what
> actually would take to have the issue resolved).
> 
>   As for EXPORT's, indeed, mainline kernel lacks quite a few
> which are useful. But obviously, I won't argue for adding them now,
> out of context - that would be just as random change, as, IMHO, and
> sorry, removing find_bus() from use.


It's an integral part of the Linux development model that any kind of 
in-kernel API changes are always possible.

There's a choice between stable APIs on the one side and speed of 
development and smaller kernel images on the other side, and the Linux 
kernel prefers the latter.


> Best regards,
>  Paul

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

