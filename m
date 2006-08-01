Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751557AbWHADpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbWHADpd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 23:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWHADpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 23:45:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33243 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751557AbWHADpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 23:45:32 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: vgoyal@in.ibm.com, fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <aec7e5c30607051932r49bbcc7eh2c190daa06859dcc@mail.gmail.com>
	<20060706081520.GB28225@host0.dyn.jankratochvil.net>
	<aec7e5c30607070147g657d2624qa93a145dd4515484@mail.gmail.com>
	<20060707133518.GA15810@in.ibm.com>
	<20060707143519.GB13097@host0.dyn.jankratochvil.net>
	<20060710233219.GF16215@in.ibm.com>
	<20060711010815.GB1021@host0.dyn.jankratochvil.net>
	<m1d5c92yv4.fsf@ebiederm.dsl.xmission.com>
	<m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>
	<20060731202520.GB11790@in.ibm.com>
	<20060731210050.GC11790@in.ibm.com>
	<m18xm9425s.fsf@ebiederm.dsl.xmission.com> <44CEBDD1.10302@zytor.com>
Date: Mon, 31 Jul 2006 21:44:03 -0600
In-Reply-To: <44CEBDD1.10302@zytor.com> (H. Peter Anvin's message of "Mon, 31
	Jul 2006 19:34:57 -0700")
Message-ID: <m1k65t2k8s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
>>
>>> Ok. I am decompressing the kernel to 16MB and after reducing 1MB of
>>> CONFIG_PHYSICAL_START I am left with 15MB which is not 4M aligned
>>> hence I seems to be running into it.
>>>
>>> I changed it to
>>>
>>> if ((u32)output) & 0x3fffff)
>>>
>>> and kdump kernel booted fine. But this will run into issues if I load
>>> kernel at 1MB.
>>>
>>> I got a dump question. Why do I have to load the kernel at 4MB alignment?
>>> Existing kernel boots loads at 1MB, which is non 4MB aligned and it works
>>> fine?
>> 4MB is a little harsh, but I haven't worked through what the exact rules
>> are, I know 4MB is the worst case alignment for arch/i386.
>>
>
> 4 MB would be worst case for i386; 2 MB for x86-64.  Actually the x86-64 worst
> case would be gigabyte, but that's more than a little bit extreme.

Yep and that is what a test for, except for the gigabyte case which we don't
currently implement.  Although I can imagine that gigabyte pages might
be interesting for the identity mapped part of the page table.

Eric
