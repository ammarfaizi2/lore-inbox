Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWGLX2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWGLX2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWGLX2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:28:47 -0400
Received: from cantor2.suse.de ([195.135.220.15]:44260 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932175AbWGLX2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:28:46 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Ben Gardner <gardner.ben@gmail.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 2/3] [PATCH] w1: fix idle check loop in ds2482
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 12 Jul 2006 16:24:55 -0700
Message-Id: <11527467003943-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11527466963731-git-send-email-greg@kroah.com>
References: <20060712232249.GA22654@kroah.com> <11527466963731-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Gardner <gardner.ben@gmail.com>

The idle check loop has a greater-than where it should have a less-than.
This causes the ds2482 driver to check for the idle condition exactly
once, which causes it to fail on faster machines.

Signed-off-by: Ben Gardner <gardner.ben@gmail.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/w1/masters/ds2482.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index af492cc..d93eb62 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -218,7 +218,7 @@ static int ds2482_wait_1wire_idle(struct
 		do {
 			temp = i2c_smbus_read_byte(&pdev->client);
 		} while ((temp >= 0) && (temp & DS2482_REG_STS_1WB) &&
-			 (++retries > DS2482_WAIT_IDLE_TIMEOUT));
+			 (++retries < DS2482_WAIT_IDLE_TIMEOUT));
 	}
 
 	if (retries > DS2482_WAIT_IDLE_TIMEOUT)
-- 
1.4.1

