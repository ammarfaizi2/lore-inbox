Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131953AbRCVKEA>; Thu, 22 Mar 2001 05:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131958AbRCVKDu>; Thu, 22 Mar 2001 05:03:50 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23682 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131953AbRCVKDk>;
	Thu, 22 Mar 2001 05:03:40 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15033.52672.923596.590263@pizda.ninka.net>
Date: Thu, 22 Mar 2001 02:02:40 -0800 (PST)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: kswapd deadlock 2.4.3-pre6
In-Reply-To: <Pine.LNX.4.21.0103220411070.3306-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.31.0103212217320.10817-100000@penguin.transmeta.com>
	<Pine.LNX.4.21.0103220411070.3306-100000@freak.distro.conectiva>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo Tosatti writes:
 > Are you sure flush_page_to_ram()/flush_icache_page() without
 > page_table_lock held is ok for all archs? 

This is actually a sticky area.  For example, I remember that a long
time ago I noticed that it wasn't necessarily guarenteed that even
all the flush_tlb_{page,mm,range}() stuff was done under the page
table lock.

Maybe things have changed since then, but...

Furthermore I did not specify that flush_page_to_ram/flush_icache_page
can assume this, see Documentation/cachetlb.txt

I have no problem adding this invariant to some of the interfaces, but
we have to audit things.

 > Looking at arch/mips/mm/r2300.c:

The r2300 port is UP-only btw...

Later,
David S. Miller
davem@redhat.com
