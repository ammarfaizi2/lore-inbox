Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275447AbRJFSQd>; Sat, 6 Oct 2001 14:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275448AbRJFSQX>; Sat, 6 Oct 2001 14:16:23 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:10259 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S275447AbRJFSQP>;
	Sat, 6 Oct 2001 14:16:15 -0400
Date: Sun, 7 Oct 2001 04:12:01 +1000
From: Anton Blanchard <anton@samba.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
Message-ID: <20011007041201.D15309@krispykreme>
In-Reply-To: <Pine.LNX.4.33L.0110061357560.12110-200000@imladris.rielhome.conectiva> <Pine.LNX.3.96.1011006194028.5632A-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1011006194028.5632A-100000@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Of course vmalloc space can overflow - but it overflows only when the
> machine is overloaded with too many processes, too many processes with
> many filedescriptors etc. On the other hand, the buddy allocator fails
> *RANDOMLY*. Totally randomly, depending on cache access patterns and
> page allocation times.

vmalloc space is also much worse for tlb usage when the main kernel mapping
uses large hardware ptes. Ingo and davem pointed this out to me recently
when I wanted to allocate the pagecache hash using vmalloc (at the
moment it maxes out at order 10 which is much to small for machines
with large memory).

If you could get away with a single page stack, then you could allocate
the task struct separately and avoid any order 1 allocation. But you
would probably need interrupt stacks to get away with a single page
stack.

Anton
