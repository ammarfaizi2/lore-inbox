Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263180AbVGABCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbVGABCA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 21:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbVGABCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 21:02:00 -0400
Received: from unused.mind.net ([69.9.134.98]:47582 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S263180AbVGABB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 21:01:58 -0400
Date: Thu, 30 Jun 2005 18:00:40 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
cc: Karsten Wiese <annabellesgarden@yahoo.de>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-Reply-To: <Pine.LNX.4.58.0506301555450.21799@echo.lysdexia.org>
Message-ID: <Pine.LNX.4.58.0506301741120.22037@echo.lysdexia.org>
References: <200506281927.43959.annabellesgarden@yahoo.de>
 <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu>
 <200507010027.33079.annabellesgarden@yahoo.de> <Pine.LNX.4.58.0506301555450.21799@echo.lysdexia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2005, William Weston wrote:
> On Fri, 1 Jul 2005, Karsten Wiese wrote:
> > --- linux-2.6.12-RT-50-35/arch/i386/kernel/mpparse.c	2005-06-30 16:38:00.000000000 +0200
> > +++ linux-2.6.12-RT/arch/i386/kernel/mpparse.c	2005-06-29 20:30:50.000000000 +0200
> > @@ -263,6 +263,7 @@
> >  		return;
> >  	}
> >  	mp_ioapics[nr_ioapics] = *m;
> > +	io_apic_base[nr_ioapics] = IO_APIC_BASE(nr_ioapics);
> >  	nr_ioapics++;
> >  }
> >  
> > @@ -914,6 +915,7 @@
> >  	mp_ioapics[idx].mpc_apicaddr = address;
> >  
> >  	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
> > +	io_apic_base[idx] = IO_APIC_BASE(idx);
> >  	mp_ioapics[idx].mpc_apicid = io_apic_get_unique_id(idx, id);
> >  	mp_ioapics[idx].mpc_apicver = io_apic_get_version(idx);
> 
> Thanks, Karsten.  This patch was needed to get my Xeon/HT (i865) to boot 
> -50-39.  Next I'll see if IOAPIC_FAST will work.  I'll keep you posted.

After applying this patch to -50-39, IOAPIC_FAST now works on both the 
Xeon/HT and the non-HT Xeon boxes (i865 and i845 respectively).  Wakeup 
latencies are looking better, especially on the Xeon/HT (max of 53us so 
far, as compared to 183us with -50-37 without IOAPIC_FAST).

I'll test this out on the Athlon box (which hasn't done well with 
IOAPIC_FAST previously) when I get home.

--ww
