Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266148AbUFUIHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266148AbUFUIHz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 04:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266156AbUFUIHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 04:07:54 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:44689 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S266148AbUFUIHp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 04:07:45 -0400
From: "Matt H." <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-bk way too fast
Date: Mon, 21 Jun 2004 01:15:45 -0700
User-Agent: KMail/1.6.52
Cc: lkml@lpbproduction.scom, cs@tequila.co.jp, torvalds@osdl.org,
       norberto+linux-kernel@bensa.ath.cx, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
References: <40D64DF7.5040601@pobox.com> <200406210018.04883.lkml@lpbproductions.com> <20040621001612.176bf8e1.akpm@osdl.org>
In-Reply-To: <20040621001612.176bf8e1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406210115.46159.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried from a fresh  2.6.7-mm1 tree  with your patch ( I had to fix up the 
2nd half of your patch by hand since  it wouldve rejected ).  The results 
were the same though. 

Matt H.

On Monday 21 June 2004 12:16 am, Andrew Morton wrote:
> "Matt H." <lkml@lpbproductions.com> wrote:
> > I can confirm simular behavior here. I loaded 2.6.7-mm1 tonite  and 
> > tried Andrew's  patch ( which didn't work ) and then Linus's  ( which
> > also didn't work ).
>
> hm.  This worked for me.  Could you double-check?
>
>
> diff -puN arch/i386/kernel/mpparse.c~double-clock-speed-fix
> arch/i386/kernel/mpparse.c ---
> 25/arch/i386/kernel/mpparse.c~double-clock-speed-fix	2004-06-20
> 23:28:16.655299120 -0700 +++ 25-akpm/arch/i386/kernel/mpparse.c	2004-06-20
> 23:28:20.468719392 -0700 @@ -1017,7 +1017,6 @@ void __init
> mp_config_acpi_legacy_irqs (
>
>  		for (idx = 0; idx < mp_irq_entries; idx++)
>  			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
> -				(mp_irqs[idx].mpc_dstapic == ioapic) &&
>  				(mp_irqs[idx].mpc_srcbusirq == i ||
>  				mp_irqs[idx].mpc_dstirq == i))
>  					break;
> diff -puN arch/x86_64/kernel/mpparse.c~double-clock-speed-fix
> arch/x86_64/kernel/mpparse.c ---
> 25/arch/x86_64/kernel/mpparse.c~double-clock-speed-fix	2004-06-20
> 23:28:16.672296536 -0700 +++
> 25-akpm/arch/x86_64/kernel/mpparse.c	2004-06-20 23:28:20.469719240 -0700 @@
> -861,7 +861,6 @@ void __init mp_config_acpi_legacy_irqs (
>
>  		for (idx = 0; idx < mp_irq_entries; idx++)
>  			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
> -				(mp_irqs[idx].mpc_dstapic == ioapic) &&
>  				(mp_irqs[idx].mpc_srcbusirq == i ||
>  				mp_irqs[idx].mpc_dstirq == i))
>  					break;
> _
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
