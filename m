Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSFFVXf>; Thu, 6 Jun 2002 17:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317188AbSFFVXe>; Thu, 6 Jun 2002 17:23:34 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:19455 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S317187AbSFFVXc>; Thu, 6 Jun 2002 17:23:32 -0400
Date: Thu, 6 Jun 2002 23:23:11 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Andrew Morton <akpm@zip.com.au>
cc: Robert Love <rml@tech9.net>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] CONFIG_NR_CPUS
In-Reply-To: <3CFFBCA9.843C40F0@zip.com.au>
Message-ID: <Pine.GSO.4.05.10206062318190.19900-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--snip/snip

> OK.  What I'll do is:
> 
> #ifdef CONFIG_SMP
> #define NR_CPUS CONFIG_NR_CPUS
> #else
> #define NR_CPUS 1
> #endif
> 
> and then go edit every SMP-capable arch's config.in/Config.help
> files.  But the arch maintainers should test one case please - x86
> was locking up at boot on quad CPU with NR_CPUS=2.  Others may do
> the same.

well, what you need to do is make sure smp_num_cpu <= NR_CPUS,
otherwise the kernel will go ballistic on several places within
the code.

- at least in the network system there is the assumption, that
NR_CPUS is the upper limit of cpus. after initialization, everything 
uses smp_num_cpus, which is a nice thing for cpu-hotplugging :)

	tm
-- 
in some way i do, and in some way i don't.

