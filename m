Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263807AbUE3NqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbUE3NqT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 09:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUE3NqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 09:46:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55745 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263807AbUE3NqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 09:46:16 -0400
Date: Sun, 30 May 2004 15:45:45 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: walt <wa1ter@myrealbox.com>, jgarzik@pobox.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, dth@ncc1701.cistron.net,
       linux-net@vger.kernel.org
Subject: [patch] Re: Gigabit Kconfig problems with yesterday's update
Message-ID: <20040530134544.GE13111@fs.tum.de>
References: <40B8A37D.1090802@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B8A37D.1090802@myrealbox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 07:51:41AM -0700, walt wrote:

> I have one machine with a gigabit NIC which I updated today from Linus'
> bk tree.
> 
> The problem is that I was not asked if I wanted the 'new' gigabit
> support and therefore the tg3 support was dropped from my new .config.
> 
> I edited .config by hand and deleted any mention of ethernet support --
> and only then did 'make oldconfig' ask me the right questions.
> 
> Also: the phrase (10 or 100Mbit) should be deleted from the 'Ethernet'
> menu item since it implies (wrongly) that the item is not needed for
> gigabit support.

Thanks for this good report (and I'm now understanding the issue without 
requiring your .config).

@Jeff:
At a first glance, it seems the patch below that simply removes the 
dependency of NET_GIGE on NET_ETHERNET would suffice.

Is this correct or did I miss something?

> Thanks!

cu
Adrian

--- linux-2.6.7-rc2-full/drivers/net/Kconfig.old	2004-05-30 15:33:24.000000000 +0200
+++ linux-2.6.7-rc2-full/drivers/net/Kconfig	2004-05-30 15:38:41.000000000 +0200
@@ -1879,7 +1879,7 @@
 
 config NET_GIGE
 	bool "Gigabit Ethernet (1000/10000 Mbit) controller support"
-	depends on NETDEVICES && NET_ETHERNET && (PCI || SBUS)
+	depends on NETDEVICES && (PCI || SBUS)
 	help
 	  Gigabit ethernet.  It's yummy and fast, fast, fast.
 

