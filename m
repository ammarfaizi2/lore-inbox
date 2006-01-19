Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161300AbWASJyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161300AbWASJyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161298AbWASJyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:54:04 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:3503 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1161296AbWASJyC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:54:02 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Dave Jones <davej@redhat.com>, pfg@sgi.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org
Subject: Re: [2.6 patch] drivers/sn/ must be entered for CONFIG_SGI_IOC3
References: <20060117235521.GA14298@redhat.com>
	<20060119032423.GI19398@stusta.de>
From: Jes Sorensen <jes@sgi.com>
Date: 19 Jan 2006 04:54:00 -0500
In-Reply-To: <20060119032423.GI19398@stusta.de>
Message-ID: <yq0vewg7dc7.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Adrian" == Adrian Bunk <bunk@stusta.de> writes:

Adrian> On Tue, Jan 17, 2006 at 06:55:21PM -0500, Dave Jones wrote:
>> kernel/drivers/serial/ioc3_serial.ko needs unknown symbol
>> ioc3_unregister_submodule
>> 
>> CONFIG_SERIAL_SGI_IOC3=m CONFIG_SGI_IOC3=m

Adrian> The untested patch below should fix it.

Actually I think this is more appropriate so we don't end up with 17
cases that add drivers/sn to the build lib.

Dave, does this solve the problem?

Cheers,
Jes

Include drivers/sn when CONFIG_IA64_SGI_SN2 or CONFIG_IA64_GENERIC
is enabled.

Signed-off-by: Jes Sorensen <jes@sgi.com>
----

 arch/ia64/Kconfig |    3 +++
 drivers/Makefile  |    2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/ia64/Kconfig
===================================================================
--- linux-2.6.orig/arch/ia64/Kconfig
+++ linux-2.6/arch/ia64/Kconfig
@@ -374,6 +374,9 @@
 	  To use this option, you have to ensure that the "/proc file system
 	  support" (CONFIG_PROC_FS) is enabled, too.
 
+config SGI_SN
+	def_bool y if (IA64_SGI_SN2 || IA64_GENERIC)
+
 source "drivers/firmware/Kconfig"
 
 source "fs/Kconfig.binfmt"
Index: linux-2.6/drivers/Makefile
===================================================================
--- linux-2.6.orig/drivers/Makefile
+++ linux-2.6/drivers/Makefile
@@ -69,7 +69,7 @@
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_MMC)		+= mmc/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
-obj-$(CONFIG_SGI_IOC4)		+= sn/
+obj-$(CONFIG_SGI_SN)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
