Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263244AbTCNFVx>; Fri, 14 Mar 2003 00:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263247AbTCNFVx>; Fri, 14 Mar 2003 00:21:53 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:56631
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263244AbTCNFVw>; Fri, 14 Mar 2003 00:21:52 -0500
Date: Fri, 14 Mar 2003 00:28:59 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Stephen Hemminger <shemminger@osdl.org>
cc: Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (3/5) Remove brlock from bridge
In-Reply-To: <1047595202.3136.102.camel@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.LNX.4.50.0303140025280.17112-100000@montezuma.mastecende.com>
References: <1047595202.3136.102.camel@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+static void __br_del_if(struct net_bridge_port *p)
+{
-               }
-
-               pptr = &((*pptr)->next);
-       }
+       br_fdb_delete_by_port(p->br, p);

-       br_fdb_delete_by_port(br, p);
-       kfree(p);
-       dev_put(dev);
-
-       return 0;
+       /* defer actual free till after receive BH has completed */
+       call_rcu(&p->rcu, (void (*)(void *)) kfree, p);
 }

Missing dev_put? Perhaps you'd want to register a callback which also 
decrements the reference count.

	Zwane
