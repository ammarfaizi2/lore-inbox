Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272670AbTHELgB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 07:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272672AbTHELgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 07:36:01 -0400
Received: from verein.lst.de ([212.34.189.10]:33451 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S272670AbTHELfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 07:35:54 -0400
Date: Tue, 5 Aug 2003 13:35:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@verein.lst.de>, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] simplify i386 mca Kconfig bits
Message-ID: <20030805113551.GB23754@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, James.Bottomley@steeleye.com,
	linux-kernel@vger.kernel.org
References: <20030805113154.GA23728@lst.de> <20030805113351.GA23754@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805113351.GA23754@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,PATCH_UNIFIED_DIFF,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 01:33:51PM +0200, Christoph Hellwig wrote:
> I should better attach the patch :)

*grr*, actually that was the next patch (also for inclusion) that fixes
drivers that include <linux/mca.h> on arches that don't have mca.

Here's the right one, finally.


--- 1.62/arch/i386/Kconfig	Thu Jun 19 19:06:56 2003
+++ edited/arch/i386/Kconfig	Tue Jun 24 21:31:52 2003
@@ -1104,16 +1104,13 @@
 
 config MCA
 	bool "MCA support"
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !X86_VISWS
+	default y if X86_VOYAGER
 	help
 	  MicroChannel Architecture is found in some IBM PS/2 machines and
 	  laptops.  It is a bus system similar to PCI or ISA. See
 	  <file:Documentation/mca.txt> (and especially the web page given
 	  there) before attempting to build an MCA bus kernel.
-
-config MCA
-	depends on X86_VOYAGER
-	default y if X86_VOYAGER
 
 source "drivers/mca/Kconfig"
 
