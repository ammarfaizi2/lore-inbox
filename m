Return-Path: <linux-kernel-owner+w=401wt.eu-S1751623AbWLMWWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWLMWWs (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 17:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWLMWWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 17:22:47 -0500
Received: from terminus.zytor.com ([192.83.249.54]:41566 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbWLMWWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 17:22:47 -0500
X-Greylist: delayed 1080 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 17:22:47 EST
Message-ID: <45807C88.6060807@zytor.com>
Date: Wed, 13 Dec 2006 14:19:52 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, Rudolf Marek <r.marek@assembler.cz>,
       hpa@zytor.com, norsk5@xmission.com, lkml <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>,
       bluesmoke-devel@lists.sourceforge.net
Subject: Re: [RFC] new MSR r/w functions per CPU
References: <45807469.6040609@assembler.cz> <20061213221026.GF2418@redhat.com>
In-Reply-To: <20061213221026.GF2418@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> Exposing the guts of the msr driver like that doesn't seem too clean.
> For in-kernel use, why not just add something like this..
> (note:not even compile tested)..
> 

Well, that *is* the guts of the MSR driver.

> void rdmsr_on_cpu(unsigned int cpu, unsigned long msr, unsigned long *lo, unsigned long *hi)
> {
>     cpumask_t oldmask;
> 
>     oldmask = current->cpus_allowed;
>     set_cpus_allowed(current, cpumask_of_cpu(cpu));
> 
> 	rdmsr(msr, &lo, &hi);
> 
>     set_cpus_allowed(current, oldmask);
> }
> 

[The above doesn't work, by the way.  This approach was discussed a long 
time ago, and vetoed due to the potential for deadlock.]

	-hpa
