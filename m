Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbSI3T7J>; Mon, 30 Sep 2002 15:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261284AbSI3T7J>; Mon, 30 Sep 2002 15:59:09 -0400
Received: from bitchcake.off.net ([216.138.242.5]:44458 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S261276AbSI3T7I>;
	Mon, 30 Sep 2002 15:59:08 -0400
Date: Mon, 30 Sep 2002 16:04:34 -0400
From: Zach Brown <zab@zabbo.net>
To: Daniel Phillips <phillips@arcor.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated v2
Message-ID: <20020930160434.Q13755@bitchcake.off.net>
References: <Pine.LNX.4.44L.0209261628490.1837-100000@duckman.distro.conectiva> <Pine.LNX.4.44.0209261337290.7827-100000@hawkeye.luckynet.adm> <20020926205727.T13817@bitchcake.off.net> <E17w6Mc-0005p6-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17w6Mc-0005p6-00@starship>; from phillips@arcor.de on Mon, Sep 30, 2002 at 09:37:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Friday 27 September 2002 02:57, Zach Brown wrote:
> > #define tslist_add(_head, _elem) 			\
> > 	do {  						\
> > 		BUG_ON(tslist_on_list(_head, _elem));	\
> > 		(_elem)->_slist_next = (_head);		\
> > 		(_head) = (_elem);			\
> > 	} while(0)
> 
> This evaluates _head and _elem twice each, or three times if you count
> the BUG_ON.

yes, I wss saving that trivial fix for later. (its a little less trivial
in the presence of bare struct * heads, rather than full struct
instances, but still just language mechanics.)

> Smaller point: why bother obfuscating the parameter names?  You will
> need to do that for locals in macros but parameters should cause no
> name conflicts.

*shrug*  either way is fine with me.

but really, I think these are DOA.  having to define a single magical
structure member makes these more trouble than they're worth.  I've come
to prefer wli's 'struct list' approach.  It has the added benefit of
actually being sanely implementable with shared code, something
ridiculously low memory setups might appreciate.  the deltion walking
function might actually be bugger than the function-calling code
overhead :)

- z
