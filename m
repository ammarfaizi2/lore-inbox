Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312442AbSCTLs6>; Wed, 20 Mar 2002 06:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312443AbSCTLst>; Wed, 20 Mar 2002 06:48:49 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:18960 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S312442AbSCTLsm>; Wed, 20 Mar 2002 06:48:42 -0500
Date: Wed, 20 Mar 2002 12:48:37 +0100
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: using kmalloc
Message-ID: <20020320114837.GA5421@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <fa.l19uvvv.1hjmo8t@ifi.uio.no> <010101c1cfd3$8a87cfd0$1a02a8c0@allyourbase>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kmalloc() allocates physically-contiguous pages of memory. Due to
> fragmentation, more than 64KB-128KB of contiguous pages might not be
> available, and hence kmalloc() will fail.

kmalloc allocates from generic slab caches. They come in sizes of powers
of 2 from 32B to 128KiB. The largest has slabs 128KiB large (on i386 at least).
Pages are allocated via __get_free_pages, so they have to be continuous.

However if you allocate namy instances of some structure, it's best to create
a kmem cache and allocate via kmem_cache_alloc (since it does not round the
requested size up to a power of two).

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
