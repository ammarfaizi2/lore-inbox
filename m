Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268238AbUJDPqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268238AbUJDPqd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 11:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268253AbUJDPol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 11:44:41 -0400
Received: from plim.fujitsu-siemens.com ([217.115.66.8]:1332 "EHLO
	plim.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S268240AbUJDPmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 11:42:47 -0400
Message-ID: <41617BD8.3000907@fujitsu-siemens.com>
Date: Mon, 04 Oct 2004 18:35:36 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] skip sync_arb_IDs on P4/Xeon
Content-Type: multipart/mixed;
 boundary="------------070801090709070205060909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070801090709070205060909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I recently came across an Intel statement saying that the "INIT Level 
deassert" IPI used by sync_arb_IDs() (arch/i386/kernel/apic.c) should 
not be used on P4 and Xeon which don't have APIC bus arbitration anyway.

See Intel IA32 architecture software developers manual vol. 3, 8.6.1 
(p.8-23), 8.7 (p. 8.31).

The patch below skips the unsupported IPI on P4/Xeon.

The same thing should probably be done for x86_64.

Regards,
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy


--------------070801090709070205060909
Content-Type: text/x-patch;
 name="sync_Arb_IDs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sync_Arb_IDs.diff"

--- arch/i386/kernel/apic.c.orig	2004-10-04 14:54:27.000000000 +0200
+++ arch/i386/kernel/apic.c	2004-10-04 14:56:20.000000000 +0200
@@ -269,6 +269,9 @@ int __init verify_local_APIC(void)
 
 void __init sync_Arb_IDs(void)
 {
+	/* Unsupported on P4 - see Intel Dev. Manual Vol. 3, Ch. 8.6.1 */
+	if (boot_cpu_data.x86 == 15)
+		return;
 	/*
 	 * Wait for idle.
 	 */

--------------070801090709070205060909--
