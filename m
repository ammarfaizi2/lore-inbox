Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWDFT40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWDFT40 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 15:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWDFT40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 15:56:26 -0400
Received: from outmx009.isp.belgacom.be ([195.238.5.4]:33724 "EHLO
	outmx009.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751248AbWDFT4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 15:56:25 -0400
Date: Thu, 6 Apr 2006 21:55:59 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: patches in the linux-2.6-watchdog-mm git tree
Message-ID: <20060406195559.GB4284@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

Following patches have been added to the linux-2.6-watchdog-mm git tree:

 Documentation/watchdog/watchdog-api.txt |    3 +++
 drivers/char/watchdog/sc1200wdt.c       |    2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

Changes:

Author: Randy Dunlap <rdunlap@xenotime.net>
Date:   Tue Apr 4 20:17:26 2006 -0700

    [WATCHDOG] Documentation/watchdog/watchdog-api.txt - fix watchdog daemon
    
    Fix the simple watchdog daemon program in Doc/watchdog/watchdog-api.txt
    to build cleanly.
    
    Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Author: Dave Jones <davej@redhat.com>
Date:   Mon Apr 3 16:04:48 2006 -0700

    [WATCHDOG] sc1200wdt.c printk fix
    
    Fix printk output.
    
    sc1200wdt: build 20020303<3>sc1200wdt: io parameter must be specified
    
    Signed-off-by: Dave Jones <davej@redhat.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Andrew Morton <akpm@osdl.org>


The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog-mm.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/Documentation/watchdog/watchdog-api.txt b/Documentation/watchdog/watchdog-api.txt
index c5beb54..21ed511 100644
--- a/Documentation/watchdog/watchdog-api.txt
+++ b/Documentation/watchdog/watchdog-api.txt
@@ -36,6 +36,9 @@ timeout or margin.  The simplest way to 
 some data to the device.  So a very simple watchdog daemon would look
 like this:
 
+#include <stdlib.h>
+#include <fcntl.h>
+
 int main(int argc, const char *argv[]) {
 	int fd=open("/dev/watchdog",O_WRONLY);
 	if (fd==-1) {
diff --git a/drivers/char/watchdog/sc1200wdt.c b/drivers/char/watchdog/sc1200wdt.c
index 515ce75..20b88f9 100644
--- a/drivers/char/watchdog/sc1200wdt.c
+++ b/drivers/char/watchdog/sc1200wdt.c
@@ -377,7 +377,7 @@ static int __init sc1200wdt_init(void)
 {
 	int ret;
 
-	printk(banner);
+	printk("%s\n", banner);
 
 	spin_lock_init(&sc1200wdt_lock);
 	sema_init(&open_sem, 1);
