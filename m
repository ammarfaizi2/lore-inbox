Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265380AbSKSOQ1>; Tue, 19 Nov 2002 09:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbSKSOQ1>; Tue, 19 Nov 2002 09:16:27 -0500
Received: from guru.webcon.net ([66.11.168.140]:18858 "EHLO guru.webcon.net")
	by vger.kernel.org with ESMTP id <S265380AbSKSOQ0>;
	Tue, 19 Nov 2002 09:16:26 -0500
Date: Tue, 19 Nov 2002 09:23:26 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][2.4-AC] export smp_num_siblings
In-Reply-To: <Pine.LNX.4.44.0211190214260.1538-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0211190909580.21575-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Zwane Mwaikambo wrote:

> On Mon, 18 Nov 2002, Ian Morgan wrote:
> 
> > > > c0292e28 D smp_num_siblings
> > > > 
> > > > Any clues?
> > > 
> > > Is CONFIG_SMP set?
> > 
> > Yup.
> 
> Can you give this a try.
> 
> Index: linux-2.4.20-rc1-ac4/arch/i386/kernel/i386_ksyms.c
> ===================================================================
> RCS file: /build/cvsroot/linux-2.4.20-rc1-ac4/arch/i386/kernel/i386_ksyms.c,v
> retrieving revision 1.1.1.1
> diff -u -r1.1.1.1 i386_ksyms.c
> --- linux-2.4.20-rc1-ac4/arch/i386/kernel/i386_ksyms.c	18 Nov 2002 01:39:49 -0000	1.1.1.1
> +++ linux-2.4.20-rc1-ac4/arch/i386/kernel/i386_ksyms.c	19 Nov 2002 07:11:43 -0000
> @@ -131,6 +131,7 @@
>  EXPORT_SYMBOL(cpu_data);
>  EXPORT_SYMBOL(kernel_flag_cacheline);
>  EXPORT_SYMBOL(smp_num_cpus);
> +EXPORT_SYMBOL(smp_num_siblings);
>  EXPORT_SYMBOL(cpu_online_map);
>  EXPORT_SYMBOL_NOVERS(__write_lock_failed);
>  EXPORT_SYMBOL_NOVERS(__read_lock_failed);

Interesting.. that does it. Now we have:

c0286b53 R __kstrtab_smp_num_siblings
c028e030 R __ksymtab_smp_num_siblings
c0292e28 D smp_num_siblings

and the p4-clockmod module loads OK. Thx.

Now my next step is figuring out how to actually set policy with this thing,
but I'm sure I can manage that one.

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan@webcon.ca          PGP: #2DA40D07           www.webcon.ca
    *  Customized Linux network solutions for your business  *
-------------------------------------------------------------------


