Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVLUNwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVLUNwL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 08:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVLUNwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 08:52:11 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:44480 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932417AbVLUNwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 08:52:09 -0500
Date: Wed, 21 Dec 2005 14:51:57 +0100
From: Voluspa <lista1@telia.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc6
Message-Id: <20051221145157.72887fa4.lista1@telia.com>
In-Reply-To: <Pine.LNX.4.64.0512202131000.4827@g5.osdl.org>
References: <20051221052101.1acb6cc4.lista1@telia.com>
	<Pine.LNX.4.64.0512202131000.4827@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005 21:33:28 -0800 (PST) Linus Torvalds wrote:
[...]
> But it might make sense to open a bugzilla entry so that it doesn't get 
> lost.

http://bugzilla.kernel.org/show_bug.cgi?id=5767

For anyone stumbling into this problem, lacking git experience, here's
a 1/10-revert patch that gives me back the former functionality. It
behaves exactly as in 2.6.14 with regards to C1 usage and thermal_zone
temperatures etc.

diff -Nur linux-2.6.15-rc6-clean/drivers/acpi/processor_idle.c linux-2.6.15-rc6-c1fix/drivers/acpi/processor_idle.c
--- linux-2.6.15-rc6-clean/drivers/acpi/processor_idle.c	2005-12-21 13:29:12.000000000 +0100
+++ linux-2.6.15-rc6-c1fix/drivers/acpi/processor_idle.c	2005-12-21 13:39:04.000000000 +0100
@@ -893,7 +893,7 @@
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
 		if (pr->power.states[i].valid) {
 			pr->power.count = i;
-			if (pr->power.states[i].type >= ACPI_STATE_C2)
+			if (pr->power.states[i].type >= ACPI_STATE_C1)
 				pr->flags.power = 1;
 		}
 	}

Mvh
Mats Johannesson
--
