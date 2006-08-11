Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWHKEKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWHKEKj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 00:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWHKEKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 00:10:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:54462 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751143AbWHKEKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 00:10:38 -0400
From: Andi Kleen <ak@suse.de>
To: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH for review] [26/145] x86_64: Add initalization of the RDTSCP auxilliary values
Date: Fri, 11 Aug 2006 06:09:35 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060810 935.775038000@suse.de> <20060810193539.7D01B13B90@wotan.suse.de> <44DBA9D7.1040500@flower.upol.cz>
In-Reply-To: <44DBA9D7.1040500@flower.upol.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608110609.35540.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  > +static int __cpuinit
>  > +time_cpu_notifier(struct notifier_block *nb, unsigned long action, void *hcpu)
>  >  {
>  > -	char *timename;
>  > -	char *gtod;
>  > +	unsigned cpu = (unsigned long) hcpu;
> 
> Is this some kind of "endian magic" ? I mean getting high or low word of 64 
> pointer to 32 variable ? Why cast just with (unsigned) doesn't work ?

This is just to avoid a warning from gcc that a pointer is converted
to a 32bit integer -- which is ok here since it uses a "void *" callback argument
to pass an integer.

Arguably there should be a standard macro for this construct, but there
isn't currently.

> 
>  > +	if (action == CPU_ONLINE &&
>  > +		cpu_has(&cpu_data[cpu], X86_FEATURE_RDTSCP)) {
>  > +		unsigned p;
>  > +		p = smp_processor_id() | (cpu_to_node(smp_processor_id())<<12);
> 
> Is this code runs under SMP ? I couldn't figure that out.

Yes it is. It handles additional CPUs. 

-Andi
