Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262659AbVBYMZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVBYMZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 07:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVBYMZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 07:25:09 -0500
Received: from smtp8.wanadoo.fr ([193.252.22.23]:12392 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262659AbVBYMY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 07:24:59 -0500
X-ME-UUID: 20050225122458291.4711C1C0026D@mwinf0802.wanadoo.fr
Date: Fri, 25 Feb 2005 13:15:37 +0100
To: Christian <evil@g-house.de>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Tom Rini <trini@kernel.crashing.org>,
       Meelis Roos <mroos@linux.ee>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org, Sven Hartge <hartge@ds9.gnuu.de>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah) PCI IRQ map
Message-ID: <20050225121536.GA20174@pegasos>
References: <20041206185416.GE7153@smtp.west.cox.net> <Pine.SOC.4.61.0502221031230.6097@math.ut.ee> <20050224074728.GA31434@pegasos> <Pine.SOC.4.61.0502241746450.21289@math.ut.ee> <20050224160657.GB11197@pegasos> <421E7033.1030600@g-house.de> <20050225063609.GA21244@pegasos> <49984.195.126.66.126.1109332744.squirrel@housecafe.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <49984.195.126.66.126.1109332744.squirrel@housecafe.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2005 at 12:59:04PM +0100, Christian wrote:
> On Fri, February 25, 2005 7:36, Sven Luther said:
> > So, now, we need to find out what the problems where, i think it is
> > something that went in between 2.6.8 and 2.6.10, and leigh said he had
> > some ideas.
> 
> may i ask what patches were applied to a vanilla 2.6.8 kernel to build the
> 2.6.8-d-i then?

Some backports that i got from the list. The complete list of patches is at :

  http://svn.debian.org/wsvn/kernel/trunk/kernel/source/kernel-source-2.6.8-2.6.8/debian/patches/?rev=0&sc=0

And i guess the one at hand here is : 

  http://svn.debian.org/wsvn/kernel/trunk/kernel/source/kernel-source-2.6.8-2.6.8/debian/patches/powerpc-prep-powerstack-irq.dpatch?op=file&rev=0&sc=0

--- kernel-source-2.6.8.orig/arch/ppc/platforms/prep_pci.c	2004-12-28
08:24:07.000000000 +0100
+++ kernel-source-2.6.8/arch/ppc/platforms/prep_pci.c	2005-01-03
11:15:30.604274816 +0100ll lines beginning with `## DP:' are a description of
the patch.
## DP: Description: Fix PReP - motorola powerstack II utah pci irq mapping.
## DP: Patch author: Tom Rini <trini@kernel.crashing.org>
## DP: Upstream status: backport

. $(dirname $0)/DPATCH

@DPATCH@
@@ -115,13 +115,13 @@
 static char Utah_pci_IRQ_map[23] __prepdata =
 {
         0,   /* Slot 0  - unused */
-        0,   /* Slot 1  - unused */
+        4,   /* Slot 1  - IDE - SL82C105 */
         5,   /* Slot 2  - SCSI - NCR825A  */
         0,   /* Slot 3  - unused */
-        1,   /* Slot 4  - Ethernet - DEC2114x */
+        3,   /* Slot 4  - Ethernet - DEC2114x */
         0,   /* Slot 5  - unused */
-        3,   /* Slot 6  - PCI Card slot #1 */
-        4,   /* Slot 7  - PCI Card slot #2 */
+        2,   /* Slot 6  - PCI Card slot #1 */
+        3,   /* Slot 7  - PCI Card slot #2 */
         5,   /* Slot 8  - PCI Card slot #3 */
         5,   /* Slot 9  - PCI Bridge */
              /* added here in case we ever support PCI bridges */

Friendly,

Sven Luther

