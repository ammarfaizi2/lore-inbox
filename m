Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbTF2CP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 22:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265524AbTF2CP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 22:15:56 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39158 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265521AbTF2CPz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 22:15:55 -0400
Subject: Re: /dev/random broken?
From: Robert Love <rml@tech9.net>
To: Justin Pryzby <justinpryzby@users.sourceforge.net>
Cc: "Luca T." <luca-t@libero.it>, linux-kernel@vger.kernel.org
In-Reply-To: <20030629021018.GA26162@andromeda>
References: <E19WOvK-0001I7-00@andromeda> <20030629021018.GA26162@andromeda>
Content-Type: text/plain
Message-Id: <1056853901.1988.3206.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 28 Jun 2003 19:31:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-28 at 19:10, Justin Pryzby wrote:

> /dev/urandom is what you want; it makes up its own entropy.  /dev/random
> uses entropy from user input (low order bits I imagine).  I assume that
> this is how other unixes work, too.

Actually, no. Both device files use entropy from the same location (the
entropy pool), which is derived from the same sources (various interrupt
timings and whatnot).

The difference between the two is that /dev/random keeps track of the
inherent entropy in the pool and will block when the entropy grows too
small. This is done as protection against any possible flaws in the
one-way hash employed on outgoing data. Theoretically, if someone was
able to break SHA-1, and they obtained a sufficiently large percentage
of the output data, they could theoretically determine some theoretical
state about the entropy pool. To prevent this theoretical attack,
/dev/random will not return any data while the entropy estimate is not
positive. This ensures there is enough entropy in the pool such that,
even if a single attacker has seen all the output thus far, they cannot
learn of the pool's state.

Also, as far as other Unix systems, I think /dev/random was first in
Linux. I know Mac OS X has /dev/random and /dev/urandom, but they both
behave like Linux's /dev/urandom.

	Robert Love


