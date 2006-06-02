Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWFBTqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWFBTqd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWFBTqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:46:33 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:52353 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751475AbWFBTqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:46:31 -0400
Message-Id: <20060602194734.877419000@sous-sol.org>
References: <20060602194618.482948000@sous-sol.org>
Date: Fri, 02 Jun 2006 00:00:02 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgewood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Pat Gefre <pfg@sgi.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 02/11] Altix: correct ioc3 port order
Content-Disposition: inline; filename=altix-correct-ioc3-port-order.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Pat Gefre <pfg@sgi.com>

Currently loading the ioc3 as a module will cause the ports to be numbered
in reverse order.  This mod maintains the proper order of cards for port
numbering.

Signed-off-by: Patrick Gefre <pfg@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---

 drivers/sn/ioc3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.19.orig/drivers/sn/ioc3.c
+++ linux-2.6.16.19/drivers/sn/ioc3.c
@@ -677,7 +677,7 @@ static int ioc3_probe(struct pci_dev *pd
 	/* Track PCI-device specific data */
 	pci_set_drvdata(pdev, idd);
 	down_write(&ioc3_devices_rwsem);
-	list_add(&idd->list, &ioc3_devices);
+	list_add_tail(&idd->list, &ioc3_devices);
 	idd->id = ioc3_counter++;
 	up_write(&ioc3_devices_rwsem);
 

--
