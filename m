Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbTJ0EKm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 23:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTJ0EKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 23:10:42 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:30737 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S263345AbTJ0EKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 23:10:40 -0500
Date: Mon, 27 Oct 2003 04:10:39 +0000
From: John Levon <levon@movementarian.org>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: davem@redhat.com, matthias.andree@gmx.de
Subject: Re: CONFIG_IP_NF_IPTABLES=m breaks 2.6 BK compile
Message-ID: <20031027041039.GA42608@compsoc.man.ac.uk>
References: <20031027034214.GA26161@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027034214.GA26161@merlin.emma.line.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1ADyiG-000Glp-3h*DJxweW/Dqkc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 04:42:14AM +0100, Matthias Andree wrote:

> net/built-in.o(.init.text+0x248e): In function `init':
> : undefined reference to `ipt_register_match'
> 
> .config file at
> http://mandree.home.pages.de/linux-2.6-BK-config

Please try the below. The option needs to inherit whatever iptables
itself got set to.

regards
john


Index: linux-cvs/net/ipv4/netfilter/Kconfig
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv4/netfilter/Kconfig,v
retrieving revision 1.12
diff -u -a -p -r1.12 Kconfig
--- linux-cvs/net/ipv4/netfilter/Kconfig	26 Sep 2003 00:23:18 -0000	1.12
+++ linux-cvs/net/ipv4/netfilter/Kconfig	27 Oct 2003 04:03:40 -0000
@@ -267,7 +267,7 @@ config IP_NF_MATCH_OWNER
 
 config IP_NF_MATCH_PHYSDEV
 	tristate "Physdev match support"
-	depends on IP_NF_IPTABLES!=n && BRIDGE_NETFILTER
+	depends on IP_NF_IPTABLES && BRIDGE_NETFILTER
 	help
 	  Physdev packet matching matches against the physical bridge ports
 	  the IP packet arrived on or will leave by.
