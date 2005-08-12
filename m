Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbVHLSW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVHLSW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVHLSWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:22:32 -0400
Received: from ns2.suse.de ([195.135.220.15]:58248 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750804AbVHLSW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:22:29 -0400
Date: Fri, 12 Aug 2005 20:22:28 +0200
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andi Kleen <ak@suse.de>, Martin Wilck <martin.wilck@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org
Subject: Re: APIC version and 8-bit APIC IDs
Message-ID: <20050812182228.GE22901@wotan.suse.de>
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel> <p73pssj2xdz.fsf@verdi.suse.de> <42FCA23C.7040601@fujitsu-siemens.com> <20050812133248.GN8974@wotan.suse.de> <42FCA97E.5010907@fujitsu-siemens.com> <42FCB86C.5040509@fujitsu-siemens.com> <20050812145725.GD922@wotan.suse.de> <20050812111916.A15541@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050812111916.A15541@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.6.13-rc6/arch/x86_64/kernel/mpparse.c~	2005-08-12 10:19:07.037696416 -0700
> +++ linux-2.6.13-rc6/arch/x86_64/kernel/mpparse.c	2005-08-12 10:19:38.098974384 -0700
> @@ -707,7 +707,7 @@
>  
>  	processor.mpc_type = MP_PROCESSOR;
>  	processor.mpc_apicid = id;
> -	processor.mpc_apicver = 0x10; /* TBD: lapic version */
> +	processor.mpc_apicver = GET_APIC_VERSION(apic_read(APIC_LVR));

That code executes on the BP. What happens when different CPUs have
different APIC versions?  Not sure if that can happen, but it 
still looks a bit like "cheating.

-Andi
