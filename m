Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbTJSBzV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 21:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTJSBzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 21:55:21 -0400
Received: from [193.138.115.2] ([193.138.115.2]:18702 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S261471AbTJSBzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 21:55:18 -0400
Date: Sun, 19 Oct 2003 03:53:35 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Roland Dreier <roland@digitalvampire.org>
cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6.0-test8 __might_sleep warnings on boot
In-Reply-To: <878yniowgn.fsf@love-shack.home.digitalvampire.org>
Message-ID: <Pine.LNX.4.56.0310190349090.7420@jju_lnx.backbone.dif.dk>
References: <87he26p6pq.fsf@love-shack.home.digitalvampire.org>
 <20031018161439.484915f8.akpm@osdl.org> <87d6cuozm7.fsf@love-shack.home.digitalvampire.org>
 <20031018172140.4968e273.akpm@osdl.org> <878yniowgn.fsf@love-shack.home.digitalvampire.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Oct 2003, Roland Dreier wrote:

> -	if (in_atomic() || irqs_disabled()) {
> +	/* Don't print warnings until system_running is set.  This avoids
> +	   spurious warnings during boot before local_irq_enable() and
> +	   init_idle(). */
> +	if (system_running && (in_atomic() || irqs_disabled())) {

Wouldn't this :

if ((in_atomic() || irqs_disabled()) && system_running)

be slightly more efficient?   The reason I say that is that I would assume
that the chance of (in_atomic() || irqs_disabled()) being false is greater
than the chance of !system_running - if that is so, then reordering the if
will allow it to break out early more often...

Is that a completely rediculous thing to do?


Regards,

Jesper Juhl
