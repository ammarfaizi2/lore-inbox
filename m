Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTEDQLY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 12:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTEDQLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 12:11:24 -0400
Received: from camus.xss.co.at ([194.152.162.19]:61454 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S263646AbTEDQLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 12:11:23 -0400
Message-ID: <3EB53E8E.7030003@xss.co.at>
Date: Sun, 04 May 2003 18:23:42 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org, minyard@mvista.com
Subject: Re: Linux 2.4.21rc1-ac4
References: <200305031744.h43Hijh07694@devserv.devel.redhat.com>
In-Reply-To: <200305031744.h43Hijh07694@devserv.devel.redhat.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The following patch fixes compile problems in ipmi_kcs_intf.c
due to ACPI changes introduced in 2.4.21-rc1-ac3

Note: this just fixes compilation errors, I don't know
if there are also semantic problems with the new ACPI code
and the IPMI driver as I don't use it. Please check...

--- linux-2.4.21-rc1-ac4/drivers/char/ipmi/ipmi_kcs_intf.c.orig Sun May  4 11:00:02 2003
+++ linux-2.4.21-rc1-ac4/drivers/char/ipmi/ipmi_kcs_intf.c      Sun May  4 11:00:45 2003
@@ -1031,9 +1031,8 @@
    from Hewlett-Packard simple bmc.c, a GPL KCS driver. */

 #include <linux/acpi.h>
-/* A real hack, but everything's not there yet in 2.4. */
-#include <../drivers/acpi/include/acpi.h>
-#include <../drivers/acpi/include/actypes.h>
+#include <acpi/actbl.h>
+#include <acpi/actypes.h>

 struct SPMITable {
        s8      Signature[4];
@@ -1058,7 +1057,7 @@
 static unsigned long acpi_find_bmc(void)
 {
        acpi_status       status;
-       acpi_table_header *spmi;
+       struct acpi_table_header *spmi;
        static unsigned long io_base = 0;

        if (io_base != 0)

Regards

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71

