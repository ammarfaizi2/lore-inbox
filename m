Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbTDQXre (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 19:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbTDQXre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 19:47:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27153 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262722AbTDQXrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 19:47:33 -0400
Date: Fri, 18 Apr 2003 00:59:11 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: jt@hpl.hp.com
Cc: Dominik Brodowski <linux@brodo.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.67 + i82365 -> oops
Message-ID: <20030418005911.M25478@flint.arm.linux.org.uk>
Mail-Followup-To: jt@hpl.hp.com, Dominik Brodowski <linux@brodo.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030417220018.GA28383@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030417220018.GA28383@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Thu, Apr 17, 2003 at 03:00:18PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 03:00:18PM -0700, Jean Tourrilhes wrote:
> 	I've got troubles with 2.5.67 and an ISA Pcmcia bridge
> (i82365). Half of the time, after boot, the card is recognised as
> memory_cs (which is not compiled), where it should be airo_cs.

Well, the oops can be solved by application of this patch.  As for the
random detection (or non-detection) of airo_cs, can you say that any
kernel has reliably detected it (and if so, which kernel?)  Basically
I'd like to know if the problem exists with:

	2.4
	2.5 before Dominik/my changes
	2.5 after changes

diff -Nru a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
--- a/drivers/pcmcia/cardbus.c	Fri Apr 18 00:55:08 2003
+++ b/drivers/pcmcia/cardbus.c	Fri Apr 18 00:55:08 2003
@@ -270,5 +270,6 @@
 {
 	struct pci_dev *bridge = s->cap.cb_dev;
 
-	pci_remove_behind_bridge(bridge);
+	if (bridge)
+		pci_remove_behind_bridge(bridge);
 }


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

