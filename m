Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVAYTkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVAYTkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVAYTkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:40:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58244 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262097AbVAYTi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:38:26 -0500
Date: Tue, 25 Jan 2005 14:38:22 -0500
From: Dave Jones <davej@redhat.com>
To: Brice.Goglin@ens-lyon.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050125193822.GC9267@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Brice.Goglin@ens-lyon.org,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org> <41F4E28A.3090305@ens-lyon.fr> <20050124185258.GB27570@redhat.com> <20050124204458.GD27570@redhat.com> <41F56949.3010505@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41F56949.3010505@ens-lyon.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 10:31:53PM +0100, Brice Goglin wrote:
 > Dave Jones a écrit :
 > >Here's the most obvious bug fixed. There still seems to be
 > >something wrong however. It only successfully boots 50% of the
 > >time for me, (it reboots when starting X otherwise), and when
 > >it does boot, I get a flood of ...
 > >Warning: kfree_skb on hard IRQ cf7b5800
 > >Warning: kfree_skb on hard IRQ cf7b5800
 > >Warning: kfree_skb on hard IRQ cf7b5800
 > >
 > >I think there may be some stupid memory corruptor bug in there still.
 > 
 > Thanks, your patch makes X work again with DRI.
 > Actually, it successfully booted 100% of the time here.
 > I tried 6 or 7 times without seeing any problem like yours.
 > Let me know if you want me to try something special.

It's quite remarkable that it works at all.
This is needed too on top of -mm1.

		Dave

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/25 14:27:39-05:00 davej@redhat.com 
#   [AGPGART] Silly thinko in reserve bit masking.
#   
#   Stupid inversion meant we passed '0' to userspace, and madness
#   ensued resulting in very funky visuals.
#   
#   Signed-off-by: Dave Jones <davej@redhat.com>
# 
diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
--- a/drivers/char/agp/generic.c	2005-01-25 14:34:24 -05:00
+++ b/drivers/char/agp/generic.c	2005-01-25 14:34:24 -05:00
@@ -324,9 +324,9 @@
 	info->chipset = agp_bridge->type;
 	info->device = agp_bridge->dev;
 	if (check_bridge_mode(agp_bridge->dev))
-		info->mode = agp_bridge->mode & AGP3_RESERVED_MASK;
+		info->mode = agp_bridge->mode & ~AGP3_RESERVED_MASK;
 	else
-		info->mode = agp_bridge->mode & AGP2_RESERVED_MASK;
+		info->mode = agp_bridge->mode & ~AGP2_RESERVED_MASK;
 	info->aper_base = agp_bridge->gart_bus_addr;
 	info->aper_size = agp_return_size();
 	info->max_memory = agp_bridge->max_memory_agp;


