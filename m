Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbTJTIwi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 04:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbTJTIwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 04:52:38 -0400
Received: from [193.138.115.2] ([193.138.115.2]:21779 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S262454AbTJTIwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 04:52:36 -0400
Date: Mon, 20 Oct 2003 10:28:55 +0200 (CEST)
From: Jesper Juhl <juhl@dif.dk>
To: Roland Dreier <roland@digitalvampire.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6.0-test8 __might_sleep warnings on boot
In-Reply-To: <874qy5ox4s.fsf@love-shack.home.digitalvampire.org>
Message-ID: <Pine.LNX.4.56.0310201024590.12726@jju_lnx.backbone.dif.dk>
References: <87he26p6pq.fsf@love-shack.home.digitalvampire.org>
 <20031018161439.484915f8.akpm@osdl.org> <87d6cuozm7.fsf@love-shack.home.digitalvampire.org>
 <20031018172140.4968e273.akpm@osdl.org> <878yniowgn.fsf@love-shack.home.digitalvampire.org>
 <Pine.LNX.4.56.0310190349090.7420@jju_lnx.backbone.dif.dk>
 <874qy5ox4s.fsf@love-shack.home.digitalvampire.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Oct 2003, Roland Dreier wrote:

> >>>>> " " == Jesper Juhl <juhl-lkml@dif.dk> writes:
>
>     > On Sun, 18 Oct 2003, Roland Dreier wrote:
>     >
>     > > -	if (in_atomic() || irqs_disabled()) {
>     > > +	/* Don't print warnings until system_running is set.  This avoids
>     > > +	   spurious warnings during boot before local_irq_enable() and
>     > > +	   init_idle(). */
>     > > +	if (system_running && (in_atomic() || irqs_disabled())) {
>     >
>     > Wouldn't this :
>     >
>     > if ((in_atomic() || irqs_disabled()) && system_running)
>     >
>     > be slightly more efficient?   The reason I say that is that I would assume
>     > that the chance of (in_atomic() || irqs_disabled()) being false is greater
>     > than the chance of !system_running - if that is so, then reordering the if
>     > will allow it to break out early more often...
>
> Yes, I think you're right about the efficiency.  However, I didn't
> think this was a performance-critical code path (especially since it
> is only turned on by a debugging config option),

No, I don't think it is critical in any way either. I just read the patch
and thought "why not do it the most efficient way even if it's not a
critical path?"...
But I'm probably just being a pedant here...

> and the way I wrote
> it matched the way I was thinking about the test ("If the system is
> running, then check if we're in atomic or have irqs disabled").
> But I don't think it matters much either way.
>
Probably not.


/Jesper Juhl

