Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbVI2J7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVI2J7F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 05:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVI2J7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 05:59:05 -0400
Received: from aun.it.uu.se ([130.238.12.36]:65506 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751319AbVI2J7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 05:59:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17211.47810.521770.944105@alkaid.it.uu.se>
Date: Thu, 29 Sep 2005 11:58:26 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Jim McCloskey <mcclosk@ucsc.edu>,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH]CPUID workaround for intel CPU - Re: [PROBLEM] mtrr's not
	set, 2.6.13
In-Reply-To: <1127955751.4045.4.camel@linux-hp.sh.intel.com>
References: <1127955751.4045.4.camel@linux-hp.sh.intel.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li writes:
 > Hi Andrew,
 > This is patch to fix the Jim McCloskey's MTRR issue.
 > CPUID workaround for steppings 0F33h(supporting x86) and 0F34h(supporting x86
 > and EM64T). Detail info can be found at:
 > http://download.intel.com/design/Xeon/specupdt/30240216.pdf
 > http://download.intel.com/design/Pentium4/specupdt/30235221.pdf
 > 
 > Signed-off-by: Shaohua Li<shaohua.li@intel.com>
 > ---
 > 
 >  linux-2.6.14-rc2-root/arch/i386/kernel/cpu/mtrr/main.c |    8 ++++++++
 >  linux-2.6.14-rc2-root/arch/x86_64/kernel/setup.c       |    6 ++++++
 >  2 files changed, 14 insertions(+)
 > 
 > diff -puN arch/i386/kernel/cpu/mtrr/main.c~cpuid_errta arch/i386/kernel/cpu/mtrr/main.c
 > --- linux-2.6.14-rc2/arch/i386/kernel/cpu/mtrr/main.c~cpuid_errta	2005-09-29 08:35:34.000000000 +0800
 > +++ linux-2.6.14-rc2-root/arch/i386/kernel/cpu/mtrr/main.c	2005-09-29 08:37:16.000000000 +0800
 > @@ -626,6 +626,14 @@ void __init mtrr_bp_init(void)
 >  		if (cpuid_eax(0x80000000) >= 0x80000008) {
 >  			u32 phys_addr;
 >  			phys_addr = cpuid_eax(0x80000008) & 0xff;
 > +			/* CPUID workaround for Intel 0F33/0F34 CPU */
 > +			if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
 > +			    boot_cpu_data.x86 == 0xF &&
 > +			    boot_cpu_data.x86_model == 0x3 &&
 > +			    (boot_cpu_data.x86_mask == 0x3 ||
 > +			     boot_cpu_data.x86_mask == 0x4))
 > +				phys_addr = 36;

Please change the comment to indicate the actual erratum number.
Something like "Work around P4 Erratum #<N>" should do.

/Mikael
