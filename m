Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265531AbUFWOsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUFWOsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 10:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUFWOr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 10:47:27 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:522 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S265531AbUFWOpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 10:45:12 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200406231445.KAA29786@clem.clem-digital.net>
Subject: Re: 2.6.7-bk6 fails module compile -- iptable_raw.c
In-Reply-To: <20040623.224203.122414746.yoshfuji@linux-ipv6.org> from "YOSHIFUJI Hideaki / [?iso-2022-jp?]" at "Jun 23, 2004 10:42: 3 pm"
To: yoshfuji@linux-ipv6.org (YOSHIFUJI Hideaki / [?iso-2022-jp?])
Date: Wed, 23 Jun 2004 10:45:00 -0400 (EDT)
Cc: davem@redhat.com, clem@clem.clem-digital.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, netfilter-devel@lists.netfilter.org
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patches and compiles. Thanks.

--
Pete Clements

Quoting YOSHIFUJI Hideaki / [?iso-2022-jp?]
  > In article <200406231256.IAA28505@clem.clem-digital.net> (at Wed, 23 Jun 2004 08:56:08 -0400 (EDT)), Pete Clements <clem@clem.clem-digital.net> says:
  > 
  > > FYI:  (gcc version 2.95.4)
  > > 
  > >   CC [M]  net/ipv4/netfilter/iptable_raw.o
  > > net/ipv4/netfilter/iptable_raw.c:57: unknown field `target_size' specified in initializer
  > > net/ipv4/netfilter/iptable_raw.c:57: warning: missing braces around initializer
  > > net/ipv4/netfilter/iptable_raw.c:57: warning: (near initialization for `initial_table.entries[0].target.target.u')
  > > net/ipv4/netfilter/iptable_raw.c:71: unknown field `target_size' specified in initializer
  > > net/ipv4/netfilter/iptable_raw.c:85: unknown field `user' specified in initializer
  > > net/ipv4/netfilter/iptable_raw.c:87: unknown field `name' specified in initializer
  > > net/ipv4/netfilter/iptable_raw.c:87: warning: excess elements in union initializer
  > > net/ipv4/netfilter/iptable_raw.c:87: warning: (near initialization for `initial_table.term.target.target.u')
  > > make[3]: *** [net/ipv4/netfilter/iptable_raw.o] Error 1
  > > make[2]: *** [net/ipv4/netfilter] Error 2
  > > make[1]: *** [net/ipv4] Error 2
  > > make: *** [net] Error 2
  > 
  > Please try this.
  > 
  > ===== net/ipv4/netfilter/iptable_raw.c 1.2 vs edited =====
  > --- 1.2/net/ipv4/netfilter/iptable_raw.c	2004-06-22 06:39:19 +09:00
  > +++ edited/net/ipv4/netfilter/iptable_raw.c	2004-06-23 22:35:44 +09:00
  > @@ -54,7 +54,9 @@
  >  		     },
  >  		     .target = { 
  >  			  .target = { 
  > -				  .u.target_size = IPT_ALIGN(sizeof(struct ipt_standard_target)),
  > +				  .u = {
  > +					  .target_size = IPT_ALIGN(sizeof(struct ipt_standard_target)),
  > +				  },
  >  			  },
  >  			  .verdict = -NF_ACCEPT - 1,
  >  		     },
  > @@ -68,7 +70,9 @@
  >  		     },
  >  		     .target = {
  >  			     .target = {
  > -				     .u.target_size = IPT_ALIGN(sizeof(struct ipt_standard_target)),
  > +				     .u = {
  > +					     .target_size = IPT_ALIGN(sizeof(struct ipt_standard_target)),
  > +				     },
  >  			     },
  >  			     .verdict = -NF_ACCEPT - 1,
  >  		     },
  > @@ -82,9 +86,11 @@
  >  		},
  >  		.target = {
  >  			.target = {
  > -				.u.user = {
  > -					.target_size = IPT_ALIGN(sizeof(struct ipt_error_target)), 
  > -					.name = IPT_ERROR_TARGET,
  > +				.u = {
  > +					.user = {
  > +						.target_size = IPT_ALIGN(sizeof(struct ipt_error_target)), 
  > +						.name = IPT_ERROR_TARGET,
  > +					},
  >  				},
  >  			},
  >  			.errorname = "ERROR",
  > 
