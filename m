Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130056AbQJZRMP>; Thu, 26 Oct 2000 13:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130059AbQJZRMF>; Thu, 26 Oct 2000 13:12:05 -0400
Received: from brutus.conectiva.com.br ([200.250.58.146]:65020 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130056AbQJZRLx>; Thu, 26 Oct 2000 13:11:53 -0400
Date: Thu, 26 Oct 2000 15:11:25 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: "Forever shall I be." <zinx@microsoftisevil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 3-order allocation failed
In-Reply-To: <20001026091847.A30837@bliss.zebra.net>
Message-ID: <Pine.LNX.4.21.0010261508530.15696-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2000, Forever shall I be. wrote:
> On Thu, Oct 26, 2000 at 02:57:30PM +0300, Pasi Kärkkäinen wrote:

> > __alloc_pages: 2-order allocation failed.
> > __alloc_pages: 2-order allocation failed.
> > __alloc_pages: 5-order allocation failed.
> > __alloc_pages: 4-order allocation failed.
> > __alloc_pages: 3-order allocation failed.
> > __alloc_pages: 2-order allocation failed.
> > __alloc_pages: 5-order allocation failed.
> > 
> > Any ideas?
> 
> I'm getting __alloc_pages: 7-order allocation failed.
> all the time in 2.4.0-test9 on my "pIII (Katmai)".. kernel's
> compiled with 2.95.2 + bounds, without -fbounds-checking

It means something in the system is trying to allocate a
large continuous area of memory that isn't available...

The printk is basically a debug output indicating that we
don't have the large physically contiguous area available
that's being requested.

Basically everything bigger than order-1 (2 contiguous
pages) is unreliable at runtime. Orders 2 and 3 should
usually be available (if you only allocate very few of
them) and higher orders should not be relied upon.

If somebody is seeing a lot of these messages, it means
that some driver in the system is asking unreasonable
things from the VM subsystem ;)

(and buffer allocations are failing)

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
