Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278276AbRJXEZn>; Wed, 24 Oct 2001 00:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278297AbRJXEZc>; Wed, 24 Oct 2001 00:25:32 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:12293 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S278276AbRJXEZQ>; Wed, 24 Oct 2001 00:25:16 -0400
Date: Wed, 24 Oct 2001 14:25:12 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Darrell A Escola <darrell-sg@descola.net>
Cc: linux-kernel@vger.kernel.org, netfilter@lists.samba.org
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
Message-Id: <20011024142512.4f22ab17.rusty@rustcorp.com.au>
In-Reply-To: <20011019061830.A8087@descola.net>
In-Reply-To: <1002646705.2177.9.camel@aurora>
	<Pine.LNX.4.33.0110091005540.209-100000@desktop>
	<20011010135503.4f5c06b9.rusty@rustcorp.com.au>
	<20011019061830.A8087@descola.net>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2001 06:18:30 -0700
Darrell A Escola <darrell-sg@descola.net> wrote:

> I have been running 2.4.10-ac11 for 7 days now with
> TCP_CONNTRACK_CLOSE_WAIT set to 120 seconds - this has stopped nearly
> all firewall activity on established connections.

OK... I think this needs changing then.  Can everyone please try the following
trivial patch and report any changes?

Thanks!
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.12-official/net/ipv4/netfilter/ip_conntrack_proto_tcp.c working-2.4.12-tcptime/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
--- linux-2.4.12-official/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	Sun Apr 29 06:17:11 2001
+++ working-2.4.12-tcptime/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	Wed Oct 24 14:23:26 2001
@@ -55,7 +55,7 @@
     2 MINS,	/*	TCP_CONNTRACK_FIN_WAIT,	*/
     2 MINS,	/*	TCP_CONNTRACK_TIME_WAIT,	*/
     10 SECS,	/*	TCP_CONNTRACK_CLOSE,	*/
-    60 SECS,	/*	TCP_CONNTRACK_CLOSE_WAIT,	*/
+    2 MINS,	/*	TCP_CONNTRACK_CLOSE_WAIT,	*/
     30 SECS,	/*	TCP_CONNTRACK_LAST_ACK,	*/
     2 MINS,	/*	TCP_CONNTRACK_LISTEN,	*/
 };
