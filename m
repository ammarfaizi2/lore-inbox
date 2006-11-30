Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936342AbWK3Mta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936342AbWK3Mta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936336AbWK3Mta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:49:30 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:65295 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S936321AbWK3Mt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:49:28 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: marcelo@kvack.org
Subject: [PATCH] ppc: cs4218_tdm remove extra brace
Date: Thu, 30 Nov 2006 13:48:58 +0100
User-Agent: KMail/1.9.5
Cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611301348.59401.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I tried to find where does this line come from. Googled a bit with
no luck. Probably somewhere between 2.5.10 and 2.5.20 some patch generated
this leftover.


static struct timer_list beep_timer = {
        function: cs_nosound
};

changed to:

static struct timer_list beep_timer = TIMER_INITIALIZER(cs_nosound, 0, 0);
};


The patch below removes this extra line.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/ppc/8xx_io/cs4218_tdm.c |    1 -
 1 file changed, 1 deletion(-)

--- linux-2.6.19-rc6-mm2-a/arch/ppc/8xx_io/cs4218_tdm.c	2006-11-28 12:16:29.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/arch/ppc/8xx_io/cs4218_tdm.c	2006-11-29 16:12:22.000000000 +0100
@@ -1379,7 +1379,6 @@ static void cs_nosound(unsigned long xx)
 }
 
 static DEFINE_TIMER(beep_timer, cs_nosound, 0, 0);
-};
 
 static void cs_mksound(unsigned int hz, unsigned int ticks)
 {


-- 
Regards,

	Mariusz Kozlowski
