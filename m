Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWDDRhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWDDRhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 13:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWDDRhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 13:37:18 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:3341 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750771AbWDDRhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 13:37:17 -0400
Message-ID: <4432AB57.1040006@vmware.com>
Date: Tue, 04 Apr 2006 10:22:31 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com, rdunlap@xenotime.net, fastboot@osdl.org
Subject: Re: 2.6.17-rc1-mm1: KEXEC became SMP-only
References: <20060404014504.564bf45a.akpm@osdl.org> <20060404162921.GK6529@stusta.de>
In-Reply-To: <20060404162921.GK6529@stusta.de>
Content-Type: multipart/mixed;
 boundary="------------040706000709010304070503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040706000709010304070503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> On Tue, Apr 04, 2006 at 01:45:04AM -0700, Andrew Morton wrote:
>   
>> ...
>> Changes since 2.6.16-mm2:
>> ...
>> +x86-clean-up-subarch-definitions.patch
>> ...
>>  x86 updates.
>> ...
>>     
>
> The following looks bogus:
>
>  config KEXEC
>         bool "kexec system call (EXPERIMENTAL)"
> -       depends on EXPERIMENTAL
> +       depends on EXPERIMENTAL && (!X86_VOYAGER && SMP)
>
> The dependencies do now say that KEXEC is only offered for machines that 
> are _both_ non-Voyager and SMP.
>
> Is the problem you wanted to express that a non-SMP Voyager config 
> didn't compile?
>   

Whoops, that should be

depends on EXPERIMENTAL && !(X86_VOYAGER && SMP)

Voyager SMP builds don't compile with kexec(), and it isn't clear how to 
shootdown CPUs using NMIs without an APIC.

--------------040706000709010304070503
Content-Type: text/plain;
 name="voyager-smp-bogosity"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="voyager-smp-bogosity"

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16.1/arch/i386/Kconfig
===================================================================
--- linux-2.6.16.1.orig/arch/i386/Kconfig	2006-04-03 12:37:11.000000000 -0700
+++ linux-2.6.16.1/arch/i386/Kconfig	2006-04-04 10:18:25.000000000 -0700
@@ -813,7 +813,7 @@ source kernel/Kconfig.hz
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && (!X86_VOYAGER && SMP)
+	depends on EXPERIMENTAL && !(X86_VOYAGER && SMP)
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot

--------------040706000709010304070503--
