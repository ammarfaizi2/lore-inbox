Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVCQCei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVCQCei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 21:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVCQCei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 21:34:38 -0500
Received: from soundwarez.org ([217.160.171.123]:2455 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261762AbVCQCef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 21:34:35 -0500
Date: Thu, 17 Mar 2005 03:34:31 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>, Greg KH <greg@kroah.com>
Subject: [PATCH] add TIMEOUT to firmware_class hotplug event
Message-ID: <20050317023431.GA27777@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 09:25 +0100, Hannes Reinecke wrote:
> The current implementation of the firmware class breaks a fundamental
> assumption in udevd: that the physical device can be initialised fully
> prior to executing the next event for that device.

Here we add a TIMEOUT value to the hotplug environment of the firmware
requesting event. I will adapt udevd not to wait for anything else, if
it finds a TIMEOUT key.

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== drivers/base/firmware_class.c 1.25 vs edited =====
--- 1.25/drivers/base/firmware_class.c	2004-11-26 21:26:48 +01:00
+++ edited/drivers/base/firmware_class.c	2005-03-17 03:22:37 +01:00
@@ -102,6 +102,9 @@
 	if (add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size, &len,
 			"FIRMWARE=%s", fw_priv->fw_id))
 		return -ENOMEM;
+	if (add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size, &len,
+			"TIMEOUT=%i", loading_timeout))
+		return -ENOMEM;
 
 	envp[i] = NULL;
 

