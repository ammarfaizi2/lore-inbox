Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbVHXHAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbVHXHAs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 03:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbVHXHAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 03:00:48 -0400
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:52409
	"EHLO aechz.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S1750855AbVHXHAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 03:00:47 -0400
Date: Wed, 24 Aug 2005 08:59:54 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Michael Hunold <hunold@linuxtv.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] saa7146_i2c device model integration
Message-ID: <20050824065954.GA4368@titan.lahn.de>
Mail-Followup-To: Michael Hunold <hunold@linuxtv.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org> <20050811064217.GB21395@titan.lahn.de> <E1E3CJE-0001NJ-PH@allen.werkleitz.de> <20050815071723.GB8524@titan.lahn.de> <20050815215855.GB5860@linuxtv.org> <E1E4vSG-0005r7-KG@allen.werkleitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1E4vSG-0005r7-KG@allen.werkleitz.de>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Integrate saa7146_i2c adapter into device model:
Moves entries from /sys/device/platform to /sys/device/pci*.

Signed-off-by: Philipp Hahn <pmhahn@titan.lahn.de>

--- linux/drivers/media/common/saa7146_i2c.c	2004-10-26 22:24:09.000000000 +0200
+++ linux/drivers/media/common/saa7146_i2c.c	2004-10-24 16:00:32.000000000 +0200
@@ -409,6 +409,7 @@ int saa7146_i2c_adapter_prepare(struct s
 #else
 		BUG_ON(!i2c_adapter->class);
 		i2c_set_adapdata(i2c_adapter,dev);
+		i2c_adapter->dev.parent    = &dev->pci->dev;
 #endif
 		i2c_adapter->algo	   = &saa7146_algo;
 		i2c_adapter->algo_data     = NULL;

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
