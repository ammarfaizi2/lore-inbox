Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267881AbTAHTvk>; Wed, 8 Jan 2003 14:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267885AbTAHTvj>; Wed, 8 Jan 2003 14:51:39 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:29648 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S267881AbTAHTvg>; Wed, 8 Jan 2003 14:51:36 -0500
Date: Thu, 09 Jan 2003 08:59:53 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Fabio Massimo Di Nitto <fabbione@fabbione.net>,
       Wichert Akkerman <wichert@wiggy.net>
cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: ipv6 stack seems to forget to send ACKs
Message-ID: <78180000.1042055993@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.51.0301081849550.564@diapolon.int.fabbione.net>
References: <20030108130850.GQ22951@wiggy.net>
 <Pine.LNX.4.51.0301081849550.564@diapolon.int.fabbione.net>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, January 08, 2003 19:05:36 +0100 Fabio Massimo Di Nitto 
<fabbione@fabbione.net> wrote:

>
> I was able to reproduce the problem again. I have been using ethereal to
> sniff instead of tcpdump and gave out some more info.
>
> basically the icecast server at certain time (but i can't predict
> exactly in which situations) just send a FIN, ACK packet to the client.
> Basically to close the connection and after a few packets the client of
> course answer.What is strange that in the meanwhile there are still 3/4
> data packets coming from the server to the client.
>
> Regarding the network side I noticed the following:
>
> an average of 500ms to ping6 the server and 0 pkt loss
> few seconds before the FIN, ACK (server->client) and for about 6 pkts the
> average jumped to 2000ms
>
> I suspect that this network flap made the server thinking about
> <insert_here_whatever_term_is_more_appropriate> and decided to close
> the connection.

Probably on the server's side it got an ICMP Host Unreachable or two as 
some router updated its tables, and decided to close the connection.  The 
FIN jumped the queue in one/several of the routers in the path, so it got 
reordered relative to the data.  This would imply that the router in 
question had its route to you back by the time the FIN got there.

Wierd, but far from impossible.

>
> The full ethereal dump is available at
> http://www.fabbione.net/ice-xmms-ipv6.dump.bz2
>
> but PLEASE note that it is a 10MB file and Im on a slow adsl line so be
> "nice".

I think you provided enough info to tell what happened.

>
> Fabio
>
> PS Im afraid/happy that anyway the problem is not related to the kernel
> version we are running.

Doesn't look like a kernel problem.

Someone's got a dodgy link or a routing problem.

Andrew


