Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289978AbSAWTaO>; Wed, 23 Jan 2002 14:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289987AbSAWTaG>; Wed, 23 Jan 2002 14:30:06 -0500
Received: from pizda.ninka.net ([216.101.162.242]:27264 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289978AbSAWT3v>;
	Wed, 23 Jan 2002 14:29:51 -0500
Date: Wed, 23 Jan 2002 11:28:37 -0800 (PST)
Message-Id: <20020123.112837.112624842.davem@redhat.com>
To: riel@conectiva.com.br
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH *] rmap VM, version 12
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0201231720460.32617-100000@imladris.surriel.com>
In-Reply-To: <20020123.110624.93021436.davem@redhat.com>
	<Pine.LNX.4.33L.0201231720460.32617-100000@imladris.surriel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Wed, 23 Jan 2002 17:22:30 -0200 (BRST)

   On Wed, 23 Jan 2002, David S. Miller wrote:
   
   >    Actually, this is just using the pte_free_fast() and
   >    {get,free}_pgd_fast() functions on non-pae machines.
   >
   > Rofl, you can't just do that.  The page tables cache caches the kernel
   > mappings and if you don't update them properly on SMP you die.
   
   Umm, this list just contains _freed_ page tables without
   any mappings, right ?
   
No.

   If there is some specific magic I'm missing, could you
   please point me to the code I'm overlooking ? ;)
   
Look at what get_pgd_slow() in pgalloc.h does, this is the
case where it isn't going to the cache and it is really allocating the
memory.

When the pgd comes fresh off the cache chain, it doesn't do any
of this stuff, it just gives you the cached PGD with all the PMD's
filled in already, including the kernel PMDs.

Hmmm... maybe the "we can fault on kernel mappings" thing takes
care of this because kernel PMDs can only appear, not go away.
