Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWEYQhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWEYQhU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965200AbWEYQhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:37:19 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24479 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964862AbWEYQhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:37:17 -0400
To: "Magnus Damm" <magnus.damm@gmail.com>
Cc: "Magnus Damm" <magnus@valinux.co.jp>, "Andrew Morton" <akpm@osdl.org>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH 01/03] kexec: Avoid overwriting the current
 pgd (V2, stubs)
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	<20060524044237.14219.15615.sendpatchset@cherry.local>
	<m1wtcasu5b.fsf@ebiederm.dsl.xmission.com>
	<1148528742.5793.135.camel@localhost>
	<m1bqtmsosw.fsf@ebiederm.dsl.xmission.com>
	<aec7e5c30605250011y35f295a0rf15e152910e98b94@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 25 May 2006 10:36:13 -0600
In-Reply-To: <aec7e5c30605250011y35f295a0rf15e152910e98b94@mail.gmail.com> (Magnus
 Damm's message of "Thu, 25 May 2006 16:11:12 +0900")
Message-ID: <m1u07edptu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Magnus Damm" <magnus.damm@gmail.com> writes:

> On 5/25/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Magnus Damm <magnus@valinux.co.jp> writes:
>> > On Wed, 2006-05-24 at 20:41 -0600, Eric W. Biederman wrote:
>> >> Magnus Damm <magnus@valinux.co.jp> writes:
>>
>> I believe I gave a complete explanation the first round.
>>
>> By having an extra extern variable you can export the offset of
>> a variable on the control code page, or what you need to compute
>> the offset.
>
> You explained some things last round, but there were still some
> questions left open. The main question was regarding "additional
> protection".

Memory that the kernel never sets up for DMA ever.

> I'd be happy to change to code into something that you would feel
> comfortable with, I just like to understand why. Having a
> per-architecture data area in struct kimage is by far the simplest way
> IMO.

But the problem is fundamentally hard.  I do not want to encourage
people to make changes without thinking through all of the consequences.

So far my impression is that an additional per-architecture data area
is struct kimage encourages people to be sloppy, and it moves key structures
farther from where they are used.  I am coming to suspect it is as bad
as ioctl.

I could probably be convinced with a good use of a per-architecture
area and a well reasoned argument.  But at the moment changing the
infrastructure is unnecessary noise, so please drop that for now.

>> Part of the reason is you do more than one thing at a time, which makes
>> review much more difficult than it needs to be.
>
> Yeah, I know. I'm sorry about that. I took some time to split the
> patches in the most logical way I could think of. The reason behind
> not separating the segment code and the page_table_a code was that
> they both touched more or less the same lines.

Dependent patches are not a problem.

> And by global structure you mean the dynamically allocated struct
> kimage? If you find that abusive then I think that _not_ using an
> already existing structure is abusive. =)
>
> I just want to keep things as simple as possible.

Simplicity is good.  

Doing unnecessary things is confusing and the issue is not good,
and at least until the Xen support is merged you were doing
unnecessary things.

Please just take it carefully.  This is possibly the hardest
to debug code path in the kernel and currently it works.  I
don't want to break that.

Eric
