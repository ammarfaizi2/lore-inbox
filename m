Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTFAHVi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 03:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbTFAHVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 03:21:38 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:60545
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261566AbTFAHVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 03:21:37 -0400
Date: Sun, 1 Jun 2003 03:23:24 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Con Kolivas <kernel@kolivas.org>
cc: Paul P Komkoff Jr <i@stingr.net>, "" <linux-kernel@vger.kernel.org>
Subject: Re: ACPI interrupt storm (was Re: Linux 2.4.21rc6-ac1)
In-Reply-To: <200306011731.04743.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.50.0306010322290.2614-100000@montezuma.mastecende.com>
References: <200305311153.h4VBrNi21640@devserv.devel.redhat.com>
 <3ED9158E.2080904@xss.co.at> <20030601072329.GB6067@stingr.net>
 <200306011731.04743.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jun 2003, Con Kolivas wrote:

> I get the same problem here with acpi-20030522 applied to rc6
> P4 2.53 on an i845 mobo (P4PE).

I think it could be the Bus Mastering event monitoring thing, can you 
shoehorn this (HACK HACK) patch into 2.4?

Index: linux-2.5.70-mm1/drivers/acpi/processor.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.70/drivers/acpi/processor.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 processor.c
--- linux-2.5.70-mm1/drivers/acpi/processor.c	27 May 2003 02:19:28 -0000	1.1.1.1
+++ linux-2.5.70-mm1/drivers/acpi/processor.c	29 May 2003 11:32:00 -0000
@@ -711,11 +711,13 @@ acpi_processor_get_power_info (
 		 * use this in our C3 policy.
 		 */
 		else {
+			goto done;
 			pr->power.states[ACPI_STATE_C3].valid = 1;
 			pr->power.states[ACPI_STATE_C3].latency_ticks = 
 				US_TO_PM_TIMER_TICKS(acpi_fadt.plvl3_lat);
 			pr->flags.bm_check = 1;
 		}
+		done:
 	}
 
 	/*
-- 
function.linuxpower.ca
