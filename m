Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVCOWG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVCOWG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVCOWFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:05:17 -0500
Received: from mail.suse.de ([195.135.220.2]:10977 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261920AbVCOWDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:03:33 -0500
Date: Tue, 15 Mar 2005 23:03:32 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] CONFIG_PM for ppc64, to allow sysrq o
Message-ID: <20050315220332.GA24708@suse.de>
References: <20050315212656.GA24563@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050315212656.GA24563@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Mar 15, Olaf Hering wrote:

> 
> For some weird reason, sysrq o is hidden behind CONFIG_PM.
> Why? One can power off just fine without that. Can pm_sysrq_init be
> moved to a better place? I think it used to be in sysrq.c in 2.4.
> 
> Too bad, with this patch radeonfb fails to compile.

After disabling radeon and this additional change, sysrq o powers off.
Just dont type too fast over hvc (ctrl o o)  ;)

Index: linux-2.6.11-olh/arch/ppc64/kernel/setup.c
===================================================================
--- linux-2.6.11-olh.orig/arch/ppc64/kernel/setup.c
+++ linux-2.6.11-olh/arch/ppc64/kernel/setup.c
@@ -31,6 +31,7 @@
 #include <linux/unistd.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
+#include <linux/pm.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/processor.h>
@@ -710,6 +711,8 @@ void machine_halt(void)
 
 EXPORT_SYMBOL(machine_halt);
 
+void (*pm_power_off)(void) = machine_power_off;
+
 unsigned long ppc_proc_freq;
 unsigned long ppc_tb_freq;
 
