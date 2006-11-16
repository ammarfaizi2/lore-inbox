Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423859AbWKPMip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423859AbWKPMip (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 07:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423857AbWKPMip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 07:38:45 -0500
Received: from aun.it.uu.se ([130.238.12.36]:9159 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1423859AbWKPMio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 07:38:44 -0500
Date: Thu, 16 Nov 2006 13:38:36 +0100 (MET)
Message-Id: <200611161238.kAGCcaKD017608@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: jbeulich@novell.com, linux-acpi@intel.com
Subject: Re: [PATCH] avoid compiler warnings
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 16:47:59 +0000, Jan Beulich wrote:
> >>Pointers should not be casted to u32 as this results in compiler warnings
> >>on 64-bit platforms.
> >
> >NAK. Use "%p" for formatting pointers. No casts needed.
> 
> Indeed, how did I not see this... While at this, I saw that there were a few
> more instances that needed fixing (they weren't actively generating warnings
> because of the build settings).

Tested on x86-64 and i386, and it did kill the warnings w/o noticeable regressions.

However, for some reason (config settings?) you didn't fix the two cast warnings
in utdebug.c; the appended patch fixes them too.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.19-rc5/drivers/acpi/utilities/utdebug.c.~1~	2006-09-20 19:28:46.000000000 +0200
+++ linux-2.6.19-rc5/drivers/acpi/utilities/utdebug.c	2006-11-15 21:22:27.000000000 +0100
@@ -180,8 +180,8 @@ acpi_ut_debug_print(u32 requested_debug_
 	if (thread_id != acpi_gbl_prev_thread_id) {
 		if (ACPI_LV_THREADS & acpi_dbg_level) {
 			acpi_os_printf
-			    ("\n**** Context Switch from TID %X to TID %X ****\n\n",
-			     (u32) acpi_gbl_prev_thread_id, (u32) thread_id);
+			    ("\n**** Context Switch from TID %p to TID %p ****\n\n",
+			     acpi_gbl_prev_thread_id, thread_id);
 		}
 
 		acpi_gbl_prev_thread_id = thread_id;
