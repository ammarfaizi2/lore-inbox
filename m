Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161454AbWJKVMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161454AbWJKVMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161447AbWJKVKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:10:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:56483 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161454AbWJKVJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:09:32 -0400
Date: Wed, 11 Oct 2006 14:09:00 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jim.cromie@gmail.com, johnstul@us.ibm.com,
       alexander.krause@erazor-zone.de, dzpost@dedekind.net,
       phelps@mantara.com, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 62/67] scx200_hrt: fix precedence bug manifesting as 27x clock in 1 MHz mode
Message-ID: <20061011210900.GK16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="scx200_hrt-fix-precedence-bug-manifesting-as-27x-clock-in-1-mhz-mode.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jim Cromie <jim.cromie@gmail.com>

Fix paren-placement / precedence bug breaking initialization for 1 MHz
clock mode.

Also fix comment spelling error, and fence-post (off-by-one) error on
symbol used in request_region.

Addresses http://bugzilla.kernel.org/show_bug.cgi?id=7242

Thanks alexander.krause@erazor-zone.de, dzpost@dedekind.net, for the
reports and patch test, and phelps@mantara.com for the independent patch
and verification.

Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>
Cc: <alexander.krause@erazor-zone.de>
Cc: <dzpost@dedekind.net>
Cc: <phelps@mantara.com>
Acked-by: John Stultz <johnstul@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/clocksource/scx200_hrt.c |    4 ++--
 include/linux/scx200.h           |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.18.orig/drivers/clocksource/scx200_hrt.c
+++ linux-2.6.18/drivers/clocksource/scx200_hrt.c
@@ -63,7 +63,7 @@ static struct clocksource cs_hrt = {
 
 static int __init init_hrt_clocksource(void)
 {
-	/* Make sure scx200 has initializedd the configuration block */
+	/* Make sure scx200 has initialized the configuration block */
 	if (!scx200_cb_present())
 		return -ENODEV;
 
@@ -76,7 +76,7 @@ static int __init init_hrt_clocksource(v
 	}
 
 	/* write timer config */
-	outb(HR_TMEN | (mhz27) ? HR_TMCLKSEL : 0,
+	outb(HR_TMEN | (mhz27 ? HR_TMCLKSEL : 0),
 	     scx200_cb_base + SCx200_TMCNFG_OFFSET);
 
 	if (mhz27) {
--- linux-2.6.18.orig/include/linux/scx200.h
+++ linux-2.6.18/include/linux/scx200.h
@@ -32,7 +32,7 @@ extern unsigned scx200_cb_base;
 
 /* High Resolution Timer */
 #define SCx200_TIMER_OFFSET 0x08
-#define SCx200_TIMER_SIZE 0x05
+#define SCx200_TIMER_SIZE 0x06
 
 /* Clock Generators */
 #define SCx200_CLOCKGEN_OFFSET 0x10

--
