Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268143AbTBNXkk>; Fri, 14 Feb 2003 18:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268409AbTBNXkk>; Fri, 14 Feb 2003 18:40:40 -0500
Received: from air-2.osdl.org ([65.172.181.6]:22144 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S268143AbTBNXkd>;
	Fri, 14 Feb 2003 18:40:33 -0500
Date: Fri, 14 Feb 2003 15:50:21 -0800
From: Bob Miller <rem@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.60 1/9] Add rename_region().
Message-ID: <20030214235021.GF13336@doc.pdx.osdl.net>
References: <20030214234349.GB13336@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030214234349.GB13336@doc.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 03:43:49PM -0800, Bob Miller wrote:
> Some devices need to call request_region() to reserve io ports before they know
> the exact name needed (i.e: parport0).  The new rename_region() method allows
> the name to be replaced after the real name is known.
> 
> -- 
> Bob Miller					Email: rem@osdl.org
> Open Source Development Lab			Phone: 503.626.2455 Ext. 17
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Sorry forgot the diff...

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17

:r /tmp/parport.patch.all

diff -Nru a/include/linux/ioport.h b/include/linux/ioport.h
--- a/include/linux/ioport.h	Fri Feb 14 09:50:44 2003
+++ b/include/linux/ioport.h	Fri Feb 14 09:50:44 2003
@@ -107,6 +107,7 @@
 #define release_region(start,n)	__release_region(&ioport_resource, (start), (n))
 #define check_mem_region(start,n)	__check_region(&iomem_resource, (start), (n))
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
+#define rename_region(resource, n)	(resource)->name = (n);
 
 extern int __deprecated __check_region(struct resource *, unsigned long, unsigned long);
 extern void __release_region(struct resource *, unsigned long, unsigned long);

