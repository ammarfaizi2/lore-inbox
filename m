Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263419AbTIGRpf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 13:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbTIGRpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 13:45:35 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:62350 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263419AbTIGRpc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 13:45:32 -0400
Date: Sun, 7 Sep 2003 18:43:41 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org, robert@schwebel.de,
       rusty@rustcorp.com.au
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030907174341.GA21260@mail.jlokier.co.uk>
References: <200309071647.h87Glp4t014359@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309071647.h87Glp4t014359@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> There is to the best of my knowledge nothing in 2.6.0-test4
> that prevents a kernel compiled for CPU type N from working
> with CPU types >N. Just to prove it, I built a CONFIG_M486
> 2.6.0-test4 and booted it w/o problems on P4, PIII, and K6-III.

You may be right, although I wonder if there are real problems like an
SMP Pentium kernel not setting up MTRRs when run on an SMP P3.

The main problems are:

	1. Optimisation.  A kernel optimised for P3 but compatible
	   with 486 needs to use 64 byte cache line alignment, and TSC
	   for timing, but not use any SSE instructions.

	   This is different from a kernel optimised for a 486.

	2. The CPU types are not a total order.  Say I want a kernel
	   that supports Athlons and a Centaur for my cluster.  What
	   CPU setting should I use?  What CPU setting will give my the best
	   performing kernel - and is that the same as the one for smallest
	   kernel?

	3. Like 2, but for embedded systems.  I'm (hypothetically)
	   selling a cable modem which was originally based on one
	   CPU, but we changed to a different one because it was
	   cheaper.  I need to send out a firmware upgrade, and it is
	   convenient to use a kernel which can run on either model.
	   But I don't want to compile in support for every x86,
	   because space is tight, and I want it to run as fast as it
	   can given that it could run on either of the two chips.

> How are 1 and 2 different? Both need support for CPU type N
> or higher. Since a kernel configured for a lower CPU type
> still works on higher CPU types, where is the problem?
> (In case 2 configure for PIII and use that on PIII and P4.)

I'm not sure if an Athlon is "lower" than a PII or not....  Which do I
option do I pick, to run on either of those without including
redundant stuff for older CPUs?

-- Jamie
