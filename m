Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129791AbQJ1OPS>; Sat, 28 Oct 2000 10:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130313AbQJ1OPI>; Sat, 28 Oct 2000 10:15:08 -0400
Received: from smtppop2pub.gte.net ([206.46.170.21]:41271 "EHLO
	smtppop2pub.verizon.net") by vger.kernel.org with ESMTP
	id <S129791AbQJ1OOz>; Sat, 28 Oct 2000 10:14:55 -0400
Message-ID: <39FADF38.9CA09B1A@gte.net>
Date: Sat, 28 Oct 2000 10:14:16 -0400
From: "Stephen E. Clark" <sclark46@gte.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: lk <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: RTNL assert
In-Reply-To: <39FA4968.62588272@gte.net> <39FAAFF2.200E1860@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> "Stephen E. Clark" wrote:
> >
> > When I configure in Tunneling I get the following error message. Is this
> > normal? This with 2.4test9pre5
> >
> > GRE over IPv4 tunneling driver
> > RTNL: assertion failed at devinet.c(775):inetdev_event
> 
> The rtnetlink lock needs to be taken around
> register_netdevice().  There should be a function
> which does these three common steps, but there isn't.
> 
> --- linux-2.4.0-test10-pre5/net/ipv4/ip_gre.c   Sat Sep  9 16:19:30 2000
> +++ linux-akpm/net/ipv4/ip_gre.c        Sat Oct 28 21:44:23 2000
> @@ -1266,7 +1266,9 @@
>  #ifdef MODULE
>         register_netdev(&ipgre_fb_tunnel_dev);
>  #else
> +       rtnl_lock();
>         register_netdevice(&ipgre_fb_tunnel_dev);
> +       rtnl_unlock();
>  #endif
> 
>         inet_add_protocol(&ipgre_protocol);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

Thanks Andrew,

I also get the same error if I try to configure in normal IPV4
tunneling. I guess it needs the same kind of patch.

Oct 27 14:46:59 joker kernel: IPv4 over IPv4 tunneling driver 
Oct 27 14:46:59 joker kernel: RTNL: assertion failed at
devinet.c(775):inetdev_event 
Oct 27 14:46:59 joker kernel: GRE over IPv4 tunneling driver 
Oct 27 14:46:59 joker kernel: RTNL: assertion failed at
devinet.c(775):inetdev_event

Steve
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
