Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbUA3Bjj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266534AbUA3Bhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:37:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:15324 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266527AbUA3BcK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:32:10 -0500
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
In-Reply-To: <1075426310683@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 29 Jan 2004 17:31:51 -0800
Message-Id: <10754263111347@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1524, 2004/01/29 17:13:27-08:00, greg@kroah.com

[PATCH] PCI: fix compiler warning in probe.c cause by PPC patch.


 drivers/pci/probe.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Thu Jan 29 17:23:43 2004
+++ b/drivers/pci/probe.c	Thu Jan 29 17:23:43 2004
@@ -628,11 +628,13 @@
 		 	 * If this is a single function device,
 		 	 * don't scan past the first function.
 		 	 */
-			if (!dev->multifunction)
-				if (func > 0)
+			if (!dev->multifunction) {
+				if (func > 0) {
 					dev->multifunction = 1;
-				else
+				} else {
  					break;
+				}
+			}
 		} else {
 			if (func == 0)
 				break;

