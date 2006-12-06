Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758792AbWLFA0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758792AbWLFA0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 19:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758818AbWLFA0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 19:26:00 -0500
Received: from smtp4.oregonstate.edu ([128.193.15.32]:33957 "EHLO
	smtp4.oregonstate.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758792AbWLFAZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 19:25:58 -0500
X-Spam-Score: 1.919
Message-ID: <45760E1E.9090007@onid.orst.edu>
Date: Tue, 05 Dec 2006 16:26:06 -0800
From: John Daiker <daikerj@onid.orst.edu>
User-Agent: Thunderbird 1.5.0.8 (X11/20061117)
MIME-Version: 1.0
To: James.Bottomley@SteelEye.com
CC: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH][Trivial] scsi: Fix 'unused variable' warning in scsi.c
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Daiker <daikerjohn@gmail.com>

This patch applies cleanly to 2.6.19-git7

Fixes the following warning:
CC drivers/scsi/scsi.o
drivers/scsi/scsi.c: In function ‘scsi_device_put’:
drivers/scsi/scsi.c:874: warning: unused variable ‘module’

Signed-off-by: John Daiker <daikerjohn@gmail.com>
---
drivers/scsi/scsi.c | 2 +-
1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index c59f315..780d6dc 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -871,9 +871,9 @@ EXPORT_SYMBOL(scsi_device_get);
*/
void scsi_device_put(struct scsi_device *sdev)
{
+#ifdef CONFIG_MODULE_UNLOAD
struct module *module = sdev->host->hostt->module;

-#ifdef CONFIG_MODULE_UNLOAD
/* The module refcount will be zero if scsi_device_get()
* was called from a module removal routine */
if (module && module_refcount(module) != 0)
