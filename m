Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWGQQcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWGQQcr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWGQQc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:46010 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750939AbWGQQcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:15 -0400
Date: Mon, 17 Jul 2006 09:28:31 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Takashi Iwai <tiwai@suse.de>,
       Jaroslav Kysela <perex@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 32/45] ALSA: Suppress irq handler mismatch messages in ALSA ISA drivers
Message-ID: <20060717162831.GG4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="alsa-suppress-irq-handler-mismatch-messages-in-alsa-isa-drivers.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Takashi Iwai <tiwai@suse.de>

[PATCH] Suppress irq handler mismatch messages in ALSA ISA drivers

Suppress 'irq handler mismatch' messages at auto-probing of irqs
in ALSA ISA drivers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jaroslav Kysela <perex@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/sound/initval.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.17.6.orig/include/sound/initval.h
+++ linux-2.6.17.6/include/sound/initval.h
@@ -62,7 +62,8 @@ static int snd_legacy_find_free_irq(int 
 {
 	while (*irq_table != -1) {
 		if (!request_irq(*irq_table, snd_legacy_empty_irq_handler,
-				 SA_INTERRUPT, "ALSA Test IRQ", (void *) irq_table)) {
+				 SA_INTERRUPT | SA_PROBEIRQ, "ALSA Test IRQ",
+				 (void *) irq_table)) {
 			free_irq(*irq_table, (void *) irq_table);
 			return *irq_table;
 		}

--
