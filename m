Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWHJRGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWHJRGj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWHJRGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:06:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53909 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932493AbWHJRGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:06:38 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: Don Zickus <dzickus@redhat.com>, fastboot@osdl.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <20060804210826.GE16231@redhat.com>
	<m164h8p50c.fsf@ebiederm.dsl.xmission.com>
	<20060804234327.GF16231@redhat.com>
	<m1hd0rmaje.fsf@ebiederm.dsl.xmission.com>
	<20060807174439.GJ16231@redhat.com>
	<m17j1kctb8.fsf@ebiederm.dsl.xmission.com>
	<20060807235727.GM16231@redhat.com>
	<m1ejvrakhq.fsf@ebiederm.dsl.xmission.com>
	<20060809200642.GD7861@redhat.com>
	<m1u04l2kaz.fsf@ebiederm.dsl.xmission.com>
	<20060810131323.GB9888@in.ibm.com>
Date: Thu, 10 Aug 2006 11:05:22 -0600
In-Reply-To: <20060810131323.GB9888@in.ibm.com> (Vivek Goyal's message of
	"Thu, 10 Aug 2006 09:13:23 -0400")
Message-ID: <m18xlw34j1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> Apart from this I think something is still off on x86_64. I have not
> been able to make kdump work on x86_64. Second kernel simply hangs.
> Two different machines are showing different results.
>
> - On one machine, it seems to be stuck somewhere in decompress_kernel().
>   Serial console is not behaving properly even with earlyprintk(). Somehow
>   I feel it is some bss corruption even after my changes.
>
> - Other machines seems to be going till start_kernel() and even after
>   that (No messages on the console, all serial debugging) and then
>   either it hangs or jumps back to BIOS.
>
> Will look more into it.

Thanks.

I'm a little disappointed but at this point it isn't a great surprise,
the code is early yet and hasn't had much testing or attention.
I wonder if I have missed something else silly.

As for testing, can you use plain kexec to load the kernel at a
different address?  I'm curious to know if it is something related
to the kexec on panic path or if it is just running at a different
location that is the problem.

I'm back on the namespace stuff this week so it will be a while before
I get back to this.  It doesn't look like I have time to work the whole
patchset at once.  So my current plan is to take as many pieces that
make sense by themselves and push them upstream.  Until we get down to
just the relocatable kernel patches that are outstanding.

Everything was fairly well received on the round of reviews with some
minor nits that needed to be picked.  So I think this is doable.

Eric
