Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVGFLQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVGFLQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 07:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVGFLQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 07:16:41 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:32520 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S262170AbVGFImv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 04:42:51 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: ALSA bt87x compile failure in 2.6.13-rc3
In-Reply-To: <Pine.SOC.4.61.0507060925010.22423@math.ut.ee>
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13-rc1 (i686))
Message-Id: <20050706084245.9736F14132@rhn.tartu-labor>
Date: Wed,  6 Jul 2005 11:42:45 +0300 (EEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MR> Substituting driver with pci->driver seems to cure it, it this the 
MR> correct fix?

I mean, the second argument to pci_match_device is already pci so it
looks strange.

Anyway, here is the patch that I used to get it to compile - untested.

Signed-off-by: Meelis Roos <mroos@linux.ee>

diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -804,7 +804,7 @@ static int __devinit snd_bt87x_detect_ca
 	int i;
 	const struct pci_device_id *supported;
 
-	supported = pci_match_device(driver, pci);
+	supported = pci_match_device(pci->driver, pci);
 	if (supported)
 		return supported->driver_data;
 
-- 
Meelis Roos
