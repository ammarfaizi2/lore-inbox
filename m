Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbUBKI6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 03:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbUBKI6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 03:58:35 -0500
Received: from ns.suse.de ([195.135.220.2]:36294 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263792AbUBKI6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 03:58:33 -0500
To: Alex Pankratov <ap@swapped.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] [2/2] hlist: remove IFs from hlist functions
References: <4029CB7E.4030003@swapped.cc.suse.lists.linux.kernel>
	<4029CF24.1070307@osdl.org.suse.lists.linux.kernel>
	<4029D2D5.7070504@swapped.cc.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 11 Feb 2004 09:55:34 +0100
In-Reply-To: <4029D2D5.7070504@swapped.cc.suse.lists.linux.kernel>
Message-ID: <p73y8ra5721.fsf@nielsen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Pankratov <ap@swapped.cc> writes:

> Stephen Hemminger wrote:
> >  +++ linux-2.6.2.hlist/lib/list.c    2004-02-10 13:03:08.000000000 -0800
> >
> >> @@ -0,0 +1,10 @@
> >> +#include <linux/module.h>
> >> +#include <linux/list.h>
> >> +
> >> +/*
> >> + *    shared tail sentinel for hlists
> >> + */
> >> +struct hlist_node hlist_null;
> > Could this be const?
> 
> No, because its 'pprev' field *is* getting modified.

I didn't notice this before, sorry. But this could end up 
being a scalability problem on big SMP systems. Even though
the cache line of this is never read it will bounce all the
time between all CPUs using hlists and add considerably 
latency and cross node traffic. Remember Linux is supposed
to run well on 128 CPU machines now.

Maybe you can make it UP only, but I'm still not sure it's 
worth it.

-Andi
