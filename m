Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbWHWRLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWHWRLx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 13:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWHWRLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 13:11:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52113 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965067AbWHWRLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 13:11:52 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Ian Campbell <Ian.Campbell@XenSource.com>, Andrew Morton <akpm@osdl.org>,
       Virtualization <virtualization@lists.osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Translate asm version of ELFNOTE macro into	preprocessor macro
References: <1156333761.12949.35.camel@localhost.localdomain>
	<44EC6B12.4060909@goop.org>
	<1156346074.12949.129.camel@localhost.localdomain>
	<44EC72F3.70505@goop.org>
Date: Wed, 23 Aug 2006 11:11:12 -0600
In-Reply-To: <44EC72F3.70505@goop.org> (Jeremy Fitzhardinge's message of "Wed,
	23 Aug 2006 08:23:31 -0700")
Message-ID: <m1sljnml73.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> Ian Campbell wrote:
>>> OK, seems reasonable.  Eric Biederman solved this by having NOTE/ENDNOTE (or
>>> something like that) in his "bzImage with ELF header" patch, but I don't
>>> remember it being used in any way which is incompatible with using a CPP
>>> macro.
>>>
>>
>> I can't find that patch, does NOTE/ENDNOTE just do the push/pop .note
>> section?
>>
>> That would solve the problem with the first argument of the macro being
>> a string but the final argument could still be for .asciz note contents.
>>
>
> It looks like:
>
> .macro note name, type
>      .balign 4
>      .int    2f - 1f            # n_namesz
>      .int    4f - 3f            # n_descsz
>      .int    \type            # n_type
>      .balign 4
> 1:    .asciz "\name"
> 2:    .balign 4
> 3:
> .endm
> .macro enote
> 4:    .balign 4
> .endm
>
>
> so it allows you to put arbitrary stuff in the desc part of the note.  The
> downside is that its a little more cumbersome syntactically for the common case.

I don't expect it to be much more cumbersome, as two pieces, and you need the extra
alignment at the end to ensure each not entry is 4 byte aligned.  Being able to
push and pop a section wouldn't hurt either. 

Eric

