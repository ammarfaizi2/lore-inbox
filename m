Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131023AbQLUViT>; Thu, 21 Dec 2000 16:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131136AbQLUViJ>; Thu, 21 Dec 2000 16:38:09 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:12023 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131023AbQLUViC>; Thu, 21 Dec 2000 16:38:02 -0500
Date: Thu, 21 Dec 2000 18:46:33 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Sourav Sen <sourav@csa.iisc.ernet.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: Wiring down Pages
In-Reply-To: <Pine.SOL.3.96.1001222011552.20552A-100000@kohinoor.csa.iisc.ernet.in>
Message-ID: <Pine.LNX.4.21.0012211845070.1613-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2000, Sourav Sen wrote:

> 	Suppose I want to wire-down( as they call in BSD ) a page
> in memory, how I go about doing that? (I guess by setting the
> PG_locked bit of the flags field in the struct page, I can do
> it, am I right?)

Linux simply uses page->count for this. By using the page->count,
multiple parts of the kernel can pin the same page in memory at
different times and unlock them at different times without any
locking/unlocking conflicts...

page_cache_get(page);  <= increases page->count

<your critical stuff here>

page_cache_drop(page); <= removes your extra count

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
