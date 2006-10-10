Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWJJNYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWJJNYF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWJJNYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:24:05 -0400
Received: from rubidium.solidboot.com ([81.22.244.175]:6088 "EHLO
	mail.solidboot.com") by vger.kernel.org with ESMTP id S1750746AbWJJNYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:24:02 -0400
Date: Tue, 10 Oct 2006 16:23:39 +0300
From: Timo Teras <timo.teras@solidboot.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>, drzeus-list@drzeus.cx
Cc: Timo Teras <timo.teras@solidboot.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] MMC: Do not set unsupported bits in OCR response
Message-ID: <20061010132339.GA14769@mail.solidboot.com>
References: <20061009150044.GB1637@mail.solidboot.com> <20061009165317.GA6431@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009165317.GA6431@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The card might go to inactive state (according to specification), if
there are unsupported bits set in the OCR.

Signed-off-by: Timo Teras <timo.teras@solidboot.com>

---

 drivers/mmc/mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index ee8863c..c6f3077 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -475,7 +475,7 @@ static u32 mmc_select_voltage(struct mmc
        if (bit) {
                bit -= 1;
 
-               ocr = 3 << bit;
+               ocr &= 3 << bit;
 
                host->ios.vdd = bit;
                mmc_set_ios(host);

