Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263223AbVCKHRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263223AbVCKHRh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 02:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263224AbVCKHRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 02:17:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:15006 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263223AbVCKHRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 02:17:35 -0500
Date: Thu, 10 Mar 2005 23:17:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64: Add IDE-pmac support for new "Shasta" chipset
Message-Id: <20050310231700.5486ccd4.akpm@osdl.org>
In-Reply-To: <1110523540.5751.52.camel@gaston>
References: <1110523540.5751.52.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> The iMac G5 and new single CPU PowerMac G5 come with a new revision of
>  the K2 ASIC called Shasta. The PATA cell in there now does 133Mhz. This
>  patch adds support for it. It also adds some power management bits to
>  the old 100MHz cell that was in Intrepid based ppc32 machines.

Compile fix:

--- 25/drivers/ide/ppc/pmac.c~ppc64-add-ide-pmac-support-for-new-shasta-chipset-fix	2005-03-11 07:12:01.000000000 -0700
+++ 25-akpm/drivers/ide/ppc/pmac.c	2005-03-11 07:12:20.000000000 -0700
@@ -1301,7 +1301,7 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	 */
 	if (device_is_compatible(np, "K2-UATA") ||
 	    device_is_compatible(np, "shasta-ata"))
-		pmid->cable_80 = 1;
+		pmif->cable_80 = 1;
 
 	/* On Kauai-type controllers, we make sure the FCR is correct */
 	if (pmif->kauai_fcr)
_

(Wonders how well tested this was).
