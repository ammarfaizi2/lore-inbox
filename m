Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVCEPko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVCEPko (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 10:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVCEPkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 10:40:05 -0500
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:9683 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262111AbVCEPin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 10:38:43 -0500
From: "Panagiotis Issaris" <panagiotis.issaris@mech.kuleuven.ac.be>
Date: Sat, 5 Mar 2005 16:38:42 +0100
To: Matt_Domsch@dell.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] EFI missing failure handling
Message-ID: <20050305153841.GA7808@mech.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The EFI driver allocates memory and writes into it without checking the
success of the allocation:

668     efi_char16_t *variable_name = kmalloc(1024, GFP_KERNEL);
...
696     memset(variable_name, 0, 1024);

The patch applies to 2.6.11-bk1.

Signed-off-by: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>

diff -pruN linux-2.6.11-orig/drivers/firmware/efivars.c linux-2.6.11-pi/drivers/firmware/efivars.c
--- linux-2.6.11-orig/drivers/firmware/efivars.c	2005-03-05 02:23:29.000000000 +0100
+++ linux-2.6.11-pi/drivers/firmware/efivars.c	2005-03-05 02:23:04.000000000 +0100
@@ -670,6 +670,9 @@ efivars_init(void)
 	unsigned long variable_name_size = 1024;
 	int i, rc = 0, error = 0;
 
+	if (!variable_name)
+		return -ENOMEM;
+
 	if (!efi_enabled)
 		return -ENODEV;
 
-- 
  K.U.Leuven, Mechanical Eng.,  Mechatronics & Robotics Research Group
  http://people.mech.kuleuven.ac.be/~pissaris/
