Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVAXUth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVAXUth (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVAXUsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:48:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30349 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261648AbVAXUpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:45:07 -0500
Date: Mon, 24 Jan 2005 15:44:58 -0500
From: Dave Jones <davej@redhat.com>
To: Brice.Goglin@ens-lyon.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050124204458.GD27570@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Brice.Goglin@ens-lyon.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org> <41F4E28A.3090305@ens-lyon.fr> <20050124185258.GB27570@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124185258.GB27570@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 01:52:58PM -0500, Dave Jones wrote:
 > On Mon, Jan 24, 2005 at 12:56:58PM +0100, Brice Goglin wrote:
 >  > X does not work anymore when using DRI on my Compaq Evo N600c (Radeon 
 >  > Mobility M6 LY).
 >  > My XFree 4.3 (from Debian testing) with DRI uses drm and radeon kernel 
 >  > modules.
 >  
 > My fault. I'm looking into it.
 > Drop the agpgart-bk update for now.

Here's the most obvious bug fixed. There still seems to be
something wrong however. It only successfully boots 50% of the
time for me, (it reboots when starting X otherwise), and when
it does boot, I get a flood of ...
Warning: kfree_skb on hard IRQ cf7b5800
Warning: kfree_skb on hard IRQ cf7b5800
Warning: kfree_skb on hard IRQ cf7b5800

I think there may be some stupid memory corruptor bug in there still.

		Dave

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/24 15:37:57-05:00 davej@redhat.com 
#   [AGPGART] Fix stupid thinko in device discovery.
#   
#   Should fix the 'cant find AGP VGA controller' warnings.
#   
#   Signed-off-by: Dave Jones <davej@redhat.com>

diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
--- a/drivers/char/agp/generic.c	2005-01-24 15:38:26 -05:00
+++ b/drivers/char/agp/generic.c	2005-01-24 15:38:26 -05:00
@@ -626,7 +626,7 @@
 	u32 vga_agpstat;
 
 	while (!cap_ptr) {
-		device = pci_get_class(PCI_CLASS_DISPLAY_VGA, device);
+		device = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, device);
 		if (!device) {
 			printk (KERN_INFO PFX "Couldn't find an AGP VGA controller.\n");
 			return 0;
