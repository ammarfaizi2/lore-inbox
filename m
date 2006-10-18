Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWJRLoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWJRLoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 07:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWJRLoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 07:44:39 -0400
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:14064 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1030236AbWJRLoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 07:44:39 -0400
Message-ID: <45361861.3060706@in.ibm.com>
Date: Wed, 18 Oct 2006 17:34:49 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [PATCH] 2.6.19-rc1: Fix build breakage with CONFIG_PPC32
References: <452F6838.6090605@in.ibm.com> <17715.3265.870339.317367@cargo.ozlabs.ibm.com>
In-Reply-To: <17715.3265.870339.317367@cargo.ozlabs.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------030204030002000701000703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030204030002000701000703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Paul Mackerras wrote:
> Srinivasa Ds writes:
>
>   
>> arch/powerpc/platforms/built-in.o: In function `flush_disable_caches':
>> (.text+0x96d4): undefined reference to `low_cpu_die'
>> ======================================================
>> low_cpu_die() is defined under  CONFIG_PM || CONFIG_CPU_FREQ_PMAC  
>> options ,but while calling this function ,no care has been to taken to 
>> check these options. So please apply this fix,which solves the problem.
>>     
>
> Nack.  The correct fix is to adjust the ifdefs in sleep.S to make
> low_cpu_die available.  Otherwise it won't be possible to off-line
> CPUs properly.
>   
So resending the patch, by adjusting ifdefs in sleep.S
Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>

> Paul.
>   


--------------030204030002000701000703
Content-Type: text/plain;
 name="low_cpu_die.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="low_cpu_die.fix"

---
 arch/powerpc/platforms/powermac/sleep.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.19-rc2/arch/powerpc/platforms/powermac/sleep.S
===================================================================
--- linux-2.6.19-rc2.orig/arch/powerpc/platforms/powermac/sleep.S
+++ linux-2.6.19-rc2/arch/powerpc/platforms/powermac/sleep.S
@@ -45,7 +45,7 @@
 	.section .text
 	.align	5
 
-#if defined(CONFIG_PM) || defined(CONFIG_CPU_FREQ_PMAC)
+#if defined(CONFIG_PM) || defined(CONFIG_CPU_FREQ_PMAC) || (defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC32))
 
 /* This gets called by via-pmu.c late during the sleep process.
  * The PMU was already send the sleep command and will shut us down

--------------030204030002000701000703--
