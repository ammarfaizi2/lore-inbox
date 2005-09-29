Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVI2Gtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVI2Gtw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 02:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVI2Gtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 02:49:52 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:43682 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932100AbVI2Gtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 02:49:50 -0400
Date: Thu, 29 Sep 2005 02:49:31 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Nikita Danilov <nikita@clusterfs.com>
cc: Roland Dreier <rolandd@cisco.com>, dwalker@mvista.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT: epca_lock to DEFINE_SPINLOCK
In-Reply-To: <17211.139.119978.52725@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.58.0509290243320.10496@localhost.localdomain>
References: <1127845928.4004.24.camel@dhcp153.mvista.com>
 <1127900349.2893.19.camel@laptopd505.fenrus.org> <52irwlmb1y.fsf@cisco.com>
 <17211.139.119978.52725@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Sep 2005, Nikita Danilov wrote:

>
> The only reasonable case where DEFINE_FOO(x) is really necessary is when
> initializer uses address of x, but even in that case something like
>
>         spinlock_t guard = SPINLOCK_UNLOCKED(guard);
>
> is much more readable than
>
>         DEFINE_SPIN_LOCK(guard);
>

Except that the former is also error prone. I just found a bug in my code
(I customize Ingo's RT kernel) where I had a cut and paste error:

spinlock_t a = SPINLOCK_UNLOCKED(a);
spinlock_t b = SPINLOCK_UNLOCKED(a);

This took me two days to find since the problems occurred elsewhere.

-- Steve

