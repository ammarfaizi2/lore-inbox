Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTJPXNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 19:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTJPXNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 19:13:43 -0400
Received: from waste.org ([209.173.204.2]:37569 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263277AbTJPXNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 19:13:41 -0400
Date: Thu, 16 Oct 2003 18:13:24 -0500
From: Matt Mackall <mpm@selenic.com>
To: Eli Billauer <eli_billauer@users.sourceforge.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031016231324.GW5725@waste.org>
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com> <20031016173135.GL5725@waste.org> <3F8F23BE.7020703@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8F23BE.7020703@users.sf.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 01:03:26AM +0200, Eli Billauer wrote:
> Matt Mackall wrote:
> 
> >On Thu, Oct 16, 2003 at 07:29:05AM -0400, Jeff Garzik wrote:
> > 
> >
> >>So, given that trend and also given the existing /dev/[u]random, I 
> >>disagree completely:  /dev/frandom is the perfect example of something 
> >>that should _not_ be in the kernel.  If you want /dev/urandom faster, 
> >>then solve _that_ problem.  Don't try to solve a /dev/urandom problem by 
> >>creating something totally new.
> >>   
> >>
> >
> >I have some performance fixes for /dev/urandom, but there's a fair
> >amount of other cleanup that has to go in first.
> >
> ... and this reminded me that I originally wanted to patch random.c, and 
> change the algorithm to the faster one. To my best understanding, there 
> would be no degradation in random quality, assuming I would do it 
> correctly (and not being hung for the nerve to do it). But that's the 
> problem: What if I got something wrong?

Well you can't just drop SHA, that's needed for mixing purposes. The
designs in the literature use both a secure hash and a cipher.
 
> If a hardware device driver is buggy, you usually know about it sooner 
> or later. If an RNG has a rare bug, or an architecture-dependent flaw, 
> it's much harder to notice. If the RNG starts to repeat itself, you 
> won't know about it, unless you happened to test exactly that data. The 
> algorithm may be perfect, but a silly bug can blow it all.

In fact there are silly bugs yet to be fixed.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
