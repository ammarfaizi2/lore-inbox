Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbUKCR2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUKCR2O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 12:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUKCR2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 12:28:13 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:12444 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261693AbUKCRYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 12:24:50 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix HPET time_interpolator registration
Date: Wed, 3 Nov 2004 10:24:43 -0700
User-Agent: KMail/1.7
Cc: Bob Picco <Robert.Picco@hp.com>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bRRiBY05LlZEtwr"
Message-Id: <200411031024.43782.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_bRRiBY05LlZEtwr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Fixup after mid-air collision between Christoph adding time_interpolator.mask,
and me removing a static time_interpolator struct from hpet.c.  This causes
a boot-time BUG() on boxes that use the hpet driver.

--Boundary-00=_bRRiBY05LlZEtwr
Content-Type: text/x-diff;
  charset="us-ascii";
  name="hpet-mask.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hpet-mask.patch"

Fixup after mid-air collision between Christoph adding time_interpolator.mask,
and me removing a static time_interpolator struct from hpet.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/char/hpet.c 1.14 vs edited =====
--- 1.14/drivers/char/hpet.c	2004-11-02 07:40:42 -07:00
+++ edited/drivers/char/hpet.c	2004-11-03 10:05:26 -07:00
@@ -712,6 +712,7 @@
 	ti->addr = &hpetp->hp_hpet->hpet_mc;
 	ti->frequency = hpet_time_div(hpets->hp_period);
 	ti->drift = ti->frequency * HPET_DRIFT / 1000000;
+	ti->mask = 0xffffffffffffffffLL;
 
 	hpetp->hp_interpolator = ti;
 	register_time_interpolator(ti);

--Boundary-00=_bRRiBY05LlZEtwr--
