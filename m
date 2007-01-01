Return-Path: <linux-kernel-owner+w=401wt.eu-S1754490AbXAATwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbXAATwd (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbXAATwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:52:33 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:52677 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490AbXAATwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:52:32 -0500
Message-Id: <200701011947.l01Jl9QL020756@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/8] UML - audio driver locking
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Jan 2007 14:47:09 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comment the lack of locking and make a couple of variables static.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/hostaudio_kern.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/hostaudio_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/hostaudio_kern.c	2006-12-29 18:25:36.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/hostaudio_kern.c	2006-12-29 21:09:09.000000000 -0500
@@ -25,9 +25,12 @@ struct hostmixer_state {
 #define HOSTAUDIO_DEV_DSP "/dev/sound/dsp"
 #define HOSTAUDIO_DEV_MIXER "/dev/sound/mixer"
 
-/* Only changed from linux_main at boot time */
-char *dsp = HOSTAUDIO_DEV_DSP;
-char *mixer = HOSTAUDIO_DEV_MIXER;
+/* Changed either at boot time or module load time.  At boot, this is
+ * single-threaded; at module load, multiple modules would each have
+ * their own copy of these variables.
+ */
+static char *dsp = HOSTAUDIO_DEV_DSP;
+static char *mixer = HOSTAUDIO_DEV_MIXER;
 
 #define DSP_HELP \
 "    This is used to specify the host dsp device to the hostaudio driver.\n" \

