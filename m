Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTEXWG1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 18:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbTEXWG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 18:06:26 -0400
Received: from ns.suse.de ([213.95.15.193]:49420 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261196AbTEXWGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 18:06:25 -0400
Date: Sun, 25 May 2003 00:19:33 +0200
From: Andi Kleen <ak@suse.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Andi Kleen <ak@suse.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make ACPI compile again on 64bit/gcc 3.3
Message-ID: <20030524221933.GA22506@wotan.suse.de>
References: <F760B14C9561B941B89469F59BA3A847E96ED2@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96ED2@orsmsx401.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 24, 2003 at 01:55:26PM -0700, Grover, Andrew wrote:
> Actually, I think osl.c should be changed to match the header as it
> stands. Could you try that and see if that also fixes things?

Yes it does of course.

BTW FYI these are the warnings I see in ACPI when compiling with gcc 3.3 for
64bit:

drivers/acpi/processor.c: In function `acpi_processor_add_fs':
drivers/acpi/processor.c:1518: warning: assignment from incompatible pointer typ e
drivers/acpi/processor.c:1531: warning: assignment from incompatible pointer typ e
drivers/acpi/thermal.c:187: warning: initialization from incompatible pointer ty pe
drivers/acpi/thermal.c:195: warning: initialization from incompatible pointer ty poe
  drivers/acpi/thermal.c:203: warning: initialization from incompatible pointer type
drivers/acpi/utils.c: In function `acpi_evaluate_reference':
drivers/acpi/utils.c:351: warning: unsigned int format, different type arg (arg 
5)

-Andi


Index: linux/drivers/acpi/osl.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/acpi/osl.c,v
retrieving revision 1.27
diff -u -u -r1.27 osl.c
--- linux/drivers/acpi/osl.c	24 May 2003 01:49:28 -0000	1.27
+++ linux/drivers/acpi/osl.c	24 May 2003 21:12:05 -0000
@@ -952,14 +952,14 @@
  * We just have to assume we're dealing with valid memory
  */
 
-BOOLEAN
-acpi_os_readable(void *ptr, u32 len)
+u8
+acpi_os_readable(void *ptr, acpi_size len)
 {
 	return 1;
 }
 
-BOOLEAN
-acpi_os_writable(void *ptr, u32 len)
+u8
+acpi_os_writable(void *ptr, acpi_size len)
 {
 	return 1;
 }
> 
