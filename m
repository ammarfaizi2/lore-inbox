Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280171AbRKFTFS>; Tue, 6 Nov 2001 14:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278587AbRKFTFE>; Tue, 6 Nov 2001 14:05:04 -0500
Received: from [209.195.52.30] ([209.195.52.30]:43526 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S280110AbRKFTDc>;
	Tue, 6 Nov 2001 14:03:32 -0500
From: David Lang <david.lang@digitalinsight.com>
To: pcg@goof.com
Cc: linux-kernel@vger.kernel.org
Date: Tue, 6 Nov 2001 10:39:31 -0800 (PST)
Subject: Re: ip_conntrack & timing out of connections
In-Reply-To: <20011106121947.A678@schmorp.de>
Message-ID: <Pine.LNX.4.40.0111061038160.24952-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the tcp dimeout is 60 seconds and the ip_conntrack timeout is 120 seconds.

I ran into this myself a couple days ago and have sent the info to Rusty
and to the netfilter mailing list (although only to the list this morning
so I don't know if there is a response there yet)

David Lang

On Tue, 6 Nov 2001 pcg@goof.com wrote:

> Date: Tue, 6 Nov 2001 12:19:47 +0100
> From: pcg@goof.com
> To: linux-kernel@vger.kernel.org
> Subject: ip_conntrack & timing out of connections
>
> linux-2.4.13-ac5 (other versions untested) has this peculiar behaviour: If I
> "killall -STOP thttpd", I, of course, still get connection requests which
> usually time out:
>
> tcp      238      0 217.227.148.85:80       213.76.191.129:3120 CLOSE_WAIT
> tcp      162      0 217.227.148.85:80       213.76.191.129:3128 CLOSE_WAIT
> tcp      238      0 217.227.148.85:80       213.76.191.129:3136 CLOSE_WAIT
> tcp      162      0 217.227.148.85:80       213.76.191.129:3152 CLOSE_WAIT
> tcp      134      0 217.227.148.85:80       66.42.121.15:3305 CLOSE_WAIT
> tcp      162      0 217.227.148.85:80       213.76.191.129:3160 CLOSE_WAIT
> tcp      279      0 217.227.148.85:80       62.83.11.19:2742 CLOSE_WAIT
>
> however, after some time, I get many of these messages:
>
> Nov  6 02:39:55 doom kernel: ip_conntrack: table full, dropping packet.
>
> /proc/net/ip_conntrack has lots of connections like these:
>
> tcp      6 430665 ESTABLISHED src=213.76.191.129 dst=217.227.148.85 sport=3881 dport=80 src=217.227.148.85 dst=213.76.191.129 sport=80 dport=388 1 [ASSURED] use=1
>
> that is, connections to port 80. a grep dport=80 in ip_conntrack gives me
> 3768 lines, where netstat -t only shows 159 connections, so it seems that
> conntrack has a problems with time-outs (or something similar).
>
> --
>       -----==-                                             |
>       ----==-- _                                           |
>       ---==---(_)__  __ ____  __       Marc Lehmann      +--
>       --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
>       -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
>     The choice of a GNU generation                       |
>                                                          |
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
