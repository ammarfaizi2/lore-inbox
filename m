Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263025AbVCQJVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbVCQJVe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 04:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVCQJUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 04:20:36 -0500
Received: from fmr19.intel.com ([134.134.136.18]:58278 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S263026AbVCQJUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 04:20:19 -0500
Subject: [PATCH]fix oops when inserting ipmi_si module
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1111051119.18616.7.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 17 Mar 2005 17:18:39 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
In one of machines in our lab, spmi->addr.register_bit_width is 0 (so
the returned address is invalid). Ignoring the check will cause
inserting the module oops.

Thanks,
Shaohua

Signed-off-by: Li Shaohua<shaohua.li@intel.com>

--- a/drivers/char/ipmi/ipmi_si_intf.c	2005-03-03 10:56:51.000000000 +0800
+++ b/drivers/char/ipmi/ipmi_si_intf.c	2005-03-17 16:34:32.478606080 +0800
@@ -1466,6 +1466,11 @@ static int try_init_acpi(int intf_num, s
 	if (!is_new_interface(-1, addr_space, spmi->addr.address))
 		return -ENODEV;
 
+	if (!spmi->addr.register_bit_width) {
+		acpi_failure = 1;
+		return -ENODEV;
+	}
+
 	/* Figure out the interface type. */
 	switch (spmi->InterfaceType)
 	{


