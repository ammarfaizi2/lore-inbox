Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030739AbWKOR1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030739AbWKOR1R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030746AbWKOR1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:27:17 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27112 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030739AbWKOR1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:27:16 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Pavel Machek <pavel@ucw.cz>
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, akpm@osdl.org, ak@suse.de,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com
Subject: Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
References: <20061113162135.GA17429@in.ibm.com>
	<20061113164314.GK17429@in.ibm.com> <20061114163002.GB4445@ucw.cz>
	<m1fyclk8ws.fsf@ebiederm.dsl.xmission.com>
	<20061114234334.GB3394@elf.ucw.cz>
Date: Wed, 15 Nov 2006 10:26:12 -0700
In-Reply-To: <20061114234334.GB3394@elf.ucw.cz> (Pavel Machek's message of
	"Wed, 15 Nov 2006 00:43:34 +0100")
Message-ID: <m1lkmc4o5n.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Vivek.  It looks like the patch had whitespace damage sometime in it's
history.  Do you know what happened to the to make the indentation
inconsistent?  I'm pretty certain the version I generated didn't have
that problem.

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
>> >> I don't have a configuration I can test this but it compiles cleanly
>> >
>> > Ugh, now that's a big patch.. and untested, too :-(.
>> 
>> It was very carefully code reviewed at least the first time,
>> and the code was put in sync with code that was tested.
>
> So we had two very different versions of "switch to 64-bit" and now we
> have two mostly similar versions. Not a big improvement...

Well we had two versions.  It looks like the acpi wakeup was a cut
and past of the primary kernel entry path, and it diverged and
was less well maintained because it is less considered and get's used
less often.

>> > Can we get it piece-by-piece?
>
> Please?

I honestly think it would make the change  less reviewable.

>> >> Vivek has tested this patch for suspend to memory and it works fine.
>> >
>> > Ok, so it was tested on one config. Given that the patch deals with
>> > detecting CPU oddities... :-(
>> 
>> Read the code.  Given your scorn and the state of that mess when I
>> started I'm not certain a productive conversation can be had.
>> 
>> Do you understand the code as it is currently written?
>
> Mostly. I've written it at some point.
>
> It may be a mess, but patch below is wholesale rewrite, mixing
> cleanups (ebx->rbx) with serious changes (PGE). And then you tell me
> it was tested on one machine. It is hard/impossible to rewrite, and
> changelog is not helpful, either.

So there is one major change in the patch.  Modifying the trampoline
to take the code all of the way to 64bit mode, allowing us to switch
to a kernel that is loaded above 4GB.  Essentially everything else is
required by that change.

The basic point is that I am completely changing the idiom for how
cpus enter the kernel.  If you focus on the details the change and
miss the primary change itself you will simply not understand what
is happening.  The PGE change just happens to be part of the change
in requirements for entering the kernel.

The code paths that are changed are not conditional code they will
always execute.  So a single test tells us a lot.

I just looked at the patch again, and it really is not that large.
At this point I'm afraid splitting it up is more likely to cause
review problems then the other way around.  I don't any of the
cleanups touch a code path I don't need to touch.

As for the hard/impossible to rewrite. It was a bit tedious because
of all of the picky details, but I didn't find it hard.  I suspect this
is just a skill set difference.  Or the fact that I wasn't messing
with the actual code that interfaces with acpi.

Eric
