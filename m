Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTGXLfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 07:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTGXLfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 07:35:13 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:7821 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S262593AbTGXLfG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 07:35:06 -0400
Date: Thu, 24 Jul 2003 21:50:09 +1000
From: David McCullough <davidm@snapgear.com>
To: Ihar Philips Filipau <filia@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
Message-ID: <20030724115009.GB16168@beast>
References: <3F1F9887.5010703@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1F9887.5010703@softhome.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jivin Ihar Philips Filipau lays it down ...
> David McCullough wrote:
> >
> >A general comment on the use of inline throughout the kernel.  Although
> >they may show gains on x86 platforms,  they often perform worse on 
> >embedded processors with limited cache,  as well as adding size.  I
> >can't see any way of coding around this though.  As long as x86 is
> >driving influence,  other platforms will jut have to deal with it as
> >best they can.
> >
> 
>   Actually I'm victim on over inlining too. Was at least.
>   I was running some router on old Pentium's. I remember almost 
> dramatical drop of performance with newer kernels because of inlining in 
> net/*. But sure on Xeon P4 it boosts performance...
> 
>   Actually what I'm about.
>   We have classical situation when we have mess of representation and 
> intentions.
> 
>   Representation == 'inline', but intentions - 'inline or it will 
> break' _and_ 'inline - it runs faster'.
>   This obviously should be separated.


The biggest problem I see is that the inlines are done in header files
generally,  and to stop them from inlining,  you need to be able to
switch from an inline to a prototype in the header file.  The code from
the header then needs to be added to a .o somewhere in the build for the
case where inlines are stripped out.


Other than providing non-critical inlines either on or off,  I can't see
the level approach working all that well.  A combination of levels that
work well on a few platforms may not work well at all on another.
Still, just the ability to reduce the inlines would be very useful.


Cheers,
Davidm




>   even more.
> 
> #define INLINE_LEVEL some_platform_specific_number
> 
> ---------
> 
> #define inline0 inline_always
> 
> #if INLINE_LEVEL >= 1
> #  define inline1 inline_always
> #else
> #  define inline1
> #endif
> ...
> #if INLINE_LEVEL >= N
> #  define inlineN inline_always
> #else
> #  define inlineN
> #endif
> 
>    and so on, giving a platform chance to influence amount of inlining.
>    better to put it into config with defined by platform defaults.
-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org
