Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWBYXzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWBYXzb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 18:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWBYXzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 18:55:31 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:36236 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750713AbWBYXzb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 18:55:31 -0500
Date: Sun, 26 Feb 2006 00:53:47 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: John Zielinski <john_ml@undead.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA Velocity massive memory corruption with jumbo frames
Message-ID: <20060225235346.GA18558@electric-eye.fr.zoreil.com>
References: <43FFFB6B.7090700@undead.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FFFB6B.7090700@undead.cc>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Zielinski <john_ml@undead.cc> :
[...]
> Anyone know what I should try next?

Try the patch below and Cc: netdev@vger.kernel.org on further messages
please.

diff --git a/drivers/net/via-velocity.c b/drivers/net/via-velocity.c
index c2d5907..ed1f837 100644
--- a/drivers/net/via-velocity.c
+++ b/drivers/net/via-velocity.c
@@ -1106,6 +1106,9 @@ static void velocity_free_rd_ring(struct
 
 	for (i = 0; i < vptr->options.numrx; i++) {
 		struct velocity_rd_info *rd_info = &(vptr->rd_info[i]);
+		struct rx_desc *rd = vptr->rd_ring + i;
+
+		memset(rd, 0, sizeof(*rd));
 
 		if (!rd_info->skb)
 			continue;
