Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbUKKASi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbUKKASi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 19:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbUKKASi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 19:18:38 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:31753 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262070AbUKKASP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 19:18:15 -0500
Message-ID: <4192AFDD.3000005@conectiva.com.br>
Date: Wed, 10 Nov 2004 22:18:37 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix  platform_rename_gsi related ia32 build breakage
References: <4192A959.9020806@conectiva.com.br> <4192A9BF.2080606@conectiva.com.br> <4192ADF4.1050907@conectiva.com.br>
In-Reply-To: <4192ADF4.1050907@conectiva.com.br>
Content-Type: multipart/mixed;
 boundary="------------060600010508000707090400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060600010508000707090400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

OK, last try, of course the patch is busted because the #endif should
be _before_ the break statement.

/me goes looking for a brown paper bag :-(

- Arnaldo

Arnaldo Carvalho de Melo wrote:
> This one compiles and links OK.
> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo wrote:
> 
>> arch/i386/kernel/built-in.o(.text+0xeade): In function `pin_2_irq':
>> : undefined reference to `platform_rename_gsi'
>> make: ** [.tmp_vmlinux1] Erro 1
>>
>> Sorry, the patch is not enough...
>>
>> - Arnaldo
>>
>> Arnaldo Carvalho de Melo wrote:
>>
>>> Hi Linus,
>>>
>>>     This is needed to build current BK tree on IA32.
> 
> 
> ------------------------------------------------------------------------
> 
> ===== arch/i386/kernel/io_apic.c 1.116 vs edited =====
> --- 1.116/arch/i386/kernel/io_apic.c	2004-10-28 05:35:33 -03:00
> +++ edited/arch/i386/kernel/io_apic.c	2004-11-10 21:58:57 -02:00
> @@ -1069,12 +1069,14 @@
>  			while (i < apic)
>  				irq += nr_ioapic_registers[i++];
>  			irq += pin;
> +#ifdef CONFIG_ACPI_BOOT
>  			/*
>  			 * For MPS mode, so far only used by ES7000 platform
>  			 */
>  			if (platform_rename_gsi)
>  				irq = platform_rename_gsi(apic, irq);
>  			break;
> +#endif
>  		}
>  		default:
>  		{

--------------060600010508000707090400
Content-Type: text/plain;
 name="a.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="a.patch"

===== arch/i386/kernel/io_apic.c 1.116 vs edited =====
--- 1.116/arch/i386/kernel/io_apic.c	2004-10-28 05:35:33 -03:00
+++ edited/arch/i386/kernel/io_apic.c	2004-11-10 22:17:37 -02:00
@@ -1069,11 +1069,13 @@
 			while (i < apic)
 				irq += nr_ioapic_registers[i++];
 			irq += pin;
+#ifdef CONFIG_ACPI_BOOT
 			/*
 			 * For MPS mode, so far only used by ES7000 platform
 			 */
 			if (platform_rename_gsi)
 				irq = platform_rename_gsi(apic, irq);
+#endif
 			break;
 		}
 		default:

--------------060600010508000707090400--
