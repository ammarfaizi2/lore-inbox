Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278594AbRJ1Qoi>; Sun, 28 Oct 2001 11:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278603AbRJ1Qo2>; Sun, 28 Oct 2001 11:44:28 -0500
Received: from cc264272-a.gambrills1.md.home.com ([65.14.225.200]:18098 "HELO
	orthanc.cipherdyne.com") by vger.kernel.org with SMTP
	id <S278594AbRJ1QoN>; Sun, 28 Oct 2001 11:44:13 -0500
Date: Sun, 28 Oct 2001 11:45:00 -0500
From: Michael Rash <mbr@cipherdyne.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Darrell A Escola <darrell-sg@descola.net>, linux-kernel@vger.kernel.org,
        netfilter@lists.samba.org
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
Message-ID: <20011028114500.A27656@orthanc.cipherdyne.com>
In-Reply-To: <1002646705.2177.9.camel@aurora> <Pine.LNX.4.33.0110091005540.209-100000@desktop> <20011010135503.4f5c06b9.rusty@rustcorp.com.au> <20011019061830.A8087@descola.net> <20011024142512.4f22ab17.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011024142512.4f22ab17.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Wed, Oct 24, 2001 at 02:25:12PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 24, 2001, Rusty Russell wrote:

> On Fri, 19 Oct 2001 06:18:30 -0700
> Darrell A Escola <darrell-sg@descola.net> wrote:
> 
> > I have been running 2.4.10-ac11 for 7 days now with
> > TCP_CONNTRACK_CLOSE_WAIT set to 120 seconds - this has stopped nearly
> > all firewall activity on established connections.
> 
> OK... I think this needs changing then.  Can everyone please try the following
> trivial patch and report any changes?

Running 2.4.4 with this patch for the past 4 days has reduced the number of 
inappropriately dropped packets by ip_conntrack to nearly zero.  The number
of legitimate packets that used to be dropped previous to running this patch
would sometimes reach into the low hundreds over the same time frame.  (FWIW,
I have a cable modem connection to the 'net, and so it gets a bit slow from 
time to time since my bandwidth is shared...).

--Mike


> diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.12-official/net/ipv4/netfilter/ip_conntrack_proto_tcp.c working-2.4.12-tcptime/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
> --- linux-2.4.12-official/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	Sun Apr 29 06:17:11 2001
> +++ working-2.4.12-tcptime/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	Wed Oct 24 14:23:26 2001
> @@ -55,7 +55,7 @@
>      2 MINS,	/*	TCP_CONNTRACK_FIN_WAIT,	*/
>      2 MINS,	/*	TCP_CONNTRACK_TIME_WAIT,	*/
>      10 SECS,	/*	TCP_CONNTRACK_CLOSE,	*/
> -    60 SECS,	/*	TCP_CONNTRACK_CLOSE_WAIT,	*/
> +    2 MINS,	/*	TCP_CONNTRACK_CLOSE_WAIT,	*/
>      30 SECS,	/*	TCP_CONNTRACK_LAST_ACK,	*/
>      2 MINS,	/*	TCP_CONNTRACK_LISTEN,	*/
>  };
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Michael B. Rash
http://www.cipherdyne.com
Key fingerprint = 8E40 0826 4BBD 9DAF 4563  695C AC21 A428 70C9 B006
