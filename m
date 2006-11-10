Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932833AbWKJKFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833AbWKJKFG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932832AbWKJKFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:05:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52383 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932833AbWKJKFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:05:04 -0500
Subject: Re: [patch 08/19] i386: cleanup apic code
From: Arjan van de Ven <arjan@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       John Stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20061109233034.987972000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <20061109233034.987972000@cruncher.tec.linutronix.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 10 Nov 2006 11:04:59 +0100
Message-Id: <1163153099.3138.642.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  
>  /*
>   * Knob to control our willingness to enable the local APIC.
> + *
> + * -1=force-disable, +1=force-enable

mind doing 2 defines for these? Makes things more readable I suspect

> -	return maxlvt;
> +	return APIC_INTEGRATED(GET_APIC_VERSION(v)) ? GET_APIC_MAXLVT(v) : 2;
>  }

why not use lapic_is_integrated() here?
> \
> +	if (cpu_has_tsc)
> +		apic_printk(APIC_VERBOSE, "..... CPU clock speed is "

please put "approximated at" or something here; or people will call
supportlines if they bought a 3.4Ghz processor and this shows 3.39999Ghz



> +EXPORT_SYMBOL(switch_APIC_timer_to_ipi);

why is this exported at all? Modules really shouldn't be touching apic
level details.... 



this patch is extremely difficult to review because diff has made a mess
out of it ;(

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

