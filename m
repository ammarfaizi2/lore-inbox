Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946066AbWJ0BCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946066AbWJ0BCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 21:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946067AbWJ0BCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 21:02:54 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51981 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1946066AbWJ0BCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 21:02:54 -0400
Date: Fri, 27 Oct 2006 03:02:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Stephen Hemminger <shemminger@osdl.org>
Subject: [RFC: 2.6.19 patch] let PCI_MULTITHREAD_PROBE depend on BROKEN
Message-ID: <20061027010252.GV27968@stusta.de>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061026224541.GQ27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026224541.GQ27968@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 12:45:41AM +0200, Adrian Bunk wrote:
>...
> Subject    : swsusp initialized after SATA (CONFIG_PCI_MULTITHREAD_PROBE)
> References : http://lkml.org/lkml/2006/10/14/31
> Submitter  : Pavel Machek <pavel@ucw.cz>
> Status     : unknown
> 
> 
> Subject    : MSI errors during boot (CONFIG_PCI_MULTITHREAD_PROBE)
> References : http://lkml.org/lkml/2006/10/16/291
> Submitter  : Stephen Hemminger <shemminger@osdl.org>
> Handled-By : Greg KH <greg@kroah.com>
> Status     : Greg is working on a fix
>...


PCI_MULTITHREAD_PROBE is an interesting feature, but in it's current 
state it seems to be more of a trap for users who accidentally
enable it.

This patch lets PCI_MULTITHREAD_PROBE depend on BROKEN for 2.6.19.

The intention is to get this patch reversed in -mm as soon as it's in 
Linus' tree, and reverse it for 2.6.20 or 2.6.21 after the fallout of 
in-kernel problems PCI_MULTITHREAD_PROBE causes got fixed.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/drivers/pci/Kconfig.old	2006-10-27 02:40:02.000000000 +0200
+++ linux-2.6/drivers/pci/Kconfig	2006-10-27 02:58:25.000000000 +0200
@@ -19,7 +19,7 @@
 
 config PCI_MULTITHREAD_PROBE
 	bool "PCI Multi-threaded probe (EXPERIMENTAL)"
-	depends on PCI && EXPERIMENTAL
+	depends on PCI && EXPERIMENTAL && BROKEN
 	help
 	  Say Y here if you want the PCI core to spawn a new thread for
 	  every PCI device that is probed.  This can cause a huge

