Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWDLSDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWDLSDc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 14:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWDLSDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 14:03:32 -0400
Received: from xenotime.net ([66.160.160.81]:14789 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932302AbWDLSDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 14:03:32 -0400
Date: Wed, 12 Apr 2006 11:05:57 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, minyard@mvista.com
Subject: [PATCH] IPMI: fix devinit placement
Message-Id: <20060412110557.dc03c0f8.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

gcc complains about __devinit in the wrong location:
drivers/char/ipmi/ipmi_si_intf.c:2205: warning: '__section__' attribute does not apply to types

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/char/ipmi/ipmi_si_intf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2617-rc1g5.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2617-rc1g5/drivers/char/ipmi/ipmi_si_intf.c
@@ -2198,11 +2198,11 @@ static inline void wait_for_timer_and_th
 	}
 }
 
-static struct ipmi_default_vals
+static __devinit struct ipmi_default_vals
 {
 	int type;
 	int port;
-} __devinit ipmi_defaults[] =
+} ipmi_defaults[] =
 {
 	{ .type = SI_KCS, .port = 0xca2 },
 	{ .type = SI_SMIC, .port = 0xca9 },


---
