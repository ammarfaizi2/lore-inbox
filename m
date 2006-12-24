Return-Path: <linux-kernel-owner+w=401wt.eu-S1753030AbWLXWEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbWLXWEZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 17:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753046AbWLXWEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 17:04:25 -0500
Received: from smtpq3.groni1.gr.home.nl ([213.51.130.202]:46495 "EHLO
	smtpq3.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbWLXWEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 17:04:24 -0500
X-Greylist: delayed 2848 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Dec 2006 17:04:24 EST
Message-ID: <458EEDF7.4000200@gmail.com>
Date: Sun, 24 Dec 2006 22:15:35 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] romsignature/checksum cleanup
Content-Type: multipart/mixed;
 boundary="------------010708040905020206050704"
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010708040905020206050704
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

Use adding __init to romsignature() (it's only called from probe_roms() 
which is itself __init) as an excuse to submit a pedantic cleanup.

Signed-off-by: Rene Herman <rene.herman@gmail.com>

--------------010708040905020206050704
Content-Type: text/plain;
 name="romsignature-checksum-cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="romsignature-checksum-cleanup.diff"

diff --git a/arch/i386/kernel/e820.c b/arch/i386/kernel/e820.c
index f391abc..2565fac 100644
--- a/arch/i386/kernel/e820.c
+++ b/arch/i386/kernel/e820.c
@@ -156,21 +156,22 @@ static struct resource standard_io_resou
 	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
 } };
 
-static int romsignature(const unsigned char *x)
+#define ROMSIGNATURE 0xaa55
+
+static int __init romsignature(const unsigned char *rom)
 {
 	unsigned short sig;
-	int ret = 0;
-	if (probe_kernel_address((const unsigned short *)x, sig) == 0)
-		ret = (sig == 0xaa55);
-	return ret;
+
+	return probe_kernel_address((const unsigned short *)rom, sig) == 0 &&
+	       sig == ROMSIGNATURE;
 }
 
 static int __init romchecksum(unsigned char *rom, unsigned long length)
 {
-	unsigned char *p, sum = 0;
+	unsigned char sum;
 
-	for (p = rom; p < rom + length; p++)
-		sum += *p;
+	for (sum = 0; length; length--)
+		sum += *rom++;
 	return sum == 0;
 }
 

--------------010708040905020206050704--
