Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135919AbRD3Vxm>; Mon, 30 Apr 2001 17:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135920AbRD3Vxc>; Mon, 30 Apr 2001 17:53:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:129 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135919AbRD3VxX>;
	Mon, 30 Apr 2001 17:53:23 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15085.57019.228317.281735@pizda.ninka.net>
Date: Mon, 30 Apr 2001 14:52:59 -0700 (PDT)
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Fabio Riccardi <fabio@chromium.com>, Ingo Molnar <mingo@elte.hu>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, <David_J_Morse@Dell.com>
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <Pine.LNX.4.33.0104301444160.14436-100000@twinlark.arctic.org>
In-Reply-To: <3AEDBEB8.449D88C3@chromium.com>
	<Pine.LNX.4.33.0104301444160.14436-100000@twinlark.arctic.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dean gaudet writes:
 > On Sun, 29 Apr 2001, David S. Miller wrote:
 > 
 > > If you do the TCP_CORK thing, what you end up with is a scatter gather
 > > entry in the SKB for the header bits, then the page cache segments.
 > 
 > so then the NIC would be sent a 3 entry gather list -- 1 entry for TCP/IP
 > headers, 1 for HTTP headers, and 1 for the initial page cache segment?

Basically.  It's weird because we could change tcp_sendmsg() to grab a
"little bit" of space in skb->data after the TCP headers area, but
that would screw all the memory allocation advantages carving up pages
gives us.

TCP used to be really rough on the memory subsystem, and in particular
going to a page carving scheme helped a lot in this area.

 > are there any NICs which take only 2 entry lists?  (boo hiss and curses
 > on such things if they exist!)

Tulip I think falls into this category, I could be wrong.  It has two
buffer pointers in the RX descriptor, but one might be able to chain
them.

Alexey added SG support to Tulip at some point, and I can probably dig
up the patch.  It doesn't do hw csumming, though.

Later,
David S. Miller
davem@redhat.com
