Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286231AbRLTNEe>; Thu, 20 Dec 2001 08:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286234AbRLTNEY>; Thu, 20 Dec 2001 08:04:24 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:52997 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286231AbRLTNEU>; Thu, 20 Dec 2001 08:04:20 -0500
Date: Thu, 20 Dec 2001 10:37:59 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: SteveW@ACM.org, jschlst@samba.org, ncorbic@sangoma.com, eis@baty.hanse.de,
        dag@brattli.net, torvalds@transmeta.com, marcelo@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC 3] cleaning up struct sock
Message-ID: <20011220103759.A1208@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, SteveW@ACM.org,
	jschlst@samba.org, ncorbic@sangoma.com, eis@baty.hanse.de,
	dag@brattli.net, torvalds@transmeta.com, marcelo@conectiva.com.br,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011218.130809.22018359.davem@redhat.com> <20011218232222.A1963@conectiva.com.br> <20011220012339.A919@conectiva.com.br> <20011220.002126.119272610.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011220.002126.119272610.davem@redhat.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 20, 2001 at 12:21:26AM -0800, David S. Miller escreveu:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Thu, 20 Dec 2001 01:23:39 -0200
> 
>    Available at:
>    
>    http://www.kernel.org/pub/linux/kernel/people/acme/v2.5/2.5.1/
>    sock.cleanup-2.5.1.patch.bz2
> 
> Looking pretty good.  I have one improvement.
> 
> I'd rather you pass the "kmem_cache_t" directly into sk_alloc, use
> NULL for "I don't have any extra private area".

humm I did that with sock_register to avoid changing all the sk_alloc
users, but in the end all protocols were changed so... ok, I'll do that, at
least it'll simplify the "rtnetlink socket allocated early in the boot
process before sock_register(rtnetlink) was called".
 
> And then, for the IP case lay it out like this:
> 
> 	struct sock
> 	struct ip_opt
> 	struct {tcp,raw4,...}_opt
> 
> And use different kmem_cache_t's for each protocol instead of
> the same one for tcp, raw4, etc.
> 
> RAW/UDP sockets waste a lot of space with your current layout.

*grin* 

Ok, ok, lets save more bytes 8) I'll look into this.

- Arnaldo
