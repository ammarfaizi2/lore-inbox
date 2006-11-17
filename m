Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755836AbWKQThw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836AbWKQThw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755832AbWKQThw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:37:52 -0500
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:23515 "EHLO
	aa014msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1755836AbWKQThv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:37:51 -0500
Date: Fri, 17 Nov 2006 20:37:49 +0100
From: Mattia Dongili <malattia@linux.it>
To: alex1000@comcast.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error compiling 2.6.19rc[56]
Message-ID: <20061117193749.GC12979@inferi.kami.home>
Mail-Followup-To: alex1000@comcast.net, linux-kernel@vger.kernel.org
References: <111720061810.16287.455DFAF8000E320600003F9F2207021573CFCFCFCE980A040E@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <111720061810.16287.455DFAF8000E320600003F9F2207021573CFCFCFCE980A040E@comcast.net>
X-Operating-System: Linux 2.6.19-rc5-mm2-1 i686
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 06:10:01PM +0000, alex1000@comcast.net wrote:
> I get the following error when attempting to compile 2.6.19rc[56]
> 
> drivers/built-in.o(.text+0x7ef32): In function `powersave_bias_target':
> : undefined reference to `cpufreq_frequency_table_target'
> drivers/built-in.o(.text+0x7ef7d): In function `powersave_bias_target':
> : undefined reference to `cpufreq_frequency_table_target'
> drivers/built-in.o(.text+0x7efb3): In function `powersave_bias_target':
> : undefined reference to `cpufreq_frequency_table_target'
> drivers/built-in.o(.text+0x7f056): In function `ondemand_powersave_bias_init':
> : undefined reference to `cpufreq_frequency_get_table'
> make: *** [.tmp_vmlinux1] Error 1

I just sent this to the CPUFreq mailing list.

Allow CONFIG_CPU_FREQ_GOV_ONDEMAND=y

Signed-off-by: Mattia Dongili <malattia@linux.it>
---

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 2cc71b6..491779a 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -107,6 +107,7 @@ config CPU_FREQ_GOV_USERSPACE
 
 config CPU_FREQ_GOV_ONDEMAND
 	tristate "'ondemand' cpufreq policy governor"
+	select CPU_FREQ_TABLE
 	help
 	  'ondemand' - This driver adds a dynamic cpufreq policy governor.
 	  The governor does a periodic polling and 
