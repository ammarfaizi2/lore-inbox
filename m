Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSJHSPn>; Tue, 8 Oct 2002 14:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbSJHSPn>; Tue, 8 Oct 2002 14:15:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:17305 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261353AbSJHSPk>; Tue, 8 Oct 2002 14:15:40 -0400
Date: Tue, 8 Oct 2002 15:21:02 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org, <ext2-devel@lists.sourceforge.net>
Subject: Re: [RFC] [PATCH 1/4] Add extended attributes to ext2/3
In-Reply-To: <E17yymB-00021j-00@think.thunk.org>
Message-ID: <Pine.LNX.4.44L.0210081519490.1648-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002 tytso@mit.edu wrote:

> This first patch creates a generic interface for registering caches with
> the VM subsystem so that they can react appropriately to memory
> pressure.

> +/* BKL must be held */

... but it isn't.  Also, kswapd isn't holding the bkl while
traversing the list.

> +void register_cache(struct cache_definition *cache)
> +{
> +	list_add(&cache->link, &cache_definitions);
> +}

I suspect you'll want a semaphore for the cache_definitions
list.

cheers,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

