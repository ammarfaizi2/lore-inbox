Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSEGMxZ>; Tue, 7 May 2002 08:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315438AbSEGMxY>; Tue, 7 May 2002 08:53:24 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:42251 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S315437AbSEGMxU>; Tue, 7 May 2002 08:53:20 -0400
Date: Mon, 6 May 2002 23:25:37 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Reza Roboubi <reza@parvan.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: REPOSTING: vm: detecting age of page
In-Reply-To: <22C8433D3EEC964DB1E84A293A42774B040776@neural.parvan.net>
Message-ID: <Pine.LNX.4.44L.0205062323500.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2002, Reza Roboubi wrote:

> I read the following about the /proc/sys/vm/swapctl values:
>
>  * If the page was used since the last time we scanned, its age is
> increased by sc_page_advance (default 3). Where the maximum value is
> given by sc_max_page_age (default 20).
>
>  * Otherwise (meaning it wasn't used) its age is decreased by
> sc_page_decline (default 1).
>
> Question:
> How can the intel hardware detect page access if the page is mapped into
> the process' VM(and resident in RAM)?  If detecting such access is
> impossible, then how does kswapd decide the page "age" in this case?

Traditionally page aging would be done on the physical page while
scanning the virtual address space of processes.

Of course, this had (in 2.0) the side effect of down aging a page
from libc.so which wasn't used in 20 processes but was used in the
3 processes that weren't asleep ;)

In the (new, experimental) reverse mapping VM Linux has pointers
from the physical pages back to the virtual mappings to the page
so it can actually get the page aging right.

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

