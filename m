Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTHXEE7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 00:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263495AbTHXEE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 00:04:59 -0400
Received: from smtp-2.concepts.nl ([213.197.30.52]:45842 "EHLO
	smtp-2.concepts.nl") by vger.kernel.org with ESMTP id S264060AbTHXEEz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 00:04:55 -0400
Subject: Re: [PATCH] 2.6.0-test3 zoran driver update
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030821010812.A6961@electric-eye.fr.zoreil.com>
References: <1061414594.1320.97.camel@localhost.localdomain>
	 <20030821010812.A6961@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Message-Id: <1061684006.4302.251.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 24 Aug 2003 06:23:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Francois,

coming back to your other points now. (This means I've worked on them.
;) ).

On Thu, 2003-08-21 at 01:08, Francois Romieu wrote:
> - {adv7170/adv7175/bt819/saa7110/saa7185}_detect_client()
>   for each of these functions, two error exit path leak on locally allocated
>   variable "channel".

That one was fixed already, patch coming up.

> - {adv7170/adv7175/bt819/saa7111/saa7185}_write_block()
>   The code duplication could surely be avoided.

I'm wondering how. I could make an inline function that each of them
includes (but that doesn't decrease binary size, code is still
duplicated), or I could make a parent module (and I don't want to do
that). The only bad thing of the current way is the maintainance, but I
don't really mind.

Does it matter if I just keep it the way it is right now? I don't really
mind at all.

> - always put a blank line between variables declaration and code pleae

Patch coming up. It fixes most of them. I might have missed one or two.

> - find_zr36057():
>   what about replacing pci_find_device() by the modern pci insertion/removal
>   api (which has been standing there for ~3 years)

That's planned (also, we aren't conforming to the latest DMA API yet,
that's planned for future fixage, too). I can't really fix that
short-term, though, I'm affraid...

> - pci_enable_device() in find_zr36057() isn't balanced by pci_disable_device()
>   in zoran_release()

Patch coming up...

> - +irqreturn_t
>   +zoran_irq (int             irq,
> [...]
>   +                                               for (i = 0; i < 4; i++) {
>   +                                                       if (zr->
>   +                                                           stat_com[i] &
>   +                                                           1)
>   +                                                               sv[i] =
>   +                                                                   '1';
>   +                                               }
> 
>   Post-modernism ?

Uh yes, that's an indent artifact, we occassionaly find that in some
places. I started with a codebase that hadn't been maintained for a year
or so, and it used 3 coding styles, so I fixed that by just running
indent -kr over it and fixing the most obvious style bugs as I
encountered them. However, I'm sure I missed some, like this. If you
find more, please let me know. Patch coming up. :).

> It looks interesting.

Thanks, and thanks for the comments, too.

I'm moving some things explicitely to the long-term list, btw, that's on
purpose. It'd be cool to handle the new DMA/PCI subsystem, but we've got
many things to work on, some of which are more important than this.
Also, kernel modules isn't all I'm working on, and this isn't my job. So
it's no deinterest or anything, it's simply a matter of (lack of) time
in combination with a bit of realism. I'll work on it, just not today.
:).

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

