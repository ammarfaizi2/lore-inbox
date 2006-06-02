Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbWFBTvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWFBTvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWFBTqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:46:38 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:52097 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751466AbWFBTqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:46:23 -0400
Message-Id: <20060602194734.005294000@sous-sol.org>
References: <20060602194618.482948000@sous-sol.org>
Date: Fri, 02 Jun 2006 00:00:01 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgewood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Brent Casavant <bcasavan@sgi.com>, Pat Gefre <pfg@sgi.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 01/11] Altix: correct ioc4 port order
Content-Disposition: inline; filename=altix-correct-ioc4-port-order.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Brent Casavant <bcasavan@sgi.com>

Currently loading the ioc4 as a module will cause the ports to be numbered
in reverse order.  This mod maintains the proper order of cards for port
numbering.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>
Cc: Pat Gefre <pfg@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---

 drivers/sn/ioc4.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.19.orig/drivers/sn/ioc4.c
+++ linux-2.6.16.19/drivers/sn/ioc4.c
@@ -313,7 +313,7 @@ ioc4_probe(struct pci_dev *pdev, const s
 	idd->idd_serial_data = NULL;
 	pci_set_drvdata(idd->idd_pdev, idd);
 	down_write(&ioc4_devices_rwsem);
-	list_add(&idd->idd_list, &ioc4_devices);
+	list_add_tail(&idd->idd_list, &ioc4_devices);
 	up_write(&ioc4_devices_rwsem);
 
 	/* Add this IOC4 to all submodules */

--
