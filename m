Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbUKOXVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUKOXVt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbUKOXVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:21:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61458 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261624AbUKOXVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:21:47 -0500
Date: Tue, 16 Nov 2004 00:18:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: [patch] 2.4.28-rc3: __neigh_for_each_release must be EXPORT_SYMBOL'ed
Message-ID: <20041115231848.GB4946@stusta.de>
References: <4198CAFC.7030705@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4198CAFC.7030705@ttnet.net.tr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 05:27:56PM +0200, O.Sezer wrote:

> A similar export should also be needed for __neigh_for_each_release :
> 
> /sbin/depmod -ae -F System.map 2.4.28-rc3aac2
> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.28-rc3aac2/kernel/net/atm/clip.o
> depmod: 	__neigh_for_each_release


Thanks for this report.

For some strange reason, this wasn't covered by the modular .config I 
used for testing...

Patch (on top of my other patch) below.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.4.28-rc3-modular/net/core/neighbour.c.old	2004-11-15 22:14:54.000000000 +0100
+++ linux-2.4.28-rc3-modular/net/core/neighbour.c	2004-11-15 22:15:19.000000000 +0100
@@ -1597,6 +1597,7 @@
 		}
 	}
 }
+EXPORT_SYMBOL(__neigh_for_each_release);
 
 #ifdef CONFIG_PROC_FS
 


