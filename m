Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWDEAHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWDEAHF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWDEABj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:01:39 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:34498
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750976AbWDEABc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:01:32 -0400
Date: Tue, 4 Apr 2006 17:00:48 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       git-commits-head@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 16/26] Fix the p4-clockmod N60 errata workaround.
Message-ID: <20060405000048.GQ27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-the-p4-clockmod-n60-errata-workaround.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

[CPUFREQ] Fix the p4-clockmod N60 errata workaround.

Fix the code to disable freqs less than 2GHz in N60 errata.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/i386/kernel/cpu/cpufreq/p4-clockmod.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.1.orig/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
+++ linux-2.6.16.1/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
@@ -244,7 +244,7 @@ static int cpufreq_p4_cpu_init(struct cp
 	for (i=1; (p4clockmod_table[i].frequency != CPUFREQ_TABLE_END); i++) {
 		if ((i<2) && (has_N44_O17_errata[policy->cpu]))
 			p4clockmod_table[i].frequency = CPUFREQ_ENTRY_INVALID;
-		else if (has_N60_errata[policy->cpu] && p4clockmod_table[i].frequency < 2000000)
+		else if (has_N60_errata[policy->cpu] && ((stock_freq * i)/8) < 2000000)
 			p4clockmod_table[i].frequency = CPUFREQ_ENTRY_INVALID;
 		else
 			p4clockmod_table[i].frequency = (stock_freq * i)/8;

--
