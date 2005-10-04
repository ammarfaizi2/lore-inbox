Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbVJDItN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVJDItN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 04:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVJDItN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 04:49:13 -0400
Received: from vulpecula.futurs.inria.fr ([195.83.212.5]:64916 "EHLO
	vulpecula.futurs.inria.fr") by vger.kernel.org with ESMTP
	id S964792AbVJDItM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 04:49:12 -0400
Message-ID: <43424202.7070600@lifl.fr>
Date: Tue, 04 Oct 2005 10:49:06 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
User-Agent: Mozilla Thunderbird 1.0.6-7mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] ppc64: Add cpufreq support for SMU based G5
References: <1128403842.31063.24.camel@gaston>
In-Reply-To: <1128403842.31063.24.camel@gaston>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

10/04/2005 07:30 AM, Benjamin Herrenschmidt wrote/a écrit:
> iMac G5 and latest single CPU desktop G5 (SMU based machines) have a
> 970FX DD3 CPU that supports frequency & vooltage switching. This patch
> adds support for simple dual frequency switch. It is required for the
> upcoming thermal control patch for these machines.
> 

Hello,

I know only very little about cpufreq, probably you could post your 
patch to the cpufreq mailing list for better review : 
cpufreq@lists.linux.org.uk (you may have to subscride before posting, 
don't remember).

For what have seen, your patch looks pretty good in general. However, is 
this kind of CPU only in one CPU machines? Your patch doesn't seem 
support SMP, then it's probably safer to prevent compilation on an SMP 
kernel in the Makefile? Or you can add SMP support (shouldn't be so hard 
in theory, but with no hardware to test it might be pointless), you can 
have a look at other drivers that support it, like in 
arch/i386/kernel/cpu/cpufreq/p4-clockmod.c .

Just a little more thing, concerning:
+	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
Could you have a look if you could find the real info about how long it 
takes to change the speed (put the worse case latency)? Maybe the info 
can be found in some parts of the ROM you read? I don't know if 
conservative or ondemand governors are supposed to be able to mix with 
your code (especially wrt Windfarm) but not putting this info will 
prevent them from ever working...

Cheers,
Eric
