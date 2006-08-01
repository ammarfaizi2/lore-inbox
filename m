Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWHAOkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWHAOkB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWHAOkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:40:01 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:18164 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751204AbWHAOkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:40:00 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH] AVR32: Fix bug in __avr32_asr64
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 01 Aug 2006 16:39:51 +0200
Message-Id: <11544431912734-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

libgcc uses a logical shift right instruction in one place we're
using an arithmetic shift right. I believe libgcc is right.

This fixes some weirdness in the timer code that I've seen lately.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/lib/__avr32_asr64.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/avr32/lib/__avr32_asr64.S b/arch/avr32/lib/__avr32_asr64.S
index cbbd478..368b6bc 100644
--- a/arch/avr32/lib/__avr32_asr64.S
+++ b/arch/avr32/lib/__avr32_asr64.S
@@ -20,8 +20,8 @@ __avr32_asr64:
 	brle	1f
 
 	lsl	r8, r11, r9
+	lsr	r10, r10, r12
 	asr	r11, r11, r12
-	asr	r10, r10, r12
 	or	r10, r8
 	retal	r12
 
-- 
1.4.0

