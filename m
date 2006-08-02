Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWHBKBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWHBKBG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 06:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWHBKBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 06:01:06 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11445 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750721AbWHBKBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 06:01:04 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Magnus Damm" <magnus.damm@gmail.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, "Jan Kratochvil" <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, "Vivek Goyal" <vgoyal@in.ibm.com>,
       "Linda Wang" <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<aec7e5c30608012334y42e947e6ge935e5d866f78c84@mail.gmail.com>
	<m1lkq7txz0.fsf@ebiederm.dsl.xmission.com>
	<aec7e5c30608020134h2d0f9955p34a0cd76d8836acd@mail.gmail.com>
Date: Wed, 02 Aug 2006 03:59:17 -0600
In-Reply-To: <aec7e5c30608020134h2d0f9955p34a0cd76d8836acd@mail.gmail.com>
	(Magnus Damm's message of "Wed, 2 Aug 2006 17:34:44 +0900")
Message-ID: <m1r6zzsbka.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Magnus Damm" <magnus.damm@gmail.com> writes:

> On 8/2/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> "Magnus Damm" <magnus.damm@gmail.com> writes:
>> > Eric, could you please list the advantages of your run-time relocation
>> > code over my incomplete relocate-in-userspace prototype posted to
>> > fastboot a few weeks ago?
>>
>> If you watch an architecture evolve one thing you will notice is that
>> the kinds of relocations keep growing.  An ever growing list of things
>> to for the bootloader to do is a pain.  Especially when bootloaders
>> generally need to be as simple and as fixed as possible because bootloaders
>> are not something you generally want to update.
>
> I agree that updating bootloaders is something you want to avoid. I'm
> not however sure that I would call kexec-tools a bootloader...

On the truly insane possibilities.  It is actually possible to load
a relocated bzImage.  run setup16.S below 1M and have it jump
to the kernel at any address below 4G.

>> Beyond that if you look at head.S the code to process the relocations
>> (after I have finished post processing them at build time) is 9 instructions.
>> Which is absolutely trivial, at least for now.
>
> Yeah, but the 33 patches are touching more than 9 instructions. =)

True.  I at of that is general clean ups to allow the kernel to be
relocated though.  Not to actually perform the relocation.

> One binary to rule them all... If that is true, is there any simple
> way then to extract vmlinux from the bzImage?

Unfortunately the process is a little lossy :(

So that still means you still need the vmlinux to get the debug
symbols.


Eric
