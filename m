Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311180AbSCWUHz>; Sat, 23 Mar 2002 15:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311238AbSCWUHq>; Sat, 23 Mar 2002 15:07:46 -0500
Received: from zero.tech9.net ([209.61.188.187]:14862 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S311180AbSCWUHi>;
	Sat, 23 Mar 2002 15:07:38 -0500
Subject: Re: [PATCH] 3c59x and resume
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: christophe =?ISO-8859-1?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C9CCBEB.D39465A6@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 23 Mar 2002 15:06:49 -0500
Message-Id: <1016914030.949.20.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-03-23 at 13:39, Andrew Morton wrote:

> in modules.conf, and we really have eight NICS, and they're
> being plugged and unplugged, how can we reliably associate
> that option with the eight cards?  So the right option is
> applied to each card eash time it's inserted?  Should the
> option be associated with a card, or with a bus position?

Ugh, not pretty.

Associate it with the bus position I'd say?

If we want a statically allocated array, create one of size N such that
N is reasonably sane.  Then we can "hash" the bus position onto N ...
something that basically maps the slot number onto N, slot number % N
will do.  Dealing with collisions would be easy, but there really
shouldn't be any in a sane configuration.

Ideally we'd have a dynamically created array for the cards and hash
into that, but, ugh, this is getting gross especially since 99% of us
have one card and never remove it.

	Robert Love

