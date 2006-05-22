Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWEVRPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWEVRPg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWEVRPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:15:36 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:15886 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751016AbWEVRPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:15:35 -0400
Message-ID: <4471F1B7.7020203@vmware.com>
Date: Mon, 22 May 2006 10:15:35 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arturzaprzala@ownmail.net, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] Fix typo in arch/i386/power/cpu.c
Content-Type: multipart/mixed;
 boundary="------------090500010408000309050202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090500010408000309050202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix a typo which caused us to corrupt CR2 (not likely a problem) and 
fail to restore CR0 (potentially a problem on APM systems, since TS/EM 
bits might be lost) after suspend.

--------------090500010408000309050202
Content-Type: text/plain;
 name="i386-bogus-cr2-assignement"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-bogus-cr2-assignement"

Fix a typo in suspend code noticed by Artur Zaprzala.  I'm unsure if this
actually causes a bug in practice, since the ACPI wakeup code also restores
CR0, and the APM code returns to protected mode, but the fix is obviously much
better.

Signed-off-by: Zachary Amsden <zach@vmware.com>


Index: linux-2.6.17-rc/arch/i386/power/cpu.c
===================================================================
--- linux-2.6.17-rc.orig/arch/i386/power/cpu.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.17-rc/arch/i386/power/cpu.c	2006-05-22 09:50:50.000000000 -0700
@@ -92,7 +92,7 @@ void __restore_processor_state(struct sa
 	write_cr4(ctxt->cr4);
 	write_cr3(ctxt->cr3);
 	write_cr2(ctxt->cr2);
-	write_cr2(ctxt->cr0);
+	write_cr0(ctxt->cr0);
 
 	/*
 	 * now restore the descriptor tables to their proper values

--------------090500010408000309050202--
