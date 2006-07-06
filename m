Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWGFJqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWGFJqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 05:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWGFJqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 05:46:06 -0400
Received: from smtp2gate.fmi.fi ([193.166.223.32]:21192 "EHLO smtp2gate.fmi.fi")
	by vger.kernel.org with ESMTP id S1030193AbWGFJqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 05:46:04 -0400
Message-Id: <200607060945.k669jTTx023676@leija.fmi.fi>
Subject: Routing tables (Re: [patch 2/6] [Network namespace] Network
 device sharing by view)
In-Reply-To: <44A0FBAC.7020107@fr.ibm.com>
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Date: Thu, 6 Jul 2006 12:45:29 +0300 (EEST)
From: Kari Hurtta <hurtta+linux-kernel@leija.mh.fmi.fi>
CC: Andrey Savochkin <saw@swsoft.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
X-Mailer: ELM [version 2.4ME+ PL123]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="US-ASCII"
X-Filter: smtp2gate: 3 received headers rewritten with id 20060706/17787/01
X-Filter: smtp2gate: ID 17785/01, 1 parts scanned for known viruses
X-Filter: torkku: ID 4437/01, 1 parts scanned for known viruses
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrey Savochkin wrote:
> > Daniel,
> > 
> > On Mon, Jun 26, 2006 at 05:49:41PM +0200, Daniel Lezcano wrote:
> > 
> >>>Then you lose the ability for each namespace to have its own routing entries.
> >>>Which implies that you'll have difficulties with devices that should exist
> >>>and be visible in one namespace only (like tunnels), as they require IP
> >>>addresses and route.
> >>
> >>I mean instead of having the route tables private to the namespace, the 
> >>routes have the information to which namespace they are associated.
> > 
> > 
> > I think I understand what you're talking about: you want to make routing
> > responsible for determining destination namespace ID in addition to route
> > type (local, unicast etc), nexthop information, and so on.  Right?
> 
> Yes.
> 
> > 
> > My point is that if you make namespace tagging at routing time, and
> > your packets are being routed only once, you lose the ability
> > to have separate routing tables in each namespace.
> 
> Right. What is the advantage of having separate the routing tables ?

One application may be following. Consider firewall

                       (isp1)            (isp2)


                         I                 I
          +-----------  red0------------- red1 ---------+
          |     +                                 +     |
          |     |    red routing deamon  (BGP)    |     |
          |     |                                 |     |
          |     |    red routing tables           |     |
          |     |                                 |     |
          |     +----------tun(?)-----------------+     |
          |                                             |
          |     +----------tun(?)-----------------+     |
          |     |                                 |     |
          |     |     green routing tables        |     |
     I mana0    |                                 |     |
          |     |     green routing deamon (ospf) |     |
          |     +                                 +     |
          +--------- green0 ---------- green1 ----------+
                       I                 I

               

That may allow running different routing deamon on
red and green side. That is possible if they manage
different routing tables on kernel.  They not need
communigate together, when route between them is static.

/ Kari Hurtta

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
