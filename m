Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUDARBf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbUDARBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:01:16 -0500
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:20122 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S262969AbUDARAx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:00:53 -0500
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: linux-kernel@vger.kernel.org
Subject: AGP problem SiS 746FX Linux 2.6.5-rc3
Date: Thu, 1 Apr 2004 19:00:47 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404011900.47412.volker.hemmann@heim10.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in 2.6.5-rc3 was incorporated a fix for SiS648 chipsets that need a little 
time to get into a sane state again, after switching to AGP 8x.
The 746FX has the same timing problem and needs this 'pause', too.
Unfortunatly in sis-apg.c this fix is only checked against the 648, not the 
746, so the fix never gets invoked:

    		if(device->device == PCI_DEVICE_ID_SI_648) {
			// weird: on 648 and 648fx chipsets any rate change in the target command 
register
			// triggers a 5ms screwup during which the master cannot be configured
			printk(KERN_INFO PFX "sis 648 agp fix - giving bridge time to recover\n");
			set_current_state(TASK_UNINTERRUPTIBLE);
			schedule_timeout (1+(HZ*10)/1000);


Glück Auf,
Volker


-- 
Conclusions 
 In a straight-up fight, the Empire squashes the Federation like a bug. Even 
with its numerical advantage removed, the Empire would still squash the 
Federation like a bug. Accept it. -Michael Wong 
