Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVFGPvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVFGPvx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 11:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVFGPvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 11:51:52 -0400
Received: from ezoffice.mandriva.com ([84.14.106.134]:16141 "EHLO
	ezoffice.mandriva.com") by vger.kernel.org with ESMTP
	id S261899AbVFGPuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 11:50:39 -0400
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Yann Droneaud <ydroneaud@mandriva.com>
In-Reply-To: <m2y8aeyh9z.fsf@firedrake.mandriva.com>
References: <m2y8aeyh9z.fsf@firedrake.mandriva.com>, <m27jhyzwj6.fsf@firedrake.mandriva.com>
Subject: [PATCH] [RESENT] Fix Oops in IPMI with acpi=off|ht : ipmi_si_intf-acpi-disabled
Date: 07 Jun 2005 16:54:01 +0200
Message-ID: <m23brup69i.fsf@firedrake.mandriva.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[The patch was dropped in 2.6.12-rc5-mm2 with bk-acpi although it
wasn't related to it.
This patch is rediffed against 2.6.12-rc6, please apply]

This patch fix ipmi_si_intf to not use ACPI tables if the ACPI
subsystem is disabled, removing a Oops in ACPI layer (which is really
fixed by a previous patch sent by me but not confirmed by ACPI team).

Regards

--- linux-2.6.12-rc6/drivers/char/ipmi/ipmi_si_intf.c	2005-06-07 16:40:11.970072000 +0200
+++ linux-2.6.12-rc6-meuh/drivers/char/ipmi/ipmi_si_intf.c	2005-06-07 16:43:05.797516580 +0200
@@ -1484,6 +1484,9 @@ static int try_init_acpi(int intf_num, s
 	char             *io_type;
 	u8 		 addr_space;
 
+	if (acpi_disabled)
+		return -ENODEV;
+
 	if (acpi_failure)
 		return -ENODEV;
 


-- 
Yann Droneaud <ydroneaud@mandriva.com>
Consulting Engineer
Professional Services
Mandriva http://mandriva.com/ (previously known as Mandrakesoft)
