Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262203AbSIZGaW>; Thu, 26 Sep 2002 02:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262204AbSIZGaW>; Thu, 26 Sep 2002 02:30:22 -0400
Received: from pD9E23892.dip.t-dialin.net ([217.226.56.146]:45796 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S262203AbSIZGaV>; Thu, 26 Sep 2002 02:30:21 -0400
Date: Thu, 26 Sep 2002 00:36:07 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Rik van Riel <riel@conectiva.com.br>
cc: Lightweight Patch Manager <patch@luckynet.dynu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tomas Szepe <szepe@pinerecords.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][2.5] Single linked lists for Linux,v2
In-Reply-To: <Pine.LNX.4.44L.0209252107110.22735-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0209260033420.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 25 Sep 2002, Rik van Riel wrote:
> > +#define INIT_SLIST_HEAD(name)			\
> > +	(name->next = name)
> > +
> > +#define SLIST_HEAD(type,name)			\
> > +	typeof(type) name = INIT_SLIST_HEAD(name)
> 
> Fun, so the list head points to itself ...
> 
> > +#define slist_for_each(pos, head)				\
> > +	for (pos = head; pos && ({ prefetch(pos->next); 1; });	\
> > +	    pos = pos->next)
> 
> ... imagine what that would do in combination with this macro.

I'm aware of that possibility. What would you initialize it to, if not the 
list itself? (And BTW, anyone have a solution for slist_add()?)

We could set it to NULL, but where would we end?

#define INIT_SLIST_HEAD(name)				\
	(name->next = NULL)

#define SLIST_HEAD_INIT(name)	name

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

