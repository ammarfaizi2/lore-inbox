Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946530AbWKAF5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946530AbWKAF5J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946239AbWKAF5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:57:08 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:32455 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946123AbWKAFgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:36:05 -0500
Message-Id: <20061101053617.820410000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:49 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Takashi Iwai <tiwai@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 09/61] ALSA: powermac - Fix Oops when conflicting with aoa driver
Content-Disposition: inline; filename=alsa-powermac-fix-oops-when-conflicting-with-aoa-driver.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: powermac - Fix Oops when conflicting with aoa driver

Fixed Oops when conflictin with aoa driver due to lack of
i2c initialization.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 sound/ppc/keywest.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.18.1.orig/sound/ppc/keywest.c
+++ linux-2.6.18.1/sound/ppc/keywest.c
@@ -117,6 +117,9 @@ int __init snd_pmac_tumbler_post_init(vo
 {
 	int err;
 	
+	if (!keywest_ctx || !keywest_ctx->client)
+		return -ENXIO;
+
 	if ((err = keywest_ctx->init_client(keywest_ctx)) < 0) {
 		snd_printk(KERN_ERR "tumbler: %i :cannot initialize the MCS\n", err);
 		return err;

--
