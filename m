Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbUKMWOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUKMWOa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 17:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUKMWOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 17:14:30 -0500
Received: from fsmlabs.com ([168.103.115.128]:65409 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S261185AbUKMWOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 17:14:11 -0500
Date: Sat, 13 Nov 2004 15:13:57 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Stas Sergeev <stsp@aknet.ru>
cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-mm5
In-Reply-To: <41967669.3070707@aknet.ru>
Message-ID: <Pine.LNX.4.61.0411131504360.4183@musoma.fsmlabs.com>
References: <41967669.3070707@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2004, Stas Sergeev wrote:

> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/
> Here are the few new problems that
> I've got:
> 
> 1. Local APIC stopped working. I know
> I have to add "lapic" to the command-line,
> but now this doesn't help (in -mm4 either
> I think). dmesg says:
> ---
> Kernel command line: ro root=/dev/hdc2 apm=power-off lapic nmi_watchdog=1
> ...
> Local APIC not detected. Using dummy APIC emulation.
> ---
> Is this known? Any other command-line option
> to enable it again?

Could you please apply the following patch and supply full dmesg?

Thanks.

Index: linux-2.6.10-rc1-mm5/arch/i386/kernel/apic.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm5/arch/i386/kernel/apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 apic.c
--- linux-2.6.10-rc1-mm5/arch/i386/kernel/apic.c	11 Nov 2004 17:24:27 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm5/arch/i386/kernel/apic.c	13 Nov 2004 22:12:39 -0000
@@ -733,8 +733,10 @@ static int __init detect_init_APIC (void
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
 	/* Disabled by kernel option? */
-	if (enable_local_apic < 0)
+	if (enable_local_apic < 0) {
+		printk("%s:%d\n", __FILE__, __LINE__);
 		return -1;
+	}
 
 	/* Workaround for us being called before identify_cpu(). */
 	get_cpu_vendor(&boot_cpu_data);
@@ -760,6 +762,7 @@ static int __init detect_init_APIC (void
 		 * APIC only if "lapic" specified.
 		 */
 		if (enable_local_apic <= 0) {
+	                printk("%s:%d\n", __FILE__, __LINE__);
 			apic_printk(APIC_VERBOSE,
 				    "Local APIC disabled by BIOS -- "
 				    "you can enable it with \"lapic\"\n");
