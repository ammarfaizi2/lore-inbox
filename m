Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTJaKho (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 05:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbTJaKho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 05:37:44 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:43199 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S263172AbTJaKhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 05:37:40 -0500
Message-ID: <3FA23B77.5040804@metaparadigm.com>
Date: Fri, 31 Oct 2003 18:37:43 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test9 Fix oops in quirk_via_bridge
References: <3FA22E6F.8000404@metaparadigm.com> <20031031094946.A4556@flint.arm.linux.org.uk> <3FA2324F.20801@metaparadigm.com> <20031031100043.B4556@flint.arm.linux.org.uk>
In-Reply-To: <20031031100043.B4556@flint.arm.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------090807040309000205000607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090807040309000205000607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/03 18:00, Russell King wrote:
> On Fri, Oct 31, 2003 at 05:58:39PM +0800, Michael Clark wrote:
> 
> Your fix looks 99% correct, except for the "__devinitdata" part - if
> you drop this and resubmit the patch, I'm sure gregkh will take it.

Cool. dropped __devinitdata, tested and works. Now I can suspend
and resume then insert my ieee1394 cardbus controller with no oops.

~mc


--------------090807040309000205000607
Content-Type: text/plain;
 name="fix_via_quirk2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_via_quirk2.patch"

--- linux-2.6.0-test9/drivers/pci/quirks.c	2003-10-31 16:49:25.000000000 +0800
+++ linux-2.6.0-test9-mc/drivers/pci/quirks.c	2003-10-31 18:27:41.000000000 +0800
@@ -646,7 +646,7 @@
  
 int interrupt_line_quirk;
 
-static void __init quirk_via_bridge(struct pci_dev *pdev)
+static void __devinit quirk_via_bridge(struct pci_dev *pdev)
 {
 	if(pdev->devfn == 0)
 		interrupt_line_quirk = 1;


--------------090807040309000205000607--

