Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVGFVrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVGFVrW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVGFVrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 17:47:19 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:57494 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261272AbVGFVoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 17:44:24 -0400
Date: Thu, 7 Jul 2005 01:43:48 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc2: PCMCIA problem on AMD64
Message-ID: <20050707014348.A1005@jurassic.park.msu.ru>
References: <Pine.LNX.4.58.0507052126190.3570@g5.osdl.org> <200507061128.49843.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200507061128.49843.rjw@sisk.pl>; from rjw@sisk.pl on Wed, Jul 06, 2005 at 11:28:49AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 11:28:49AM +0200, Rafael J. Wysocki wrote:
> albercik:~ # cardmgr
> cardmgr[4702]: no sockets found!
...
> PCI: Device 0000:02:01.0 not available because of resource collisions
> PCI: Device 0000:02:01.1 not available because of resource collisions

Thanks for the report.
Does the appended one-liner fix that?

Ivan.

--- 2.6.13-rc2/drivers/pci/setup-bus.c	Thu Jul  7 01:30:58 2005
+++ linux/drivers/pci/setup-bus.c	Thu Jul  7 01:32:43 2005
@@ -74,6 +74,7 @@ pbus_assign_resources_sorted(struct pci_
 		idx = res - &list->dev->resource[0];
 		if (pci_assign_resource(list->dev, idx)) {
 			res->start = 0;
+			res->end = 0;
 			res->flags = 0;
 		}
 		tmp = list;
