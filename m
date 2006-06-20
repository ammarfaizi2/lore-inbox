Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbWFTGZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWFTGZE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbWFTGZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:25:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9427 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965080AbWFTGZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:25:01 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Petr Baudis <pasky@suse.cz>, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [RESEND][PATCH] Let even non-dumpable tasks access /proc/self/fd
References: <20060616124157.GB24203@pasky.or.cz>
	<20060619204851.84467440.akpm@osdl.org>
Date: Tue, 20 Jun 2006 00:24:30 -0600
In-Reply-To: <20060619204851.84467440.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 19 Jun 2006 20:48:51 -0700")
Message-ID: <m1veqwfiox.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Fri, 16 Jun 2006 14:41:57 +0200
> Petr Baudis <pasky@suse.cz> wrote:
>
>> All tasks calling setuid() from root to non-root during their lifetime
>> will not be able to access their /proc/self/fd.  This is troublesome
>> because the fstatat() and other *at() routines are emulated by accessing
>> /proc/self/fd/*/path and that will break with setuid()ing programs,
>> leading to various weird consequences (e.g. with the latest glibc,
>> nftw() does not work with setuid()ing programs on ppc and furthermore
>> causes the LSB testsuite to fail because of this).
>
> Odd. Did something actually change in glibc to make this start happening?
>
>> This kernel patch fixes the problem by letting the process access its
>> own /proc/self/fd - as far as I can see, this should be reasonably safe
>> since for the process, this does not reveal "anything new". Feel free to
>> comment on this.
>> 
>
> Eric, Chris - any thought on this one?

This can't fix the glibc emulation problem.  As the kernel
this patch would apply to doesn't need emulation.

The basic goal of allowing the current process to access it's
own proc directories is reasonable.

I don't like the implementation. It is not obvious that this case
applies just to the current process.

I admit that any permission checking in /proc that happens at
open time instead of at access time is buggy but that is
the best we have right now.

Anything more requires a very close review.


Eric
