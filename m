Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265268AbUFRWKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265268AbUFRWKo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbUFRWH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:07:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:51942 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264906AbUFRVxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:53:18 -0400
Date: Fri, 18 Jun 2004 14:55:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, Robert.Picco@hp.com
Subject: Re: [PATCH] HPET driver
Message-Id: <20040618145531.015fbc12.akpm@osdl.org>
In-Reply-To: <40D35740.8070206@pobox.com>
References: <200406181616.i5IGGECd003812@hera.kernel.org>
	<40D35740.8070206@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > 	[PATCH] HPET driver
> > 	
>
> Was this posted on lkml, or simply snuck in?

Was posted on lkml, was fairly widely reviewed, had comments from hch and
others, had several fixes from myself and from Robert and a long discussion
wrt the readq() implementation.

I'm not very happy with the driver, if only because its size and its prior
defect rate indicates that it probably has more problems.  But it provides
support for new hardware which is being shipped in real products and we
need it.  So ultimately one has to jam it into the tree in the hope that
doing so will get it a bit more attention.

> This should NOT have been merged without changes.  Please fix ASAP, or 
> revert and keep in -mm for a while.

Translation: Andrew has to personally understand and review every line
which goes into the kernel, unaided.  Sorry, that doesn't work.

The patch was reviewed on lkml and has been in -mm for test and review for
five weeks.  The initial reviews were not complete and sufficient attention
was not paid to it while it was in -mm.

To improve this process I need to find a way of provoking more attention
toward patches which I am not particularly confident about (and this one
certainly fell in that category).  Thus far I've done that by merging them
into the main tree, which does work quite nicely.  Perhaps I should send
these patches to lkml beforehand with big warning labels on them.

wrt the readq() implementation: I reverted the generic implementation based
on concerns raised on lkml by Eric Biederman.  As a generic readq/writeq
implementation seems to be a new R&D project I decided to leave the
implementation private to the HPET driver until someone takes all of this
on.

wrt the hpets list locking: yeah, I noticed that, mentioned it to Robert
then forgot all about it.  Mea Culpa.

wrt the request_irq() bug: yipes.  Robert, please fix.

wrt the new miscdev minor: yes, devices.txt should be updated.  When the
patch was first posted it was using a new major, but Robert changed that
based on review comments.

