Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261607AbSJQBFP>; Wed, 16 Oct 2002 21:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261608AbSJQBFP>; Wed, 16 Oct 2002 21:05:15 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:24334 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261607AbSJQBFO>; Wed, 16 Oct 2002 21:05:14 -0400
Date: Wed, 16 Oct 2002 22:11:08 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: make arp seq_file show method only produce one record per call
Message-ID: <20021017011108.GT7541@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20021017010135.GR7541@conectiva.com.br> <20021016.175809.28811497.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016.175809.28811497.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 16, 2002 at 05:58:09PM -0700, David S. Miller escreveu:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Wed, 16 Oct 2002 22:01:36 -0300
> 
>    	Please pull from:
>    
>    master.kernel.org:/home/acme/BK/net-2.5
>    
> Pulled, thanks.
> 
> Now to help Al create a sane mechanism for carrying private state
> around between start/stop :-)

That would be nice, yes, bastardizing pos for this is, humm, ugly, and
it isn't accessible at show time (pun intended 8) ).

But now I have to chainsaw the /proc/net/route support into shape, and
this one will be fun, as I'll have to change the semantics of the
struct fib_table tb_seq_show so that I can grab the lock at fib_seq_start,
and at fib_seq_show pass just one entry, then drop the lock at fib_seq_stop.
So, probably we'll have fib_table::tb_seq_{start, next, show, start}, humm,
this gave another idea... :)

- Arnaldo
