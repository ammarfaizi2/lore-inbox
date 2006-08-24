Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422732AbWHXVuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422732AbWHXVuB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422735AbWHXVuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:50:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:25618 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422732AbWHXVt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:49:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=AbaNinM//MPaDBI6aeX5qHAjWz3jLuq2kDfpjC6fRNBxUnVHB9LlBfpSZy2Ia2sYsDi0Cmw7wecunga2f0kGC3GsZEZedSpdmtEXXTUlJQ6QyK3aBjOTdKOeo4eyGa0gxj5mNVd7suW9Oava/w1Pgm6DDEPsh2qI/SspYfFkfNg=
Date: Fri, 25 Aug 2006 01:49:51 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: [PATCH 2/2] asus_acpi: don't printk on writing garbage to proc files
Message-ID: <20060824214951.GB5204@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* This reporting is useless (you get errno anyway).
* This reporting is already inconsistent in driver.
* Looks like created files in proc are rw-rw-rw- by default.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/acpi/asus_acpi.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -617,9 +617,7 @@ proc_write_ledd(struct file *file, const
 			       "Asus ACPI: LED display write failed\n");
 		else
 			hotk->ledd_status = (u32) value;
-	} else if (rv < 0)
-		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
-
+	}
 	return rv;
 }
 
@@ -837,10 +835,7 @@ proc_write_brn(struct file *file, const 
 		value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
 		/* 0 <= value <= 15 */
 		set_brightness(value);
-	} else if (rv < 0) {
-		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 	}
-
 	return rv;
 }
 
@@ -885,9 +880,6 @@ proc_write_disp(struct file *file, const
 	rv = parse_arg(buffer, count, &value);
 	if (rv > 0)
 		set_display(value);
-	else if (rv < 0)
-		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
-
 	return rv;
 }
 

