Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265913AbTFVVXT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 17:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265926AbTFVVXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 17:23:19 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:7165 "EHLO
	sccrmhc12.attbi.com") by vger.kernel.org with ESMTP id S265913AbTFVVXJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 17:23:09 -0400
Message-ID: <3EF62189.1020105@mvista.com>
Date: Sun, 22 Jun 2003 16:37:13 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>, Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Corey Minyard <minyard@mvista.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.4 patch] fix IPMI compile with new ACPI
References: <20030621235417.GH23337@fs.tum.de>
In-Reply-To: <20030621235417.GH23337@fs.tum.de>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cool, they've fixed the ACPI stuff.  It looks good, please apply.

-Corey

Adrian Bunk wrote:

>The patch below fixes the compilation of ipmi_kcs_intf.c in 2.4.22-pre1.
>
>The changes are:
>- remove two now unneeded includes (since the files moved there was a 
>  compile error, but they are indirectly included via linux/acpi.h)
>- remove unneeded COMPILER_DEPENDENT_UINT64; besides that it's
>  unneeded it was wrong on 32 bit architectures
>- s/acpi_table_header/struct acpi_table_header/
>
>-ac contains a similar patch that differs because it also adds 
>#include's for acpi/acpi.h and acpi/actypes.h (indirectly included via 
>linux/acpi.h).
>
>cu
>Adrian
>
>--- linux-2.4.22-pre1-full/drivers/char/ipmi/ipmi_kcs_intf.c.old	2003-06-22 01:28:28.000000000 +0200
>+++ linux-2.4.22-pre1-full/drivers/char/ipmi/ipmi_kcs_intf.c	2003-06-22 01:40:12.000000000 +0200
>@@ -1031,10 +1031,6 @@
>    from Hewlett-Packard simple bmc.c, a GPL KCS driver. */
> 
> #include <linux/acpi.h>
>-/* A real hack, but everything's not there yet in 2.4. */
>-#define COMPILER_DEPENDENT_UINT64 unsigned long
>-#include <../drivers/acpi/include/acpi.h>
>-#include <../drivers/acpi/include/actypes.h>
> 
> struct SPMITable {
> 	s8	Signature[4];
>@@ -1059,7 +1055,7 @@
> static unsigned long acpi_find_bmc(void)
> {
> 	acpi_status       status;
>-	acpi_table_header *spmi;
>+	struct acpi_table_header *spmi;
> 	static unsigned long io_base = 0;
> 
> 	if (io_base != 0)
>
>
>  
>


