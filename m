Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbSIZADF>; Wed, 25 Sep 2002 20:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbSIZADF>; Wed, 25 Sep 2002 20:03:05 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:32185 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261242AbSIZADE>; Wed, 25 Sep 2002 20:03:04 -0400
Date: Wed, 25 Sep 2002 21:08:02 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Lightweight Patch Manager <patch@luckynet.dynu.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tomas Szepe <szepe@pinerecords.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][2.5] Single linked lists for Linux,v2
In-Reply-To: <20020925225026.96C153@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44L.0209252107110.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, Lightweight Patch Manager wrote:

> Again single linked lists...

And again with errors ;)


> +#define INIT_SLIST_HEAD(name)			\
> +	(name->next = name)
> +
> +#define SLIST_HEAD(type,name)			\
> +	typeof(type) name = INIT_SLIST_HEAD(name)

Fun, so the list head points to itself ...

> +#define slist_for_each(pos, head)				\
> +	for (pos = head; pos && ({ prefetch(pos->next); 1; });	\
> +	    pos = pos->next)

... imagine what that would do in combination with this macro.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

