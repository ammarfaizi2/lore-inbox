Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVJaXdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVJaXdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 18:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVJaXdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 18:33:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751296AbVJaXdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 18:33:10 -0500
Date: Mon, 31 Oct 2005 15:33:07 -0800
From: Chris Wright <chrisw@osdl.org>
To: kjhall@us.ibm.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH] TPM compile fix
Message-ID: <20051031233307.GV7991@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current tree doesn't build (at least on x86_64) due to TPM breakage:

  CC      drivers/char/tpm/tpm_nsc.o
drivers/char/tpm/tpm_nsc.c:277: error: `platform_bus_type' undeclared here (not in a function)
...
  CC      drivers/char/tpm/tpm_atmel.o
drivers/char/tpm/tpm_atmel.c:175: error: `platform_bus_type' undeclared here (not in a function)

Make sure to include proper headers.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---

diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
--- a/drivers/char/tpm/tpm_atmel.c
+++ b/drivers/char/tpm/tpm_atmel.c
@@ -19,6 +19,7 @@
  * 
  */
 
+#include <linux/platform_device.h>
 #include "tpm.h"
 
 /* Atmel definitions */
diff --git a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
--- a/drivers/char/tpm/tpm_nsc.c
+++ b/drivers/char/tpm/tpm_nsc.c
@@ -19,6 +19,7 @@
  * 
  */
 
+#include <linux/platform_device.h>
 #include "tpm.h"
 
 /* National definitions */
