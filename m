Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUGLUYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUGLUYH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUGLUYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:24:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:3024 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262574AbUGLUWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:22:35 -0400
Date: Mon, 12 Jul 2004 13:25:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Update pcips2 driver
Message-Id: <20040712132525.550bcebb.akpm@osdl.org>
In-Reply-To: <20040712154207.A15469@flint.arm.linux.org.uk>
References: <20040712154207.A15469@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> Use pci_request_regions()/pci_release_regions() instead of
> request_region()/release_region()

Some of this patch is already in Vojtech's tree.  If it's not critical,
perhaps it would be best if he took the remaining bit:


From: Russell King <rmk+lkml@arm.linux.org.uk>

Use pci_request_regions()/pci_release_regions() instead of
request_region()/release_region()

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/./drivers/input/serio/pcips2.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff -puN ./drivers/input/serio/pcips2.c~update-pcips2-driver ./drivers/input/serio/pcips2.c
--- 25/./drivers/input/serio/pcips2.c~update-pcips2-driver	Mon Jul 12 13:25:01 2004
+++ 25-akpm/./drivers/input/serio/pcips2.c	Mon Jul 12 13:25:01 2004
@@ -134,13 +134,11 @@ static int __devinit pcips2_probe(struct
 
 	ret = pci_enable_device(dev);
 	if (ret)
-		return ret;
+		goto out;
 
-	if (!request_region(pci_resource_start(dev, 0),
-			    pci_resource_len(dev, 0), "pcips2")) {
-		ret = -EBUSY;
+	ret = pci_request_regions(dev, "pcips2");
+	if (ret)
 		goto disable;
-	}
 
 	ps2if = kmalloc(sizeof(struct pcips2_data), GFP_KERNEL);
 	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
_

