Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272511AbRIWG3N>; Sun, 23 Sep 2001 02:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272856AbRIWG3D>; Sun, 23 Sep 2001 02:29:03 -0400
Received: from ns1.yggdrasil.com ([209.249.10.20]:16314 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S272511AbRIWG24>; Sun, 23 Sep 2001 02:28:56 -0400
Date: Sat, 22 Sep 2001 23:29:16 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: james@fishsoup.dhs.org, paul.bristow@technologist.com,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan.cox@linux.org
Subject: PATCH: linux-2.4.10-pre14/drviers/net/irda/toshoboe.c module segfaults at removal if hardware absent
Message-ID: <20010922232916.A11192@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.4.10-pre14/drivers/net/irda/toshoboe.c
ignored the return value from pci_module_init() at module
load time, and then unconditionally calls pci_unregister_module
when the module is unloaded (even if the driver is not registered,
due to pci_module_init failing).  I have verified that this results
in a kernel null pointer dereference if you load and unload this
module on a system lacking the toshboe hardware.

	The following trivial patch fixes the problem by aborting
the module initialization if pci_module_init fails.

	Please apply.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tosh.diff"

949,950c949
<   pci_module_init(&toshoboe_pci_driver);
<   return 0;
---
>   return pci_module_init(&toshoboe_pci_driver);

--k+w/mQv8wyuph6w0--
