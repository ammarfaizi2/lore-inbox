Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTLDOOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 09:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTLDOOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 09:14:44 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:4740 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262081AbTLDOOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 09:14:42 -0500
Date: Thu, 4 Dec 2003 15:14:40 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: Worst recursion in the kernel
Message-ID: <20031204141440.GB7890@wohnheim.fh-wedel.de>
References: <20031203143122.GA6470@wohnheim.fh-wedel.de> <20031203100709.B6625@sonic.net> <20031203190440.GA15857@wohnheim.fh-wedel.de> <20031203225743.A25889@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031203225743.A25889@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 December 2003 22:57:43 +0000, Russell King wrote:
> 
> Yes, but the condition of the /data/ is such that it will not recurse.

Yes, so?

> A pure "can this function call that function" analysis ignoring the
> state of the data will say this will infinitely recuse.  Include
> the data, and you'll find it has a very definite recursion limit.

That is what I do.  My program takes hints saying "this recursion can
only loop n times".  But I don't want to add semantic checking of the
source itself, so a human has to give the hint.  Also, the human has
to uniquely hint at a single recursion.

If you accept this approach, there is no way to deal with multiple
linked recursions like this:
a->b->c->d
      `->b

The human would have to say something like "the big recursion can only
happen five times, unless the short recursion from c to b happened.
In this case...".  No thanks.

In fact, most recursions in the kernel are functions calling itself
again, there are just a few over several functions.  So I honestly
wonder if recursion over multiple functions should be handled by my
program at all, or if I should just warn when seeing them.

There might be valid cases for two or three functions involved, so I
am not sure yet.  But I sure as hell won't handle those cases before
seeing a valid use first and the one causing this thread sure isn't.

Jörn

-- 
But this is not to say that the main benefit of Linux and other GPL
software is lower-cost. Control is the main benefit--cost is secondary.
-- Bruce Perens
