Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264646AbTEQBlH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 21:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbTEQBlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 21:41:06 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:50103 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264646AbTEQBlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 21:41:06 -0400
Date: Sat, 17 May 2003 02:55:41 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Marek Habersack <grendel@caudium.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel oops on boot with 2.5.69-mm{5,6}
Message-ID: <20030517015541.GA26464@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Marek Habersack <grendel@caudium.net>, linux-kernel@vger.kernel.org
References: <20030516230526.GA1527@thanes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516230526.GA1527@thanes.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 01:05:26AM +0200, Marek Habersack wrote:
 > Hello all,
 > 
 > 2.5.69-mm3 works fine, mm4 wasn't tested. Kernel oopses right after attempting to
 > initialize agpgart. I've managed to copy only the little data from the oops
 > that is shown below, enough to locate it (oops happened in the swapper task):

patch from Christoph Hellwig attached.
Still waiting for Linus to pull this (and other) agp bits from bkbits.

		Dave


--- 1.39/drivers/char/agp/via-agp.c	Mon Apr 28 03:32:35 2003
+++ edited/drivers/char/agp/via-agp.c	Tue May 13 10:51:00 2003
@@ -402,6 +402,7 @@
 
 	bridge->dev = pdev;
 	bridge->capndx = cap_ptr;
+	bridge->driver = &via_driver; /* might be overriden later */
 
 	switch (pdev->device) {
 	case PCI_DEVICE_ID_VIA_8367_0:
@@ -427,7 +428,6 @@
 		}
 		/*FALLTHROUGH*/
 	default:
-		bridge->driver = &via_driver;
 		break;
 	}
 

