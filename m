Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbULDVrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbULDVrj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 16:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbULDVrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 16:47:39 -0500
Received: from main.gmane.org ([80.91.229.2]:13201 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261172AbULDVrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 16:47:32 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: Linux 2.6.10-rc3
Date: Sat, 04 Dec 2004 16:47:45 -0500
Message-ID: <cotb9g$jfc$1@sea.gmane.org>
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org> <pan.2004.12.04.09.06.09.707940@nn7.de> <87oeha6lj1.fsf@sycorax.lbl.gov> <cosrt1$j67$1@sea.gmane.org> <87eki66jx8.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ool-4571c239.dyn.optonline.net
User-Agent: KNode/0.8.90
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Romosan wrote:

> Ari Pollak <aripollak@gmail.com> writes:
> 
> i saw there were some changes to alsa cvs having to do with the new
> pci device handling. i'll reconfigure the kernel with alsa as modules
> and try alsa cvs to see if that makes any difference. thanks.
> 

I have been using the following patch for a while with no problems:


--- linux/sound/pci/intel8x0.c 2004-12-04 16:37:11.000000000 -0500
+++ linux/sound/pci/intel8x0.c 2004-12-04 04:47:14.000000000 -0500
@@ -2279,6 +2279,8 @@
  for (i = 0; i < 3; i++)
   if (chip->ac97[i])
    snd_ac97_suspend(chip->ac97[i]);
+ pci_save_state(chip->pci);
+ pci_disable_device(chip->pci);
  snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
  return 0;
 }
@@ -2289,6 +2291,7 @@
  int i;
 
  pci_enable_device(chip->pci);
+ pci_restore_state(chip->pci);
  pci_set_master(chip->pci);
  snd_intel8x0_chip_init(chip, 0);
 

