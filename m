Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751679AbWIMID5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbWIMID5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 04:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbWIMID5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 04:03:57 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:39903 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751679AbWIMID4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 04:03:56 -0400
Date: Wed, 13 Sep 2006 10:05:00 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jason Baron <jbaron@redhat.com>
Subject: [-mm patch] AVR32: Make PROT_WRITE | PROT_EXEC imply PROT_READ
Message-ID: <20060913100500.4e41ef8e@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The AVR32 MMU has three protection bits for allowing unprivileged
access, write access and execute access respectively. There is no
way to deny read access while allowing write or execute access.

make-prot_write-imply-prot_read.patch in mm does basically the same
thing for several other architectures. One important difference is
that this patch makes PROT_EXEC imply PROT_READ as well, but it looks
like this is the case for most other architectures already.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/mm/fault.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.18-rc5-mm1/arch/avr32/mm/fault.c
===================================================================
--- linux-2.6.18-rc5-mm1.orig/arch/avr32/mm/fault.c	2006-09-06 16:57:46.000000000 +0200
+++ linux-2.6.18-rc5-mm1/arch/avr32/mm/fault.c	2006-09-06 17:02:46.000000000 +0200
@@ -134,7 +134,7 @@ good_area:
 		break;
 	case ECR_PROTECTION_R:
 	case ECR_TLB_MISS_R:
-		if (!(vma->vm_flags & VM_READ))
+		if (!(vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC)))
 			goto bad_area;
 		break;
 	case ECR_PROTECTION_W:
