Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWEYExJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWEYExJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWEYExJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:53:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18072 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965034AbWEYExI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:53:08 -0400
To: Magnus Damm <magnus@valinux.co.jp>
Cc: vgoyal@in.ibm.com, fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/03] kexec: Avoid overwriting the current pgd (V2)
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	<20060524225631.GA23291@in.ibm.com>
	<1148522948.5793.98.camel@localhost>
	<m1k68astge.fsf@ebiederm.dsl.xmission.com>
	<1148527837.5793.121.camel@localhost>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 24 May 2006 22:51:56 -0600
In-Reply-To: <1148527837.5793.121.camel@localhost> (Magnus Damm's message of
 "Thu, 25 May 2006 12:30:37 +0900")
Message-ID: <m17j4aso43.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus@valinux.co.jp> writes:

> Hi Eric,
>
> On Wed, 2006-05-24 at 20:56 -0600, Eric W. Biederman wrote:
>> 
>> C code is much more accessible to other programmers than arch specific
>> assembly.  The code on the control page was almost written in C, and
>> I'm still not quite convinced that it would be wrong to do that.
>
> I agree with you that it is of course better to implement something in C
> if possible compared to writing it in architecture-specific assembly.
>
> But I do not agree that wrapping architecture-specific assembly code in
> C functions makes the code more understandable. I'd really like to meet
> the kernel hacker that is aware of how x86 segmentation works but is
> unable to read x86 assembly.

For some young programmers it may be a matter of reading ability.
For older programmers it is more likely to be a matter of reading
speed. 

Regardless that is how the code is now, and how it came out of the series
of code reviews I had to go through when I wrote it.  I had requests
to do more in C and I never had a request to do more in assembly.
Proving there was no sane way to write the control code page in
C was actually difficult.

If there is a legitimate reason to change the code that is fine.  But
as it looked as simply a change without a good reason that is not
fine.

The big problem was you did several things with a single patch,
and that made the review much more difficult than it had to be.

Having to check if you correctly modified the page tables, while also
having to check for segmentation, and the interrupt descriptor
transformations was distracting.

>> > - I'm currently working on making kexec to work under xen/dom0. And by
>> > moving the segment handling code into the assembly file we reduce the
>> > amount of duplicated code.
>> 
>> Not the reason I would have expected.  So you are only differring the
>> two implementations by the contents of the control code page?
>
> Nah, there's a fairly large framework to pass pages to the hypervisor,
> converting pfn:s to mfn:s, building page tables etc. We will resend the
> patches later on today to xen-devel if you're interested.

Ok.  I might have to look.

Eric
