Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbTA0VEQ>; Mon, 27 Jan 2003 16:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267246AbTA0VEQ>; Mon, 27 Jan 2003 16:04:16 -0500
Received: from newpeace.netnation.com ([204.174.223.7]:9358 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S267244AbTA0VEP>; Mon, 27 Jan 2003 16:04:15 -0500
Date: Mon, 27 Jan 2003 13:13:33 -0800
From: Simon Kirby <sim@netnation.com>
To: netfilter@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-pre3] Netfilter does not compile with this .config
Message-ID: <20030127211333.GA25522@netnation.com>
References: <20030127210116.GB23198@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030127210116.GB23198@netnation.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 01:01:16PM -0800, Simon Kirby wrote:

> net/network.o(.text+0x42485): In function `match':
> : undefined reference to `ip_conntrack_get'
> net/network.o(.text.init+0x13ca): In function `init':
> : undefined reference to `ip_conntrack_module'
> make: *** [vmlinux] Error 1

This may be the correct fix:

--- linux.alfie/net/ipv4/netfilter/Config.in.orig	2002-12-26 11:25:40.000000000 -0800
+++ linux.alfie/net/ipv4/netfilter/Config.in	2003-01-27 13:08:30.000000000 -0800
@@ -31,9 +31,7 @@
   dep_tristate '  TTL match support' CONFIG_IP_NF_MATCH_TTL $CONFIG_IP_NF_IPTABLES
   dep_tristate '  tcpmss match support' CONFIG_IP_NF_MATCH_TCPMSS $CONFIG_IP_NF_IPTABLES
   if [ "$CONFIG_IP_NF_CONNTRACK" != "n" ]; then
-    dep_tristate '  Helper match support' CONFIG_IP_NF_MATCH_HELPER $CONFIG_IP_NF_IPTABLES
-  fi
-  if [ "$CONFIG_IP_NF_CONNTRACK" != "n" ]; then
+    dep_tristate '  Helper match support' CONFIG_IP_NF_MATCH_HELPER $CONFIG_IP_NF_CONNTRACK $CONFIG_IP_NF_IPTABLES
     dep_tristate '  Connection state match support' CONFIG_IP_NF_MATCH_STATE $CONFIG_IP_NF_CONNTRACK $CONFIG_IP_NF_IPTABLES 
     dep_tristate '  Connection tracking match support' CONFIG_IP_NF_MATCH_CONNTRACK $CONFIG_IP_NF_CONNTRACK $CONFIG_IP_NF_IPTABLES 
   fi

(If not, a flamewar will surely ensue which will result in the correct
 fix being posted. :) )

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]
