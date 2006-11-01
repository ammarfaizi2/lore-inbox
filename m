Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946529AbWKAF4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946529AbWKAF4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946534AbWKAFzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:55:42 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:58000 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946239AbWKAFgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:36:44 -0500
Message-Id: <20061101053631.243211000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:50 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Amol Lad <amol@verismonetworks.com>,
       Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/61] sound/pci/au88x0/au88x0.c: ioremap balanced with iounmap
Content-Disposition: inline; filename=sound-pci-au88x0-au88x0.c-ioremap-balanced-with-iounmap.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Amol Lad <amol@verismonetworks.com>

[PATCH] sound/pci/au88x0/au88x0.c: ioremap balanced with iounmap

From: Amol Lad <amol@verismonetworks.com>
Signed-off-by: Amol Lad <amol@verismonetworks.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 sound/pci/au88x0/au88x0.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.18.1.orig/sound/pci/au88x0/au88x0.c
+++ linux-2.6.18.1/sound/pci/au88x0/au88x0.c
@@ -128,6 +128,7 @@ static int snd_vortex_dev_free(struct sn
 	// Take down PCI interface.
 	synchronize_irq(vortex->irq);
 	free_irq(vortex->irq, vortex);
+	iounmap(vortex->mmio);
 	pci_release_regions(vortex->pci_dev);
 	pci_disable_device(vortex->pci_dev);
 	kfree(vortex);

--
