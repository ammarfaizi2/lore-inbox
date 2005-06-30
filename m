Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263097AbVF3XAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbVF3XAq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 19:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbVF3XAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 19:00:46 -0400
Received: from unused.mind.net ([69.9.134.98]:34270 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S263097AbVF3XAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 19:00:39 -0400
Date: Thu, 30 Jun 2005 15:59:21 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Karsten Wiese <annabellesgarden@yahoo.de>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-Reply-To: <200507010027.33079.annabellesgarden@yahoo.de>
Message-ID: <Pine.LNX.4.58.0506301555450.21799@echo.lysdexia.org>
References: <200506281927.43959.annabellesgarden@yahoo.de>
 <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu>
 <200507010027.33079.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2005, Karsten Wiese wrote:
> 
> <snip>
> --- linux-2.6.12-RT-50-35/arch/i386/kernel/mpparse.c	2005-06-30 16:38:00.000000000 +0200
> +++ linux-2.6.12-RT/arch/i386/kernel/mpparse.c	2005-06-29 20:30:50.000000000 +0200
> @@ -263,6 +263,7 @@
>  		return;
>  	}
>  	mp_ioapics[nr_ioapics] = *m;
> +	io_apic_base[nr_ioapics] = IO_APIC_BASE(nr_ioapics);
>  	nr_ioapics++;
>  }
>  
> @@ -914,6 +915,7 @@
>  	mp_ioapics[idx].mpc_apicaddr = address;
>  
>  	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
> +	io_apic_base[idx] = IO_APIC_BASE(idx);
>  	mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
>  	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);
> </snip>
> 
> It provides the precalculation of the ioapics's virtual address.
> Or does IO_APIC_BASE() compile to an indexed lookup?
>  then io_apic_base[] wouldn't be needed...

Thanks, Karsten.  This patch was needed to get my Xeon/HT (i865) to boot 
-50-39.  Next I'll see if IOAPIC_FAST will work.  I'll keep you posted.

--ww
