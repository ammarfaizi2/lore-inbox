Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265767AbSJTFC7>; Sun, 20 Oct 2002 01:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265770AbSJTFC7>; Sun, 20 Oct 2002 01:02:59 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:51466 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265767AbSJTFC4>; Sun, 20 Oct 2002 01:02:56 -0400
Date: Sun, 20 Oct 2002 02:08:49 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: only produce one record in fib_seq_show
Message-ID: <20021020050849.GD15254@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20021020000943.GL14009@conectiva.com.br> <20021019.173806.111570656.davem@redhat.com> <20021020010331.GB15254@conectiva.com.br> <20021019.211307.00017347.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021019.211307.00017347.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Oct 19, 2002 at 09:13:07PM -0700, David S. Miller escreveu:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Sat, 19 Oct 2002 22:03:31 -0300
    
>    We'll, if everybody stopped using net-tools and started using iproute2 the
>    world would be a better place

> 'iproute2' would need to be able to obtain things, such as
> the snmp statistics, some other way.  Currently /proc/net/snmp
> is the only place these values are provided.

> Ditto for UDP socket listings et al.  Only tcp_diag has moved
> the TCP socket information into the non-proc realm of netlink.

> If these facilities existed already, I'd agree with you.
> :-)

Hey, but those can be converted, can't they? I for one would be willing to
spend the time and study this to implement it. Indeed I'll do that, unless you
object, of course.

And take a look at this:

CONFIG_PROC_FS=y
[acme@oops net-2.5]$ l net/ipv4/built-in.o
-rw-rw-r--    1 acme     acme       328783 Out 20 01:44 net/ipv4/built-in.o

CONFIG_PROC_FS=n
[acme@oops net-2.5]$ l net/ipv4/built-in.o
-rw-rw-r--    1 acme     acme       320708 Out 20 02:03 net/ipv4/built-in.o

Both with CONFIG_SMP, CONFIG_NR_CPUS=2, so almos whooping 2 pages! Almost
one third of what CONFIG_SECURITY would add! ia32! Imagine on Sparc64! 8-P

- Arnaldo
