Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286655AbRLVD3Q>; Fri, 21 Dec 2001 22:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286654AbRLVD3F>; Fri, 21 Dec 2001 22:29:05 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:29459 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286655AbRLVD2u>;
	Fri, 21 Dec 2001 22:28:50 -0500
Date: Sat, 22 Dec 2001 01:28:24 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>, SteveW@ACM.org, jschlst@samba.org,
        ncorbic@sangoma.com, eis@baty.hanse.de, dag@brattli.net,
        torvalds@transmeta.com, marcelo@conectiva.com.br, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH][RFC 4] cleaning up struct sock
Message-ID: <20011222012824.A8996@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, SteveW@ACM.org,
	jschlst@samba.org, ncorbic@sangoma.com, eis@baty.hanse.de,
	dag@brattli.net, torvalds@transmeta.com, marcelo@conectiva.com.br,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011218.130809.22018359.davem@redhat.com> <20011218232222.A1963@conectiva.com.br> <20011220012339.A919@conectiva.com.br> <20011220.002126.119272610.davem@redhat.com> <20011221115438.A5990@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011221115438.A5990@conectiva.com.br>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 21, 2001 at 11:54:38AM -0200, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Dec 20, 2001 at 12:21:26AM -0800, David S. Miller escreveu:
> > I'd rather you pass the "kmem_cache_t" directly into sk_alloc, use
> > NULL for "I don't have any extra private area".
> > 
> > And then, for the IP case lay it out like this:
> > 
> > 	struct sock
> > 	struct ip_opt
> > 	struct {tcp,raw4,...}_opt
> > 
> > And use different kmem_cache_t's for each protocol instead of
> > the same one for tcp, raw4, etc.
> > 
> > RAW/UDP sockets waste a lot of space with your current layout.

Done, patch available at:

http://www.kernel.org/pub/linux/kernel/people/acme/v2.5/2.5.2-pre1/
sock.cleanup-2.5.2-pre1.bz2

Current state of /proc/slabinfo:

[acme@rama2 acme]$ grep sock /proc/slabinfo
unix_sock   7  20  400  1  2  1 :  17  572 2 0  0
raw4_sock   0  10  376  0  1  1 :   1    3 1 0  0
udp_sock    6  10  372  1  1  1 :   7   31 1 0  0
tcp_sock   13  15  800  3  3  1 :  14   47 3 0  0
sock        0   0  336  0  0  1 :   0    0 0 0  0

TODO: do the same for IPv6, that now has only one slabcache for all its
protocols.

- Arnaldo
