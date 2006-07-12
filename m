Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWGLVao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWGLVao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWGLVao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:30:44 -0400
Received: from terminus.zytor.com ([192.83.249.54]:36287 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751333AbWGLVan
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:30:43 -0400
Message-ID: <44B569C7.3020508@zytor.com>
Date: Wed, 12 Jul 2006 14:29:43 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Jakub Jelinek <jakub@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <20060712184412.2BD57180061@magilla.sf.frob.com>	<44B54EA4.5060506@redhat.com>	<20060712195349.GW3823@sunsite.mff.cuni.cz>	<44B556E5.5000702@zytor.com> <m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> Jakub Jelinek wrote:
>>> On Wed, Jul 12, 2006 at 12:33:56PM -0700, Ulrich Drepper wrote:
>>>> Roland McGrath wrote:
>>>>> We could also put the uname info (modulo nodename) into the vDSO.
>>>> Or even better: real topology information.
>>> AND rather than OR would be even better.  So glibc could find kernel
>>> version, etc. and topology in the vDSO cheaply.
>> Wouldn't it make more sense for this to be in ELF tags, rather than the vdso?
>> Another alternative, I guess, would be to put a pointer in the ELF tags, which
>> may point into the vdso.
> 
> Cheap and simple access to topology information would be interesting.
> 
> Glibc just wants to know if our kernel is SMP so it can know if it is
> ok to busy wait for a bit waiting for a mutex.  Or if busy waiting is
> a complete loss.
> 
> The practical challenge is that topology information is not fixed but
> potentially varies at runtime.
> 
> Ulrich what would be interesting besides the possibility of having
> multiple cpus?
> 

Something that might make sense to ask CPU vendors for in the future: an 
instruction that can either trap or be a noop (or better, cpu_relax) 
based on a control register.

Not that that solves any problem any time soon.

	-hpa
