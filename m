Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271149AbTGWHHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 03:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271148AbTGWHHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 03:07:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28303 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271147AbTGWHHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 03:07:19 -0400
Date: Wed, 23 Jul 2003 00:20:08 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: solca@guug.org, zaitcev@redhat.com, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org, debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-Id: <20030723002008.538dc163.davem@redhat.com>
In-Reply-To: <20030723080222.A5245@infradead.org>
References: <20030722025142.GC25561@guug.org>
	<20030722080905.A21280@devserv.devel.redhat.com>
	<20030722182609.GA30174@guug.org>
	<20030722175400.4fe2aa5d.davem@redhat.com>
	<20030723070739.A697@infradead.org>
	<20030722232410.7a37ed4d.davem@redhat.com>
	<20030723072836.A932@infradead.org>
	<20030722232911.2e6fda86.davem@redhat.com>
	<20030723074033.A1687@infradead.org>
	<20030722235714.5e2b285d.davem@redhat.com>
	<20030723080222.A5245@infradead.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 08:02:22 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Jul 22, 2003 at 11:57:14PM -0700, David S. Miller wrote:
> > I don't see why this is a problem.  Either do this, or fix
> > asm-generic/dma-mapping.h which is not GENERIC because it
> > depends upon something SPECIFIC, specifically PCI.
> 
> The latter is what need to be done.  

I'll do the following for now.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1518  -> 1.1519 
#	include/asm-sparc64/dma-mapping.h	1.1     -> 1.2    
#	include/asm-sparc/dma-mapping.h	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/07/23	davem@nuts.ninka.net	1.1519
# [SPARC]: Do not include asm-generic/dma-mapping.h if !CONFIG_PCI.
# --------------------------------------------
#
diff -Nru a/include/asm-sparc/dma-mapping.h b/include/asm-sparc/dma-mapping.h
--- a/include/asm-sparc/dma-mapping.h	Wed Jul 23 00:06:03 2003
+++ b/include/asm-sparc/dma-mapping.h	Wed Jul 23 00:06:03 2003
@@ -1 +1,5 @@
+#include <linux/config.h>
+
+#ifdef CONFIG_PCI
 #include <asm-generic/dma-mapping.h>
+#endif
diff -Nru a/include/asm-sparc64/dma-mapping.h b/include/asm-sparc64/dma-mapping.h
--- a/include/asm-sparc64/dma-mapping.h	Wed Jul 23 00:06:03 2003
+++ b/include/asm-sparc64/dma-mapping.h	Wed Jul 23 00:06:03 2003
@@ -1 +1,5 @@
+#include <linux/config.h>
+
+#ifdef CONFIG_PCI
 #include <asm-generic/dma-mapping.h>
+#endif
