Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVHIPno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVHIPno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 11:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVHIPno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 11:43:44 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:58602 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964826AbVHIPno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 11:43:44 -0400
Subject: dmi_table counting in ipmi_si_intf.c
From: Vernon Mauery <vernux@us.ibm.com>
To: Corey Minyard <minyard@mvista.com>
Cc: Rusty Russell <trivial@rustcorp.com.au>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 09 Aug 2005 16:43:17 -0700
Message-Id: <1123630997.3246.18.camel@bluecow>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on getting one of the IBM blades to use ipmi and have run
into a problem.  The driver doesn't load because it says it can't find
the device.

dmidecode shows that there are 39 entries and that the last one is the
BMC.  I looked into dmi_table and noticed that it parses the table by
length and by number of entries.  But I found that it goes from i=1 to
i<num.  This causes it to skip the last entry in the table.  Is there a
reason it is i=1 instead of i=0?  or for that matter i<num instead of
i<=num?

Ensure that all dmi table entries get parsed.

Signed-off-by: Vernon Mauery <vernux@us.ibm.com>
---

diff -uar a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
--- a/drivers/char/ipmi/ipmi_si_intf.c	2005-08-09 08:11:41.000000000 -0700
+++ b/drivers/char/ipmi/ipmi_si_intf.c	2005-08-09 08:12:51.000000000 -0700
@@ -1690,7 +1690,7 @@ static int dmi_table(u32 base, int len, 
 	u8 		  __iomem *buf;
 	struct dmi_header __iomem *dm;
 	u8 		  __iomem *data;
-	int 		  i=1;
+	int 		  i=0;
 	int		  status=-1;
 	int               intf_num = 0;
 


