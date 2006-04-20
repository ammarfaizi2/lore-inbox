Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWDTFmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWDTFmx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 01:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWDTFmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 01:42:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47808 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751262AbWDTFmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 01:42:52 -0400
Date: Wed, 19 Apr 2006 22:42:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: ken@krwtech.com, linux-kernel@vger.kernel.org
Subject: Re: Advansys SCSI driver and 2.6.16
Message-Id: <20060419224202.3e2f99f5.akpm@osdl.org>
In-Reply-To: <20060419163247.6986a87c.akpm@osdl.org>
References: <Pine.LNX.4.64.0604191444200.1841@death>
	<20060419163247.6986a87c.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> There have been no changes in the advansys driver since November 2005, and
>  nothing substantial in over a year. 

The advansys driver has been disabled for two years - since 2.6.8:

> ChangeSet@1.497.4282.43, 2004-06-26 10:50:12-05:00, jejb@mulgrave.(none)
>   advansys: add warning and convert #includes
>   
>   The DMA conversion of the advansys driver is still
>   broken.  Add a #warning to the driver and a comment
>   above it explaining what needs to be done.
>   
>   Mark the driver as BROKEN because of the warning
>   
>   Also remove the #include "scsi.h"
>   
>   Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
> 

So I don't know how you managed to get it to build in 2.6.15.

You can reenable it with:

--- devel/drivers/scsi/Kconfig~a	2006-04-19 22:39:51.000000000 -0700
+++ devel-akpm/drivers/scsi/Kconfig	2006-04-19 22:40:00.000000000 -0700
@@ -453,7 +453,7 @@ config SCSI_DPT_I2O
 
 config SCSI_ADVANSYS
 	tristate "AdvanSys SCSI support"
-	depends on (ISA || EISA || PCI) && SCSI && BROKEN
+	depends on (ISA || EISA || PCI) && SCSI
 	help
 	  This is a driver for all SCSI host adapters manufactured by
 	  AdvanSys. It is documented in the kernel source in
_

and it does compile.   Does it actually work?
