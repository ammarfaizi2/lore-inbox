Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbQKPMbt>; Thu, 16 Nov 2000 07:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbQKPMbj>; Thu, 16 Nov 2000 07:31:39 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:30973 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129245AbQKPMbe>; Thu, 16 Nov 2000 07:31:34 -0500
Date: Thu, 16 Nov 2000 10:01:11 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Christoph Rohland <cr@sap.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: shm swapping in 2.4 again
In-Reply-To: <qww1ywcz5z4.fsf@sap.com>
Message-ID: <Pine.LNX.4.21.0011160959340.13085-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Nov 2000, Christoph Rohland wrote:
> On Wed, 15 Nov 2000, Rik van Riel wrote:
> > On 15 Nov 2000, Christoph Rohland wrote:
> > You really want to have it in the swap cache, so we have
> > a place for it allocated in cache, etc...
> > 
> > Basically, when we unmap it in try_to_swap_out(), we
> > should add the page to the swap cache, and when the
> > last user stops using the page, we should push the
> > page out to swap.
> 
> So in shm_swap_out I check if the page is already in the swap
> cache. If not I put the page into it and note the swap entry in
> the shadow pte of shm. Right?

Exactly. And I'll change page_launder() to:
1. write dirty swap cache pages to disk
2. do some IO clustering (maybe) or rely on luck ;)

> So does the page live all the time in the swap cache? This would
> lead to a vastly increased swap usage since we would have to
> preallocate the swap entries on page allocation.

If the usage count of the swap entry is 1 (all users of the
page have swapped it in and the swap cache is the only user),
then we can free the page from swap and the swap cache.

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
