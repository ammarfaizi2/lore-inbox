Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbTEEVHL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 17:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbTEEVHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 17:07:11 -0400
Received: from [12.47.58.20] ([12.47.58.20]:9940 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261275AbTEEVHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 17:07:10 -0400
Date: Mon, 5 May 2003 14:16:01 -0700
From: Andrew Morton <akpm@digeo.com>
To: Nicolas <linux@1g6.biz>
Cc: linux-kernel@vger.kernel.org, "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: oops 2.5.68 ohci1394/ IRQ/acpi
Message-Id: <20030505141601.7537365a.akpm@digeo.com>
In-Reply-To: <200305051350.41340.linux@1g6.biz>
References: <200305051350.41340.linux@1g6.biz>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 May 2003 21:19:34.0127 (UTC) FILETIME=[065657F0:01C3134C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas <linux@1g6.biz> wrote:
>
> 
> May  5 13:36:56 hal9003 kernel: irq 9: nobody cared!
> ...
> May  5 13:36:56 hal9003 kernel: handlers:
> May  5 13:36:56 hal9003 kernel: [acpi_irq+0/17] (acpi_irq+0x0/0x11)
> May  5 13:36:56 hal9003 kernel: [<c01c1ff0>] (acpi_irq+0x0/0x11)

Look like the ACPI IRQ handler isn't returning an appropriate value.

Can you test this patch?

diff -puN drivers/acpi/osl.c~acpi-irq-ret-fix drivers/acpi/osl.c
--- 25/drivers/acpi/osl.c~acpi-irq-ret-fix	Mon May  5 14:14:24 2003
+++ 25-akpm/drivers/acpi/osl.c	Mon May  5 14:14:38 2003
@@ -237,7 +237,7 @@ acpi_os_table_override (struct acpi_tabl
 static irqreturn_t
 acpi_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
-	return (*acpi_irq_handler)(acpi_irq_context);
+	return (*acpi_irq_handler)(acpi_irq_context) ? IRQ_HANDLED : IRQ_NONE;
 }
 
 acpi_status

_

