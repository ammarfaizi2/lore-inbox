Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWFTFKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWFTFKU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWFTFKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:10:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31895 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751195AbWFTFKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:10:17 -0400
Date: Tue, 20 Jun 2006 01:09:10 -0400
From: Dave Jones <davej@redhat.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] i386: halt the CPU on serious errors
Message-ID: <20060620050910.GA6091@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
	Andrew Morton <akpm@osdl.org>
References: <200606200059_MC3-1-C2E8-8C46@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606200059_MC3-1-C2E8-8C46@compuserve.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 12:55:25AM -0400, Chuck Ebbert wrote:
 
 > --- 2.6.17-32.orig/arch/i386/kernel/crash.c
 > +++ 2.6.17-32/arch/i386/kernel/crash.c
 > @@ -113,8 +113,8 @@ static int crash_nmi_callback(struct pt_
 >  	disable_local_APIC();
 >  	atomic_dec(&waiting_for_crash_ipi);
 >  	/* Assume hlt works */
 > -	halt();
 > -	for(;;);
 > +	for (;;)
 > +		halt();
 >  
 >  	return 1;

But we should never get past that first halt(), as interrupts are disabled.

 > --- 2.6.17-32.orig/arch/i386/kernel/doublefault.c
 > +++ 2.6.17-32/arch/i386/kernel/doublefault.c
 > @@ -44,7 +44,8 @@ static void doublefault_fn(void)
 >  		}
 >  	}
 >  
 > -	for (;;) /* nothing */;
 > +	for (;;)
 > +		halt();
 >  }

This one would probably be better off as a cpu_relax()

		Dave

-- 
http://www.codemonkey.org.uk
