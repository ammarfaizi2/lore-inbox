Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWEYC5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWEYC5f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 22:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWEYC5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 22:57:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12951 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964836AbWEYC5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 22:57:34 -0400
To: Magnus Damm <magnus@valinux.co.jp>
Cc: vgoyal@in.ibm.com, fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/03] kexec: Avoid overwriting the current pgd (V2)
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	<20060524225631.GA23291@in.ibm.com>
	<1148522948.5793.98.camel@localhost>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 24 May 2006 20:56:33 -0600
In-Reply-To: <1148522948.5793.98.camel@localhost> (Magnus Damm's message of
 "Thu, 25 May 2006 11:09:08 +0900")
Message-ID: <m1k68astge.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus@valinux.co.jp> writes:

> On Wed, 2006-05-24 at 18:56 -0400, Vivek Goyal wrote:
>> On Wed, May 24, 2006 at 01:40:31PM +0900, Magnus Damm wrote:
>> > kexec: Avoid overwriting the current pgd (V2)
>> > 
>> > This patch updates the kexec code for i386 and x86_64 to avoid overwriting
>> > the current pgd. For most people is overwriting the current pgd is not a big
>> > problem. When kexec:ing into a new kernel that reinitializes and makes use
> of
>> > all memory we don't care about saving state.
>> > 
>> > But overwriting the current pgd is not a good solution in the case of kdump
>> > (CONFIG_CRASH_DUMP) where we want to preserve as much state as possible when
>> > a crash occurs. This patch solves the overwriting issue.
>> > 
>> > 20060524: V2
>> > 
>> > - Broke out architecture-specific data structures into asm/kexec.h
>> > - Fixed a i386/PAE page table problem only triggering on real hardware.
>> > - Moved segment handling code into the assembly routines.
>> 
>> What's the advantage of moving segment handling code into assembly
>> routines? It will only add to the fear of control code page size growing
>> beyond 4K.
>
> I have two main reasons:
>
> - Why wrap assembler instructions in C code if you just can move them
> into an already existing assembly file? Much cleaner IMO.

C code is much more accessible to other programmers than arch specific
assembly.  The code on the control page was almost written in C, and
I'm still not quite convinced that it would be wrong to do that.

> - I'm currently working on making kexec to work under xen/dom0. And by
> moving the segment handling code into the assembly file we reduce the
> amount of duplicated code.

Not the reason I would have expected.  So you are only differring the
two implementations by the contents of the control code page?

Eric
