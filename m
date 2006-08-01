Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751662AbWHAUGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbWHAUGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbWHAUGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:06:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17306 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751297AbWHAUGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:06:44 -0400
Date: Tue, 1 Aug 2006 16:06:43 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: improve machzwd detection.
Message-ID: <20060801200643.GB22240@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a machine with no machzwd, loading the module prints out..

machzwd: MachZ ZF-Logic Watchdog driver initializing.
0xffff
machzwd: Watchdog using action = RESET

- the 0xffff printk is unnecessary
- 0xffff seems to be 'hardware not present'
- fix CodingStyle. (This driver could use some more work here)

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15.noarch/drivers/char/watchdog/machzwd.c~	2006-02-01 22:20:16.000000000 -0500
+++ linux-2.6.15.noarch/drivers/char/watchdog/machzwd.c	2006-02-01 22:22:23.000000000 -0500
@@ -427,8 +427,7 @@ static int __init zf_init(void)
 	printk(KERN_INFO PFX ": MachZ ZF-Logic Watchdog driver initializing.\n");
 
 	ret = zf_get_ZFL_version();
-	printk("%#x\n", ret);
-	if((!ret) || (ret != 0xffff)){
+	if ((!ret) || (ret == 0xffff)) {
 		printk(KERN_WARNING PFX ": no ZF-Logic found\n");
 		return -ENODEV;
 	}


-- 
http://www.codemonkey.org.uk
