Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbVKMT5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVKMT5n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 14:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbVKMT5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 14:57:43 -0500
Received: from terminus.zytor.com ([192.83.249.54]:44456 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751011AbVKMT5m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 14:57:42 -0500
Message-ID: <43779A7E.7020201@zytor.com>
Date: Sun, 13 Nov 2005 11:56:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>	 <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>	 <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>	 <4374FB89.6000304@vmware.com>	 <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>	 <20051113074241.GA29796@redhat.com>  <p734q6g4xuc.fsf@verdi.suse.de> <1131902775.25311.16.camel@localhost.localdomain>
In-Reply-To: <1131902775.25311.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sul, 2005-11-13 at 11:59 +0100, Andi Kleen wrote:
> 
>>Dave Jones <davej@redhat.com> writes:
>>
>>>Looks like the Ubuntu people already did this...
>>>
>>>http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-2.6.git;a=commitdiff;h=048985336e32efe665cddd348e92e4a4a5351415;hp=1cb630c2b5aaad7cedaa78aa135e6cecf5ab91ac
>>
>>It's probably not needed. At least AMD K7/K8 has a SYSCFG MSR bit to
>>do this (or rather they disable bus cycles for locks that makes them
>>very cheap) Intel has one too in a different MSR that looks similar.
>>With some luck they're even already set by the BIOS on UP systems.  I
>>know they are on some AMD systems.
> 
> I'd hope the vendors are not doing that by default because we have
> kernel code that uses lock against not other processors but other bus
> masters. The ECC code is one example. Is there any good info on the AMD
> one so I can make the EDAC code put the processor back in x86 compatible
> mode so that it behaves safely when scrubbing.
> 

I can't speak about AMD, but on Transmeta's CPUs operations against 
cached memory are *always* atomic; the atomicity is guaranteed by the 
cache hierarchy.  The LOCK prefix does have effects against uncached memory.

	-hpa
