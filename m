Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289963AbSAWS6o>; Wed, 23 Jan 2002 13:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289971AbSAWS6e>; Wed, 23 Jan 2002 13:58:34 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:12556 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289963AbSAWS6R>;
	Wed, 23 Jan 2002 13:58:17 -0500
Date: Wed, 23 Jan 2002 16:57:58 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] rmap VM, version 12
In-Reply-To: <20020123.104438.71552152.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0201231650450.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, David S. Miller wrote:

>    From: Rik van Riel <riel@conectiva.com.br>
>    Date: Wed, 23 Jan 2002 15:14:42 -0200 (BRST)
>
>      - use fast pte quicklists on non-pae machines           (Andrea Arcangeli)
>
> Does this work on SMP?  I remember they were turned off because
> they were simply broken on SMP.
>
> The problem is that when vmalloc() or whatever kernel mappings change
> you have to update all the quicklist page tables to match.

Actually, this is just using the pte_free_fast() and
{get,free}_pgd_fast() functions on non-pae machines.

I think this should be safe, unless there is a way
we could pagefault from inside interrupts (but I don't
think we do that).

OTOH, the -preempt people will want to add preemption
protection from the fiddling with the local pte freelist ;)

> Andrea probably fixed this, I haven't looked at the patch.
> If so, ignoreme.

He doesn't seem to fix anything other than just switching
on these options, but I guess this is safe since it's with
the 00_ series of patches in -aa.

(I don't have good experiences with 20_highmem-debug-8,
with that patch in the system plain doesn't boot ;))

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

