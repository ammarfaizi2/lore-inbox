Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWCYGti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWCYGti (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 01:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWCYGti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 01:49:38 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:30676
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750807AbWCYGth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 01:49:37 -0500
Date: Fri, 24 Mar 2006 22:48:51 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, torvalds@osdl.org,
       Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk,
       ospite@studenti.unina.it, davej@codemonkey.org.uk
Subject: [patch 21/20] Fix speedstep-smi assembly bug in speedstep_smi_ownership
Message-ID: <20060325064851.GA23474@kroah.com>
References: <20060325042556.GA21260@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more last minute patch...

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Andrew Morton <akpm@osdl.org>

Fix bug identified by Linus Torvalds <torvalds@osdl.org>: the `out'
instruction depends upon the state of memory_data[], so we need to tell gcc
that before executing it. (The opcode, not gcc).

Fixes http://bugzilla.kernel.org/show_bug.cgi?id=5553

Thanks to Antonio Ospite <ospite@studenti.unina.it> for testing.

Cc: Dave Jones <davej@codemonkey.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 arch/i386/kernel/cpu/cpufreq/speedstep-smi.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/cpu/cpufreq/speedstep-smi.c~cpufreq-speedstep-smi-asm-fix arch/i386/kernel/cpu/cpufreq/speedstep-smi.c
--- devel/arch/i386/kernel/cpu/cpufreq/speedstep-smi.c~cpufreq-speedstep-smi-asm-fix	2006-03-24 10:35:45.000000000 -0800
+++ devel-akpm/arch/i386/kernel/cpu/cpufreq/speedstep-smi.c	2006-03-24 10:36:07.000000000 -0800
@@ -75,7 +75,9 @@ static int speedstep_smi_ownership (void
 	__asm__ __volatile__(
 		"out %%al, (%%dx)\n"
 		: "=D" (result)
-		: "a" (command), "b" (function), "c" (0), "d" (smi_port), "D" (0), "S" (magic)
+		: "a" (command), "b" (function), "c" (0), "d" (smi_port),
+			"D" (0), "S" (magic)
+		: "memory"
 	);
 
 	dprintk("result is %x\n", result);
_

