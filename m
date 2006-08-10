Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWHJXtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWHJXtW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 19:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWHJXtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 19:49:22 -0400
Received: from main.gmane.org ([80.91.229.2]:39138 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932329AbWHJXtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 19:49:21 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH for review] [26/145] x86_64: Add initalization of the
 RDTSCP auxilliary values
Date: Thu, 10 Aug 2006 23:49:11 +0200
Organization: Palacky University in Olomouc
Message-ID: <44DBA9D7.1040500@flower.upol.cz>
References: <20060810 935.775038000@suse.de> <20060810193539.7D01B13B90@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 158.194.192.40
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <20060810193539.7D01B13B90@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen:
 > ---
 >  arch/x86_64/kernel/smpboot.c |    2 +
 >  arch/x86_64/kernel/time.c    |   47 ++++++++++++++++++++++++++++++++-----------
 >  include/asm-x86_64/proto.h   |    1
 >  3 files changed, 38 insertions(+), 12 deletions(-)
 >
 > Index: linux/arch/x86_64/kernel/time.c
 > ===================================================================
 > --- linux.orig/arch/x86_64/kernel/time.c
 > +++ linux/arch/x86_64/kernel/time.c
...
 > +static int __cpuinit
 > +time_cpu_notifier(struct notifier_block *nb, unsigned long action, void *hcpu)
 >  {
 > -	char *timename;
 > -	char *gtod;
 > +	unsigned cpu = (unsigned long) hcpu;

Is this some kind of "endian magic" ? I mean getting high or low word of 64 
pointer to 32 variable ? Why cast just with (unsigned) doesn't work ?

 > +	if (action == CPU_ONLINE &&
 > +		cpu_has(&cpu_data[cpu], X86_FEATURE_RDTSCP)) {
 > +		unsigned p;
 > +		p = smp_processor_id() | (cpu_to_node(smp_processor_id())<<12);

Is this code runs under SMP ? I couldn't figure that out.

 > +		write_rdtscp_aux(p);
 > +	}
 > +	return NOTIFY_DONE;
 > +}

Thanks.

--
-o--=O`C
  #oo'L O
<___=E M

