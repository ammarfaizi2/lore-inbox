Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261806AbSJ2LDI>; Tue, 29 Oct 2002 06:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSJ2LDI>; Tue, 29 Oct 2002 06:03:08 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:42448 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261806AbSJ2LDG>; Tue, 29 Oct 2002 06:03:06 -0500
To: Andreas Gruenbacher <agruen@suse.de>
Cc: <chris@scary.beasts.org>, <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH][RFC] 2.5.44 (1/2): Filesystem capabilities kernel patch
References: <Pine.LNX.4.33.0210282327520.8990-100000@sphinx.mythic-beasts.com>
	<200210290323.09565.agruen@suse.de>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Tue, 29 Oct 2002 12:09:08 +0100
Message-ID: <87n0oxmrhn.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> writes:

> On Tuesday 29 October 2002 00:36, chris@scary.beasts.org wrote:
>> I'm not sure what the current glibc security check is, but it used to be
>> simple *uid() vs. *euid() checks. This would not catch an executable with
>> filesystem capabilities.
>> Have a look at
>> http://security-archive.merton.ox.ac.uk/security-audit-199907/0192.html
[...]
>> I think the eventual plan was that we pass the kernel's current->dumpable
>> as an ELF note. Not sure if it got done. Alternatively glibc could use
>> prctl(PR_GET_DUMPABLE).
>
> Sorry, I don't know exactly what was your plan here. Could you please explain?

Judging from the mail archive above: instead of checking uid vs. euid
and gid vs. egid, ask the kernel and grant or deny LD_PRELOAD
according to the dumpable flag (see prctl(2)). This flag is set to
false, if uid != euid, etc. So, this flag could be used/cleared by
capabilities as well.

> A perhaps unrelated note: We once had Pavel Machek's elfcap implementation, in 
> which capabilities were stored in ELF. This was a bad idea because being able 
> to create executables does not imply the user is capable of CAP_SETFCAP, and 
> users shouldn't be able to freely choose their capabilities :-] We still want 

I remember this hack and since I hear this claim every now and then, I
downloaded his patch and verified with the source. Pavel's capability
patch was about _restricting_ not granting capabilities, so it's more
like an inheritable, rather than a permitted, set.

At least that was his intention. I didn't verify this with the
appropriate kernel sources from 1999.

Regards, Olaf.
