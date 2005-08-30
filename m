Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVH3RI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVH3RI0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVH3RI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:08:26 -0400
Received: from mirapoint2.brutele.be ([212.68.199.149]:19513 "EHLO
	mirapoint2.brutele.be") by vger.kernel.org with ESMTP
	id S932227AbVH3RIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:08:24 -0400
Date: Tue, 30 Aug 2005 19:08:20 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.13 - 3/3 - Remove the deprecated function __check_region
Message-ID: <20050830170820.GB11011@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
X-Operating-System: Linux debian 2.6.12-1-k7
User-Agent: Mutt/1.5.10i
X-Junkmail-Status: score=10/50, host=mirapoint2.brutele.be
X-Junkmail-SD-Raw: score=unknown, refid=0001.0A090201.43148FA8.0040-F-L0BeBC04zsV01UPbcJcIKw==,  =?ISO-8859-1?Q?=20i?=
	=?ISO-8859-1?Q?p=3D=80=D5?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi all, 
 
Here is the first patch for kernel 2.6.13 from Linus tree.


-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
                <stephane.wirtel@gmail.com>



--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="patch_remove_check_region_in_pnp_resource.diff"

diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -242,6 +242,7 @@ int pnp_check_port(struct pnp_dev * dev,
 	int tmp;
 	struct pnp_dev *tdev;
 	unsigned long *port, *end, *tport, *tend;
+	struct resource *res = 0;
 	port = &dev->res.port_resource[idx].start;
 	end = &dev->res.port_resource[idx].end;
 
@@ -252,8 +253,12 @@ int pnp_check_port(struct pnp_dev * dev,
 	/* check if the resource is already in use, skip if the
 	 * device is active because it itself may be in use */
 	if(!dev->active) {
-		if (__check_region(&ioport_resource, *port, length(port,end)))
+		res = __request_region(&ioport_resource, *port, length(port,end), "check-region");
+		if (res) {
+			release_resource (res);
+			kfree (res);
 			return 0;
+		}
 	}
 
 	/* check if the resource is reserved */
@@ -298,6 +303,7 @@ int pnp_check_mem(struct pnp_dev * dev, 
 	int tmp;
 	struct pnp_dev *tdev;
 	unsigned long *addr, *end, *taddr, *tend;
+	struct resource *res = 0;
 	addr = &dev->res.mem_resource[idx].start;
 	end = &dev->res.mem_resource[idx].end;
 
@@ -308,8 +314,12 @@ int pnp_check_mem(struct pnp_dev * dev, 
 	/* check if the resource is already in use, skip if the
 	 * device is active because it itself may be in use */
 	if(!dev->active) {
-		if (check_mem_region(*addr, length(addr,end)))
+		res == __request_region(&iomem_resource, *addr, length(addr, end), "check-region");
+		if (res) {
+			release_resource (res);
+			kfree (res);
 			return 0;
+		}
 	}
 
 	/* check if the resource is reserved */

--4SFOXa2GPu3tIq4H--

