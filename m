Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVEMRsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVEMRsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 13:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVEMRsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 13:48:51 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:12163 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S262460AbVEMRsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 13:48:41 -0400
Date: Fri, 13 May 2005 10:48:37 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: "McMullan, Jason" <jason.mcmullan@timesys.com>
Cc: PPC_LINUX@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11.7] ATA Over Ethernet Root
Message-Id: <20050513104837.31fd20e6.rdunlap@xenotime.net>
In-Reply-To: <1116004796.9050.83.camel@jmcmullan.timesys>
References: <1116004796.9050.83.camel@jmcmullan.timesys>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005 13:19:55 -0400 McMullan, Jason wrote:

| This patch allows you to use ATA Over Ethernet as your root device,
| with 'root=/dev/etherd/eX.Y/disc'
| 
| Limited testing, just for ya'lls review.
or                          y'alls


Please make patches against 2.6.12-rcX, not against 2.6.11.z.
(probably doesn't matter in this case)


+struct aoedev *
+aoedev_bymajor_minor(ulong major, ulong minor)
+{

Kernel preferred style is not to split the function definition line.


+#ifdef CONFIG_ATA_OVER_ETH_ROOT
+#include <linux/delay.h>
+#include <linux/rtnetlink.h>
+#include <linux/netdevice.h>
+#include <net/sock.h>
+#endif

Lose the ifdef/endif.  Don't make #includes conditional.

+printk("Bring up loopback...\n");
+	if (dev_change_flags(&loopback_dev, loopback_dev.flags | IFF_UP) < 0)
+		printk(KERN_ERR "AOE Root: Failed to open %s\n", loopback_dev.name);
+
+	/* Setup all network devices */
+	for (dev = dev_base; dev ; dev = dev->next) {
+		if (dev == &loopback_dev)
+			continue;
+printk("Bring up %s...\n",dev->name);

Did you mean to leave these printk()s here?
I think not, but if so, they need a KERN_ level, like KERN_INFO.


It would help readability if you would add some spaces around
'=', after commas, etc., in places like these:

+	for (d=devlist; d; d=d->next)
and
+	} while (!aoedev_bymajor_minor(CONFIG_ATA_OVER_ETH_ROOT_SHELF,CONFIG_ATA_OVER_ETH_ROOT_SLOT));
and
+	aoe_root(CONFIG_ATA_OVER_ETH_ROOT_SHELF,CONFIG_ATA_OVER_ETH_ROOT_SLOT);


Thanks.

---
~Randy
