Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWGQQeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWGQQeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWGQQdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:33:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:47803 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750963AbWGQQc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:59 -0400
Date: Mon, 17 Jul 2006 09:27:40 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 22/45] Make powernow-k7 work on SMP kernels.
Message-ID: <20060717162740.GW4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="make-powernow-k7-work-on-smp-kernels.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Dave Jones <davej@redhat.com>

[CPUFREQ] Make powernow-k7 work on SMP kernels.
Even though powernow-k7 doesn't work in SMP environments,
it can work on an SMP configured kernel if there's only
one CPU present, however recalibrate_cpu_khz was returning
-EINVAL on such kernels, so we failed to init the cpufreq driver.

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 arch/i386/kernel/cpu/cpufreq/powernow-k7.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- linux-2.6.17.4.orig/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
+++ linux-2.6.17.4/arch/i386/kernel/cpu/cpufreq/powernow-k7.c
@@ -581,10 +581,7 @@ static int __init powernow_cpu_init (str
 
 	rdmsrl (MSR_K7_FID_VID_STATUS, fidvidstatus.val);
 
-	/* recalibrate cpu_khz */
-	result = recalibrate_cpu_khz();
-	if (result)
-		return result;
+	recalibrate_cpu_khz();
 
 	fsb = (10 * cpu_khz) / fid_codes[fidvidstatus.bits.CFID];
 	if (!fsb) {

--
