Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWBWFDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWBWFDt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 00:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWBWFDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 00:03:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42896 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751267AbWBWFDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 00:03:48 -0500
To: Jakub Jelinek <jakub@redhat.com>
Cc: Ulrich Drepper <drepper@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Paul Jackson <pj@sgi.com>, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V4
References: <20060221084631.GA5506@elte.hu>
	<20060221092338.GV24295@devserv.devel.redhat.com>
	<a36005b50602210826i567effabsd4b43da9804db86d@mail.gmail.com>
	<20060221163710.GX24295@devserv.devel.redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 22 Feb 2006 22:01:51 -0700
In-Reply-To: <20060221163710.GX24295@devserv.devel.redhat.com> (Jakub
 Jelinek's message of "Tue, 21 Feb 2006 11:37:10 -0500")
Message-ID: <m18xs24qio.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek <jakub@redhat.com> writes:

> On Tue, Feb 21, 2006 at 08:26:05AM -0800, Ulrich Drepper wrote:
>> > The `len' argument (or really revision of the structure if really needed)
>> > can be encoded in the structure, as in:
>> > struct robust_list_head {
>> >        struct robust_list list;
>> >        short robust_list_head_len; /* or robust_list_head_version ? */
>> >        short futex_offset;
>> >        struct robust_list __user *list_op_pending;
>> > };
>> > or with long futex_offset, but using say upper 8 bits of the field as
>> > version or length.
>> 
>> I know you want to save SPARC but this kind of overloading I don't
>> really like.  If you need special treatment of the futex value make
>> this explicit and arch-dependent.
>
> This had nothing to do with SPARC actually, I only wanted to avoid
> passing two extra arguments to clone rather than one.  But if you think
> CLONE_CHILD_SETROBUST is unnecessary, so be it and the combined
> set_tid_robust_address call can have tidptr, robustptr and robustlen
> arguments.

Not to be dense.  But can you actually measure the syscall overhead
you are trying to optimize out?

Especially where Ulrich was starting to ask for something that reminded
me of posix_spawn, I get a little nervous.  My gut feel is that 2
simple cheap syscalls, are comparable to one very configurable syscall.

I don't count cycles regularly so I don't know for certain, but lets
at least look before we leap.

Eric
