Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263433AbVCEAg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263433AbVCEAg7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbVCEA1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:27:19 -0500
Received: from thumbler.kulnet.kuleuven.ac.be ([134.58.240.45]:24508 "EHLO
	thumbler.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S263399AbVCEAST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:18:19 -0500
From: "Panagiotis Issaris" <panagiotis.issaris@mech.kuleuven.ac.be>
Date: Sat, 5 Mar 2005 01:18:16 +0100
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Toshiba ACPI failure handling
Message-ID: <20050305001816.GA4873@mech.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Adds the missing failure handling for a kmalloc in the Toshiba
ACPI driver.

Signed-off-by: Panagiotis Issaris <takis@gna.org>

diff -pruN linux-2.6.11-orig/drivers/acpi/toshiba_acpi.c linux-2.6.11-pi/drivers/acpi/toshiba_acpi.c
--- linux-2.6.11-orig/drivers/acpi/toshiba_acpi.c	2005-03-05 01:04:40.000000000 +0100
+++ linux-2.6.11-pi/drivers/acpi/toshiba_acpi.c	2005-03-05 01:03:13.000000000 +0100
@@ -263,6 +263,9 @@ dispatch_write(struct file* file, const 
 	 * destination so that sscanf can be used on it safely.
 	 */
 	tmp_buffer = kmalloc(count + 1, GFP_KERNEL);
+	if(!tmp_buffer)
+		return -ENOMEM;
+
 	if (copy_from_user(tmp_buffer, buffer, count)) {
 		result = -EFAULT;
 	}

-- 
  K.U.Leuven, Mechanical Eng.,  Mechatronics & Robotics Research Group
  http://people.mech.kuleuven.ac.be/~pissaris/
