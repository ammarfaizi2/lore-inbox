Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287401AbSAGXmS>; Mon, 7 Jan 2002 18:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287388AbSAGXmI>; Mon, 7 Jan 2002 18:42:08 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:58372 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287401AbSAGXl5>;
	Mon, 7 Jan 2002 18:41:57 -0500
Date: Mon, 7 Jan 2002 21:41:18 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving oom detection in rmap10c.
In-Reply-To: <20020107230138.BBE15AE10@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.33L.0201072139210.872-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Ed Tomlinson wrote:

> I did not think this would solve all the OOM problems.

> Hope your audit discloses other problems.

OK, a silly one in try_to_free_pages(), I think there are some
code paths where we can end up calling the thing, sleeping for
a bit on some lock and then ending up not having to do any work,
because another thread already did this. In that case, 'ret'
will be zero, so I've changed the code below ...

        if (!ret)
                out_of_memory();

... to the following:

        if (!ret && free_low(ALL_ZONES) > 0)
                out_of_memory();

This will be part of rmap-11 ;)

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

