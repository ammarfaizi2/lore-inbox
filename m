Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWGQQrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWGQQrr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWGQQr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:47:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:41402 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750944AbWGQQcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:11 -0400
Date: Mon, 17 Jul 2006 09:27:45 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ben Collins <bcollins@ubuntu.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 23/45] Fix powernow-k8 SMP kernel on UP hardware bug.
Message-ID: <20060717162745.GX4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-powernow-k8-smp-kernel-on-up-hardware-bug.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Randy Dunlap <randy.dunlap@oracle.com>

[CPUFREQ] Fix powernow-k8 SMP kernel on UP hardware bug.

Fix powernow-k8 doesn't load bug.
Reference: https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/35145

Signed-off-by: Ben Collins <bcollins@ubuntu.com>
Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 arch/i386/kernel/cpu/cpufreq/powernow-k8.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.4.orig/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
+++ linux-2.6.17.4/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
@@ -1008,7 +1008,7 @@ static int __cpuinit powernowk8_cpu_init
 		 * an UP version, and is deprecated by AMD.
 		 */
 
-		if ((num_online_cpus() != 1) || (num_possible_cpus() != 1)) {
+		if (num_online_cpus() != 1) {
 			printk(KERN_ERR PFX "MP systems not supported by PSB BIOS structure\n");
 			kfree(data);
 			return -ENODEV;

--
