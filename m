Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUBREnW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbUBREnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:43:21 -0500
Received: from elesy.tomsk.su ([217.18.140.178]:35476 "EHLO elesy.tomsk.su")
	by vger.kernel.org with ESMTP id S263475AbUBREnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:43:19 -0500
Date: Wed, 18 Feb 2004 10:42:16 +0600
From: Alexey Shinkin <alex@elesy.tusur.ru>
X-Mailer: The Bat! (v1.62r) Business
Reply-To: Alexey Shinkin <alex@elesy.tusur.ru>
Organization: ElesyTUSUR
X-Priority: 3 (Normal)
Message-ID: <1501881750.20040218104216@elesy.tusur.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 doesn't recognize some Cyrix Cpus ?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

I am playing with Linux 2.6.0 on a PC-104 board with 
ZFx86 CPU - it is Cyrix core based 486. Kernel 2.4.18 detects the CPU
as Cyrix Cx486DX2, but 2.6.0 says it is 486.

I looked through /arch/i386/kernel/setup.c in 2.4.18 sources,
/arch/i386/kernel/cpu/common.c in 2.6.0 sources and found the
identify_cpu() function that seems to be working a bit incorrectly in
2.6.0.

In 2.4.18 it checks if the CPU able to execute CPUID , if cannot - the
id_and_try_enable_cpuid() is called, which identifies old Cyrixes and
tries to turn on CPUID on some of them. Even if the CPU is not
CPUID-capable,Cyrix is detected by test_cyrix_52div(), at least, the
function fills x86_vendor & x86_vendorid fields in for Cyrixes. The
fields are used later for vendor-specific initialization.

In 2.6.0 identify_cpu() does not check CPUID-uncapable CPUs by
test_cyrix_52div() and
doesnt try to enable CPUID on them, so , further generic_identify()
considers my CPU as usual 486, doesnt find vendor in get_cpu_vendor
and after all default CPU init procedure is performed instead of
vendor-specific.

I understand that now people are more focused on newest P4's,
Athlons64 etc , but I think that support for old CPUs also shouldnt be
broken...


-- 
Best regards,
Alex Shinkin

