Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290244AbSAXDuO>; Wed, 23 Jan 2002 22:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290246AbSAXDuE>; Wed, 23 Jan 2002 22:50:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:1391 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S290244AbSAXDtx>; Wed, 23 Jan 2002 22:49:53 -0500
Date: Thu, 24 Jan 2002 04:50:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: riel@conectiva.com.br, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH *] rmap VM, version 12
Message-ID: <20020124045055.F20533@athlon.random>
In-Reply-To: <20020123.112837.112624842.davem@redhat.com> <Pine.LNX.4.33L.0201231735540.32617-100000@imladris.surriel.com> <20020123.121857.18310310.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020123.121857.18310310.davem@redhat.com>; from davem@redhat.com on Wed, Jan 23, 2002 at 12:18:57PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 12:18:57PM -0800, David S. Miller wrote:
>    
>    OK, so only the _pgd_ quicklist is questionable and the
>    _pte_ quicklist is fine ?
> 
> That is my understanding.

pgd cache is fine too, the page fault will update the pgd using
swapper_pg_dir accordingly if needed. The swapper_pg_dir will only fault
in new pmd, it will never deallocate them (vfree only invalidates the
pte and free the pages), so it's safe. If vfree would deallocate them
just a simple context switch would break, no matter of the pgd cache.

Andrea
