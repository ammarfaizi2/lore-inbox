Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWGQQmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWGQQmI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWGQQcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:14267 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750963AbWGQQcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:39 -0400
Date: Mon, 17 Jul 2006 09:25:39 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Andi Kleen <ak@suse.de>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 03/45] x86_64: Fix modular pc speaker
Message-ID: <20060717162539.GD4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="x86_64-fix-modular-pc-speaker.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
It turned out that the following change is needed when the speaker is
compiled as a module.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/x86_64/kernel/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.2.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.17.2/arch/x86_64/kernel/setup.c
@@ -1440,7 +1440,7 @@ struct seq_operations cpuinfo_op = {
 	.show =	show_cpuinfo,
 };
 
-#ifdef CONFIG_INPUT_PCSPKR
+#if defined(CONFIG_INPUT_PCSPKR) || defined(CONFIG_INPUT_PCSPKR_MODULE)
 #include <linux/platform_device.h>
 static __init int add_pcspkr(void)
 {

--
