Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266702AbTBKW7p>; Tue, 11 Feb 2003 17:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbTBKW7p>; Tue, 11 Feb 2003 17:59:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:9145 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266702AbTBKW7n>;
	Tue, 11 Feb 2003 17:59:43 -0500
Date: Tue, 11 Feb 2003 15:08:23 -0800
From: Andrew Morton <akpm@digeo.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: pablo@menichini.com.ar, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.60: arlan.c no longer compiles
Message-Id: <20030211150823.0d536772.akpm@digeo.com>
In-Reply-To: <20030211164414.GN17128@fs.tum.de>
References: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
	<20030211164414.GN17128@fs.tum.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Feb 2003 23:09:24.0097 (UTC) FILETIME=[9DFAB710:01C2D222]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> On Mon, Feb 10, 2003 at 11:08:28AM -0800, Linus Torvalds wrote:
> >...
> > Summary of changes from v2.5.59 to v2.5.60
> > ============================================
> >...
> > Rusty Russell <rusty@rustcorp.com.au>:
> >...
> >   o Memory leak in drivers_net_arlan.c (1)
> >...
> 
> This change broke the compilation of arlan.c:
> 

 drivers/net/arlan.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff -puN drivers/net/arlan.c~arlan-fix drivers/net/arlan.c
--- 25/drivers/net/arlan.c~arlan-fix	Tue Feb 11 15:03:45 2003
+++ 25-akpm/drivers/net/arlan.c	Tue Feb 11 15:07:08 2003
@@ -1124,24 +1124,6 @@ static int __init arlan_probe_everywhere
 	return -ENODEV;
 }
 
-static int __init arlan_find_devices(void)
-{
-	int m;
-	int found = 0;
-
-	ARLAN_DEBUG_ENTRY("arlan_find_devices");
-	if (mem != 0 && numDevices == 1)	/* Check a single specified location. */
-		return 1;
-	for (m =(int) phys_to_virt(0xc0000); m <=(int) phys_to_virt(0xDE000); m += 0x2000)
-	{
-		if (arlan_check_fingerprint(m) == 0)
-			found++;
-	}
-	ARLAN_DEBUG_EXIT("arlan_find_devices");
-
-	return found;
-}
-
 
 static int arlan_change_mtu(struct net_device *dev, int new_mtu)
 {
@@ -1199,7 +1181,7 @@ static int __init
 			return 0;
 		}
 		ap = dev->priv;
-		ap->config = dev->priv + sizeof(struct arlan_private);
+		ap->conf = dev->priv + sizeof(struct arlan_private);
 		ap->init_etherdev_alloc = 1;
 	} else {
 		dev = devs;
@@ -1209,7 +1191,7 @@ static int __init
 			return 0;
 		}
 		ap = dev->priv;
-		ap->config = dev->priv + sizeof(struct arlan_private);
+		ap->conf = dev->priv + sizeof(struct arlan_private);
 		memset(ap, 0, sizeof(*ap));
 	}
 
@@ -2007,6 +1989,24 @@ int __init arlan_probe(struct net_device
 
 #ifdef  MODULE
 
+static int __init arlan_find_devices(void)
+{
+	int m;
+	int found = 0;
+
+	ARLAN_DEBUG_ENTRY("arlan_find_devices");
+	if (mem != 0 && numDevices == 1)	/* Check a single specified location. */
+		return 1;
+	for (m =(int) phys_to_virt(0xc0000); m <=(int) phys_to_virt(0xDE000); m += 0x2000)
+	{
+		if (arlan_check_fingerprint(m) == 0)
+			found++;
+	}
+	ARLAN_DEBUG_EXIT("arlan_find_devices");
+
+	return found;
+}
+
 int init_module(void)
 {
 	int i = 0;

_

