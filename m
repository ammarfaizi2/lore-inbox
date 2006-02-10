Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWBJLLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWBJLLD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 06:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWBJLLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 06:11:03 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:3985 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S1751353AbWBJLLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 06:11:01 -0500
Message-ID: <43EC7473.20109@cosmosbay.com>
Date: Fri, 10 Feb 2006 12:09:39 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@muc.de>, ashok.raj@intel.com, ntl@pobox.com,
       riel@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       mingo@elte.hu, 76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, pj@sgi.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
References: <20060209160808.GL18730@localhost.localdomain>	<20060209090321.A9380@unix-os.sc.intel.com>	<20060209100429.03f0b1c3.akpm@osdl.org>	<200602101102.25437.ak@muc.de> <20060210024222.67db06f3.akpm@osdl.org>
In-Reply-To: <20060210024222.67db06f3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 10 Feb 2006 12:09:42 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> Andi Kleen <ak@muc.de> wrote:
>> On Thursday 09 February 2006 19:04, Andrew Morton wrote:
>>> Ashok Raj <ashok.raj@intel.com> wrote:
>>>> The problem was with ACPI just simply looking at the namespace doesnt
>>>>  exactly give us an idea of how many processors are possible in this platform.
>>> We need to fix this asap - the performance penalty for HOTPLUG_CPU=y,
>>> NR_CPUS=lots will be appreciable.
>> What is this performance penalty exactly? 
> 
> All those for_each_cpu() loops will hit NR_CPUS cachelines instead of
> hweight(cpu_possible_map) cachelines.

You mean NR_CPUS bits, mostly all included in a single cacheline, and even in 
a single long word :) for most cases (NR_CPUS <= 32 or 64)



