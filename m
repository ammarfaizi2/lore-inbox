Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVDEOZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVDEOZU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVDEOZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:25:19 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11793 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261751AbVDEOYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:24:51 -0400
Date: Tue, 5 Apr 2005 16:24:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, mshefty@ichips.intel.com, halr@voltaire.com,
       openib-general@openib.org
Subject: [-mm patch] drivers/infiniband/hw/mthca/mthca_main.c: remove an unused label
Message-ID: <20050405142449.GF6885@stusta.de>
References: <20050405000524.592fc125.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405000524.592fc125.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 12:05:24AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-rc1-mm4:
>...
> +ib-mthca-add-support-for-new-mt25204-hca.patch
> 
>  Infiniband update
>...


This patch causes the following compile warning:

<--  snip  -->

...
  CC      drivers/infiniband/hw/mthca/mthca_main.o
drivers/infiniband/hw/mthca/mthca_main.c: In function `mthca_init_icm':
drivers/infiniband/hw/mthca/mthca_main.c:479: warning: label 
`err_unmap_eqp' defined but not used
...

<--  snip  -->


I'm not sure whether this patch to remove this label is correct, but if 
it isn't correct there must be a bug somewhere.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm1-full/drivers/infiniband/hw/mthca/mthca_main.c.old	2005-04-05 16:18:09.000000000 +0200
+++ linux-2.6.12-rc2-mm1-full/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-05 16:19:15.000000000 +0200
@@ -475,8 +475,6 @@
 
 err_unmap_rdb:
 	mthca_free_icm_table(mdev, mdev->qp_table.rdb_table);
-
-err_unmap_eqp:
 	mthca_free_icm_table(mdev, mdev->qp_table.eqp_table);
 
 err_unmap_qp:


