Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbUKSWKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbUKSWKX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUKSWHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:07:38 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:39412 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261649AbUKSWGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 17:06:49 -0500
Date: Fri, 19 Nov 2004 15:06:47 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, dhowells@redhat.com, torvalds@osdl.org,
       davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH] Additional kgdb hooks
Message-ID: <20041119220647.GK16043@smtp.west.cox.net>
References: <200411081432.iA8EWf0c023426@warthog.cambridge.redhat.com> <20041108144433.079f0f7c.akpm@osdl.org> <419152D8.9030303@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419152D8.9030303@mvista.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 03:29:28PM -0800, George Anzinger wrote:
> Andrew Morton wrote:
> >dhowells@redhat.com wrote:
> >
> >>The attached patch adds a couple of extra hooks by which kgdb or an 
> >>equivalent
> >>gdbstub can catch bad_page() and panic() invocations.
> >
> >
> >Tom is valiantly flogging his way through a generic KGDB implementation.  I
> >think it would be better to push ahead with that and to not put into
> >generic code hooks which are specific to one arch's kgdb implementation.
>
> IMNSHO the trap should be in dump_stack().  That way it catches a bunch of 
> things all at once.

The hard question is how to do this cleanly.  Perhaps changing things
slightly so that lib/dump_stack.c provides the 'true' dump_stack() (or
moving it to kernel/dump_stack.c) which calls a notify chain and then
arch_dump_stack() ?

> Also, panic has a notify option that kgdb should use just like everybody 
> else.

This is a good idea, I'm surprised we didn't already do, so I've just
done it.

-- 
Tom Rini
http://gate.crashing.org/~trini/
