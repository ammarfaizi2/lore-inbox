Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286210AbRLTIWu>; Thu, 20 Dec 2001 03:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286214AbRLTIWl>; Thu, 20 Dec 2001 03:22:41 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44676 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286210AbRLTIWb>;
	Thu, 20 Dec 2001 03:22:31 -0500
Date: Thu, 20 Dec 2001 00:21:26 -0800 (PST)
Message-Id: <20011220.002126.119272610.davem@redhat.com>
To: acme@conectiva.com.br
Cc: SteveW@ACM.org, jschlst@samba.org, ncorbic@sangoma.com, eis@baty.hanse.de,
        dag@brattli.net, torvalds@transmeta.com, marcelo@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC 3] cleaning up struct sock
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011220012339.A919@conectiva.com.br>
In-Reply-To: <20011218.130809.22018359.davem@redhat.com>
	<20011218232222.A1963@conectiva.com.br>
	<20011220012339.A919@conectiva.com.br>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Thu, 20 Dec 2001 01:23:39 -0200

   Available at:
   
   http://www.kernel.org/pub/linux/kernel/people/acme/v2.5/2.5.1/
   sock.cleanup-2.5.1.patch.bz2

Looking pretty good.  I have one improvement.

I'd rather you pass the "kmem_cache_t" directly into sk_alloc, use
NULL for "I don't have any extra private area".

And then, for the IP case lay it out like this:

	struct sock
	struct ip_opt
	struct {tcp,raw4,...}_opt

And use different kmem_cache_t's for each protocol instead of
the same one for tcp, raw4, etc.

RAW/UDP sockets waste a lot of space with your current layout.
