Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129965AbRAZWul>; Fri, 26 Jan 2001 17:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131096AbRAZWuc>; Fri, 26 Jan 2001 17:50:32 -0500
Received: from selene.cps.intel.com ([192.198.165.10]:36625 "EHLO
	selene.cps.intel.com") by vger.kernel.org with ESMTP
	id <S129965AbRAZWu1>; Fri, 26 Jan 2001 17:50:27 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDF8B@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Rasmus Andersen'" <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: RE: [uPATCH][Probably fucked up] arch/i386/kernel/io_apic.c: miss
	ing extern? (241p10)
Date: Fri, 26 Jan 2001 14:50:04 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus,

Yep, I noticed this during some recent ServerWorks chipset
APIC work I have been doing.

nr_ioapics is also used in arch/i386/kernel/apic.c
(#ifdef CONFIG_X86_IO_APIC), so that should have an
  extern int nr_ioapics;
also.

I'd prefer to see nr_ioapics live near the mp_ioapics[] array,
in io_apic.c, and add an
  extern int nr_ioapics;
in mpparse.c also.

And while your patch will compile without syntax errors,
it has linker errors on undefined references to 'nr_ioapics'.


> In arch/i386/kernel we declare nr_ioapics in both io_apic.c 
> and mpparse.c.

Where is it declared in mpparse.c ?
I don't see it.

> I guess that one of them should be an 'extern' declaration? 
> In the patch
> below I have guessed that it is io_apic.c that is missing it 
> since (AFAICS)
> never assign to nr_ioapic in this file. 

It's only _read_ in io_apic.c and written in mpparse.c.

> But I am in way over my head here so please be gentle when you point
> out my mistake.
> 
> The patch (against 241p10 and ac11):
> 
> 
> --- linux-ac11-clean/arch/i386/kernel/io_apic.c	Thu Jan 
> 25 20:48:51 2001
> +++ linux-ac11/arch/i386/kernel/io_apic.c	Fri Jan 26 21:59:16 2001
> @@ -38,7 +38,7 @@
>  /*
>   * # of IRQ routing registers
>   */
> -int nr_ioapics;
> +extern int nr_ioapics;
>  int nr_ioapic_registers[MAX_IO_APICS];
>  
>  #if CONFIG_SMP
> 
> -- 
> Regards,
>         Rasmus(rasmus@jaquet.dk)


~Randy
_______________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
