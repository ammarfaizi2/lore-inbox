Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268587AbTGIXit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268758AbTGIXhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:37:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12416 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268725AbTGIXgD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:36:03 -0400
Date: Wed, 9 Jul 2003 19:51:01 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: modutils-2.3.15 'insmod'
In-Reply-To: <bei5sq$9ba$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.53.0307091946070.878@chaos>
References: <Pine.LNX.4.53.0307091119450.470@chaos> <jer84zln59.fsf@sykes.suse.de>
 <bei5sq$9ba$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jul 2003, H. Peter Anvin wrote:

> Followup to:  <jer84zln59.fsf@sykes.suse.de>
> By author:    Andreas Schwab <schwab@suse.de>
> In newsgroup: linux.dev.kernel
> >
> > "Richard B. Johnson" <root@chaos.analogic.com> writes:
> >
> > |> It is likely that malloc(0) returning a valid pointer is a bug
> > |> that has prevented this problem from being observed.
> >
> > It's not a bug, it's a behaviour explicitly allowed by the C standard.
> >
>
> The bug is in xmalloc, meaning that it assumes that returning NULL is
> always an error.  Presumably xmalloc should look *either* like:
>
> void *xmalloc(size_t s)
> {
> 	void *p = malloc(s);
>
> 	if ( !p && s )
> 		barf();
> 	else
> 		return p;
> }
>
> ... or ...
>
> void *xmalloc(size_t s)
> {
> 	void *p;
>
> 	/* Always return a valid allocation */
> 	if ( s == 0 ) s = 1;
> 	p = malloc(s);
>
> 	if ( !p )
> 		barf();
> 	else
> 		return p;
> }

You are correct that the bug is in xmalloc(). However, I think the
true bug is that xmalloc() exists! Malloc should be called directly
and any special cases for that specific call should be handled at
that time.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

