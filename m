Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbVHTDqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbVHTDqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 23:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbVHTDqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 23:46:34 -0400
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:59855 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S1030190AbVHTDqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 23:46:34 -0400
Date: Fri, 19 Aug 2005 23:46:59 -0400 (EDT)
From: Ameer Armaly <ameer@bellsouth.net>
X-X-Sender: ameer@debian
To: linux-kernel@vger.kernel.org, perex@suse.cz
cc: trivial@rustcorp.com.au
Subject: [patch] remove call to check_region in drivers/pnp/resource.c
Message-ID: <Pine.LNX.4.61.0508192336050.575@debian>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a call to check_region in drivers/pnp/resource.c, and 
replaces it with request_region.
signed-off-by: Ameer Armaly <ameerarmaly@bellsouth.net>
--- drivers/pnp/resource.c	2005-08-05 03:04:37.000000000 -0400
+++ drivers/pnp/resource.new	2005-08-18 20:46:34.000000000 -0400
@@ -252,7 +252,7 @@ int pnp_check_port(struct pnp_dev * dev,
  	/* check if the resource is already in use, skip if the
  	 * device is active because it itself may be in use */
  	if(!dev->active) {
-		if (__check_region(&ioport_resource, *port, length(port,end)))
+		if (request_region(&ioport_resource, *port, length(port,end)))
  			return 0;
  	}

