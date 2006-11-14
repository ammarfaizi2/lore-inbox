Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966058AbWKNVVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966058AbWKNVVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966044AbWKNVVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:21:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:12154 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966058AbWKNVVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:21:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=NR/CqAFj0XFpN48Zdeuq0yreo/aNyugNugMs2ZQwwQ4uK9oX8LBM2szsK4Kn5qQwIY4IaD3k+qa2MlqK4aIpfXX+LaXaz5TTc4Xfzgen62Wq4BOcHuAFb64f8rqPxx/vRF1CHNZLBTerNKw2x17voemffEkBZ3V2I3hqUio1dCg=
Date: Wed, 15 Nov 2006 06:21:06 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH] acpi/processor: prevent loading module on failures
Message-ID: <20061114212106.GD20524@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes loading processor.ko fail when an error happens.

Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/acpi/processor_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: work-fault-inject/drivers/acpi/processor_core.c
===================================================================
--- work-fault-inject.orig/drivers/acpi/processor_core.c
+++ work-fault-inject/drivers/acpi/processor_core.c
@@ -901,13 +901,13 @@ static int __init acpi_processor_init(vo
 
 	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 	if (!acpi_processor_dir)
-		return 0;
+		return -ENOMEM;
 	acpi_processor_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_processor_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-		return 0;
+		return result;
 	}
 
 	acpi_processor_install_hotplug_notify();
