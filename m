Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264155AbUE3Qpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbUE3Qpc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 12:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264205AbUE3Qpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 12:45:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:18573 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264155AbUE3Qp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 12:45:28 -0400
Date: Sun, 30 May 2004 09:41:20 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Danny ter Haar <dth@dth.net>
Cc: bunk@fs.tum.de, wa1ter@myrealbox.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, dth@ncc1701.cistron.net,
       linux-net@vger.kernel.org
Subject: Re: [patch] Re: Gigabit Kconfig problems with yesterday's update
Message-Id: <20040530094120.61b22d2e.rddunlap@osdl.org>
In-Reply-To: <20040530143734.GA24627@dth.net>
References: <40B8A37D.1090802@myrealbox.com>
	<20040530134544.GE13111@fs.tum.de>
	<20040530143734.GA24627@dth.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 May 2004 16:37:34 +0200 Danny ter Haar <dth@dth.net> wrote:

| Quoting Adrian Bunk (bunk@fs.tum.de):
| > @Jeff:
| > At a first glance, it seems the patch below that simply removes the 
| > dependency of NET_GIGE on NET_ETHERNET would suffice.
| > 
| > Is this correct or did I miss something?
| > 
| > cu
| > Adrian
| > 
| > --- linux-2.6.7-rc2-full/drivers/net/Kconfig.old	2004-05-30 15:33:24.000000000 +0200
| > +++ linux-2.6.7-rc2-full/drivers/net/Kconfig	2004-05-30 15:38:41.000000000 +0200
| > @@ -1879,7 +1879,7 @@
| >  
| >  config NET_GIGE
| >  	bool "Gigabit Ethernet (1000/10000 Mbit) controller support"
| > -	depends on NETDEVICES && NET_ETHERNET && (PCI || SBUS)
| > +	depends on NETDEVICES && (PCI || SBUS)
| >  	help
| >  	  Gigabit ethernet.  It's yummy and fast, fast, fast.
| 
| Fresh source, this patch, old config from 2.6.7-rc1-bk2 and make
| oldconfig now works ;)

I looked at this last night, after the first reported problem

I'm not surprised that this works, but I'm concerned about the use
of CONFIG_NET_ETHERNET in net/ipv4/arp.c.  I'd _guess_ that
CONFIG_NET_ETHERNET needs to be seen as enabled over there,
even though it's not enabled in drivers/net/*.

I don't know if it's a satisfactory solution, but
net/ipv4/arp.c could also check for CONFIG_NET_GIGE.
However, that doesn't seem like the right thing to do IMO.

--
~Randy
