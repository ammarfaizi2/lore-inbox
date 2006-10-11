Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161423AbWJKVWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161423AbWJKVWc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161419AbWJKVHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:07:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:13985 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161424AbWJKVHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:07:18 -0400
Date: Wed, 11 Oct 2006 14:06:53 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 39/67] powerpc: Fix ohare IDE irq workaround on old powermacs
Message-ID: <20061011210653.GN16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="powerpc-fix-ohare-ide-irq-workaround-on-old-powermacs.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Looks like a workaround for old bogus OF bitrot... This fixes it and hence fixes
boot on some performa machines.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/ide/ppc/pmac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.orig/drivers/ide/ppc/pmac.c
+++ linux-2.6.18/drivers/ide/ppc/pmac.c
@@ -1326,7 +1326,7 @@ pmac_ide_macio_attach(struct macio_dev *
 	if (macio_irq_count(mdev) == 0) {
 		printk(KERN_WARNING "ide%d: no intrs for device %s, using 13\n",
 			i, mdev->ofdev.node->full_name);
-		irq = 13;
+		irq = irq_create_mapping(NULL, 13);
 	} else
 		irq = macio_irq(mdev, 0);
 

--
