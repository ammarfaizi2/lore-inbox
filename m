Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266353AbSLOKx7>; Sun, 15 Dec 2002 05:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266354AbSLOKx7>; Sun, 15 Dec 2002 05:53:59 -0500
Received: from h-64-105-35-98.SNVACAID.covad.net ([64.105.35.98]:28102 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266353AbSLOKx5>; Sun, 15 Dec 2002 05:53:57 -0500
Date: Sun, 15 Dec 2002 02:58:27 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: ambx1@neo.rr.com, linux-kernel@vger.kernel.org
Subject: Patch(2.5.51): __pnp_add_device dereferenced bad pointer
Message-ID: <20021215025827.A8148@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	__pnp_add_device dereferences a bad pointer when it traverses
the dev->id chain, because id->next is not initialized in certain cases,
causing my Sony Picturebook pcg-c1vn to crash at boot.  Here is a patch.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

--- linux-2.5.51/drivers/pnp/driver.c	2002-12-09 18:46:14.000000000 -0800
+++ linux/drivers/pnp/driver.c	2002-12-15 02:52:47.000000000 -0800
@@ -164,6 +164,7 @@
 		return -EINVAL;
 	if (!dev)
 		return -EINVAL;
+	id->next = NULL;
 	ptr = dev->id;
 	while (ptr && ptr->next)
 		ptr = ptr->next;

--DocE+STaALJfprDB--
