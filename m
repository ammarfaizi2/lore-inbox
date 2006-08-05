Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422759AbWHEIDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422759AbWHEIDM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 04:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422761AbWHEIDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 04:03:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3490 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422759AbWHEIDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 04:03:10 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Jones <davej@redhat.com>, vgoyal@in.ibm.com, fastboot@osdl.org,
       linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<20060804225611.GG19244@in.ibm.com>
	<m1k65onleq.fsf@ebiederm.dsl.xmission.com>
	<20060804233815.GG18792@redhat.com> <44D3DC7E.70100@zytor.com>
Date: Sat, 05 Aug 2006 02:01:21 -0600
In-Reply-To: <44D3DC7E.70100@zytor.com> (H. Peter Anvin's message of "Fri, 04
	Aug 2006 16:47:10 -0700")
Message-ID: <m17j1nobla.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Dave Jones wrote:
>> On Fri, Aug 04, 2006 at 05:14:37PM -0600, Eric W. Biederman wrote:
>>  > I guess the practical question is do people see a real performance benefit
>>  > when loading the kernel at 4MB?
>> Linus claimed lmbench saw some huge wins. Others showed that for eg,
>> a kernel compile took the same amount of time, so take from that what you
> will..

But Linus wasn't comparing the same version of the kernel.  So it was
a bit unknown.  Having someone reproduce those lm_bench numbers on the
exact same kernel would be interesting.

>> > Possibly the right solution is to do like I did on x86_64 and simply remove
>> > CONFIG_PHYSICAL_START, and always place the kernel at 4MB, or something like
>>  > that.
>> > > The practical question is what to do to keep the complexity from spinning
>>  > out of control.  Removing CONFIG_PHYSICAL_START would seriously help with
>>  > that.
>> Given the two primary uses of that option right now are a) the aforementioned
>> perf win and b) building kexec kernels, I doubt anyone would miss it once
>> we go relocatable ;-)
>>
>
> We DO want the performance gain with a conventional bootloader.  The perf win is
> about the location of the uncompressed kernel, not the compressed kernel.

Agreed.

We also need a way to boot a kernel on an old machine with limited memory.
Possibly we would only support this if PSE is not supported, which old machines
don't support.

The complication that the decompressor must relocation the image for
supporting old bootloaders is challenging in the context or a truly relocatable
kernel, where we run at the address the bootloader put us.

The basic other concern is how flexible do we need to be with respect to relocation.

Eric
