Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbTBLMn2>; Wed, 12 Feb 2003 07:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267065AbTBLMn2>; Wed, 12 Feb 2003 07:43:28 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:35352
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267059AbTBLMn1>; Wed, 12 Feb 2003 07:43:27 -0500
Date: Wed, 12 Feb 2003 07:52:03 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: VMWare monitor error on read/modify/write to cr4
Message-ID: <Pine.LNX.4.50.0302120743430.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Current 2.5.60 has code which disables TSC access for tasks 
running in lower privelege level than ring0 when disabling kernel TSC 
usage. Doing a read, modify, write with only the TSD bit being set causes 
it to report a monitor error. This happens before console_init so it hangs 
on 'Uncompressing Linux... Ok booting the kernel'

To reproduce, build a 2.5.60 i586+ kernel and boot with notsc.

if (tsc_disable && cpu_has_tsc) {
	printk(KERN_NOTICE "Disabling TSC...\n");
	/**** FIX-HPA: DOES THIS REALLY BELONG HERE? ****/
	clear_bit(X86_FEATURE_TSC, boot_cpu_data.x86_capability);
	set_in_cr4(X86_CR4_TSD);
}

This isn't a bug report, just an FYI for people using VMWare, and the TSC 
in vmware does work.

	Zwane
-- 
function.linuxpower.ca
