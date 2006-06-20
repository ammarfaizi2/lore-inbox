Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWFTLvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWFTLvt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWFTLvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:51:39 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:55425 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1030230AbWFTLvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:51:24 -0400
Message-Id: <20060620114854.321484000@sous-sol.org>
References: <20060620114527.934114000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 20 Jun 2006 00:00:12 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       git-commits-head@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Dave Jones <davej@codemonkey.org.uk>, "Len Brown" <len.brown@intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 12/13] powernow-k8 crash workaround
Content-Disposition: inline; filename=powernow-k8-crash-workaround.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Andrew Morton <akpm@osdl.org>

Work around the oops reported in
http://bugzilla.kernel.org/show_bug.cgi?id=6478.

Thanks to Ralf Hildebrandt <ralf.hildebrandt@charite.de> for testing and
reporting.

Acked-by: Dave Jones <davej@codemonkey.org.uk>
Cc: "Len Brown" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/acpi/processor_perflib.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.16.21.orig/drivers/acpi/processor_perflib.c
+++ linux-2.6.16.21/drivers/acpi/processor_perflib.c
@@ -577,6 +577,8 @@ acpi_processor_register_performance(stru
 		return_VALUE(-EBUSY);
 	}
 
+	WARN_ON(!performance);
+
 	pr->performance = performance;
 
 	if (acpi_processor_get_performance_info(pr)) {
@@ -609,7 +611,8 @@ acpi_processor_unregister_performance(st
 		return_VOID;
 	}
 
-	kfree(pr->performance->states);
+	if (pr->performance)
+		kfree(pr->performance->states);
 	pr->performance = NULL;
 
 	acpi_cpufreq_remove_file(pr);

--
