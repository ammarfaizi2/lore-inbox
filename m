Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbULORVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbULORVo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 12:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbULORVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 12:21:43 -0500
Received: from colo.lackof.org ([198.49.126.79]:8393 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262401AbULORVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 12:21:40 -0500
Date: Wed, 15 Dec 2004 10:21:28 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Grant Grundler <grundler@parisc-linux.org>, frahm@irsamc.ups-tlse.fr,
       linux-kernel@vger.kernel.org, jgarzik@pobox.org
Subject: Re: [Fwd: 2.6.10-rc3: tulip-driver: tulip_stop_rxtx() failed]
Message-ID: <20041215172128.GB27818@colo.lackof.org>
References: <20041212214803.GB22514@colo.lackof.org> <200412130313.iBD3DAF4004365@albireo.free.fr> <20041213035936.GB26501@colo.lackof.org> <20041215005722.GE4357@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215005722.GE4357@tuxdriver.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 07:57:22PM -0500, John W. Linville wrote:
> On Sun, Dec 12, 2004 at 08:59:36PM -0700, Grant Grundler wrote:
> 
> > But still, I'm hopeing for two code changes as a result:
> > 1) include CSR5 and CSR6 in the printk output
> > 2) the date of the tulip driver revision needs to be updated (or dropped).
> 
> Patches?

Sorry...appended below.

> If you don't want to post them publicly yourself, send them to me
> and I'll be happy to test/package/post them...

Thanks!
But I don't mind posting them...I just spaced out and send the first bit
to jgarzik directly instead of "reply all".

Commit Log:
	add CSR5 and CSR6 output to debug tulip_stop_rxtx failures.
	Update version release date

Signed-off-by:
	Grant Grundler <grundler@parisc-linux.org>

thanks,
grant

Index: drivers/net/tulip/tulip.h
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/net/tulip/tulip.h,v
retrieving revision 1.11
diff -u -p -r1.11 tulip.h
--- drivers/net/tulip/tulip.h	4 Dec 2004 07:02:42 -0000	1.11
+++ drivers/net/tulip/tulip.h	12 Dec 2004 21:51:43 -0000
@@ -474,8 +474,11 @@ static inline void tulip_stop_rxtx(struc
 			udelay(10);
 
 		if (!i)
-			printk(KERN_DEBUG "%s: tulip_stop_rxtx() failed\n",
-					tp->pdev->slot_name);
+			printk(KERN_DEBUG "%s: tulip_stop_rxtx() failed"
+					" (CSR5 0x%x CSR6 0x%x)\n",
+					tp->pdev->slot_name,
+					ioread32(ioaddr + CSR5),
+					ioread32(ioaddr + CSR6));
 	}
 }
 

Index: drivers/net/tulip/tulip_core.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/net/tulip/tulip_core.c,v
retrieving revision 1.24
diff -u -p -r1.24 tulip_core.c
--- drivers/net/tulip/tulip_core.c	4 Dec 2004 07:02:42 -0000	1.24
+++ drivers/net/tulip/tulip_core.c	15 Dec 2004 17:18:39 -0000
@@ -22,7 +22,7 @@
 #else
 #define DRV_VERSION	"1.1.13"
 #endif
-#define DRV_RELDATE	"May 11, 2002"
+#define DRV_RELDATE	"December 15, 2004"
 
 
 #include <linux/module.h>
