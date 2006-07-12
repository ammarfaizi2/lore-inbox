Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWGLJJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWGLJJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 05:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWGLJJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 05:09:47 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:21120 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751001AbWGLJJq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 05:09:46 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [ACPI] Fix section for CPU init functions
Date: Wed, 12 Jul 2006 11:09:51 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060712090951.13209.74561.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ACPI processor init functions should be marked as __cpuinit as they
use structures marked with __cpuinitdata.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/acpi/processor_core.c |    2 +-
 drivers/acpi/processor_idle.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index b13d644..1908e0d 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -519,7 +519,7 @@ #endif
 
 static void *processor_device_array[NR_CPUS];
 
-static int acpi_processor_start(struct acpi_device *device)
+static int __cpuinit acpi_processor_start(struct acpi_device *device)
 {
 	int result = 0;
 	acpi_status status = AE_OK;
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 7106606..1ecd3a7 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1077,7 +1077,7 @@ static const struct file_operations acpi
 	.release = single_release,
 };
 
-int acpi_processor_power_init(struct acpi_processor *pr,
+int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
 			      struct acpi_device *device)
 {
 	acpi_status status = 0;

