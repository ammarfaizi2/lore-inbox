Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262931AbUKXXkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbUKXXkD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262895AbUKXXh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:37:59 -0500
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:914 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S262928AbUKXXah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:30:37 -0500
Date: Wed, 24 Nov 2004 18:14:28 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-kernel@vger.kernel.org
Cc: jonmason@us.ibm.com
Subject: pcnet32: 79c976 with fiber optic
Message-ID: <20041124171427.GA29693@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a Allied Telesys using a 79c976 with a fibre optic connectior.
pcnet32 detects the card fine but looses the link when I ifup the
interface. If I use:

--- tmp/linux-2.6.9/drivers/net/pcnet32.c	2004-10-18 23:53:45.000000000 +0200
+++ linux-2.6.9/drivers/net/pcnet32.c	2004-11-24 15:52:27.000000000 +0100
@@ -1425,6 +1425,8 @@
 	val |= 0x10;
     lp->a.write_csr (ioaddr, 124, val);
 
+    printk(KERN_DEBUG "pcnet32: Skipping AMD workaround\n");
+#if 0
     /* 24 Jun 2004 according AMD, in order to change the PHY,
      * DANAS (or DISPM for 79C976) must be set; then select the speed,
      * duplex, and/or enable auto negotiation, and clear DANAS */
@@ -1446,6 +1448,7 @@
 	    lp->a.write_bcr(ioaddr, 32, val);
 	}
     }
+#endif
 
 #ifdef DO_DXSUFLO
     if (lp->dxsuflo) { /* Disable transmit stop on und

it works fine. Any idea what exactly causes the problem?
Cheers,
 -- Guido
