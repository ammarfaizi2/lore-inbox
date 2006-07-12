Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWGLRoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWGLRoE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWGLRoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:44:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27364 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932171AbWGLRoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:44:01 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ulrich Drepper <drepper@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <m1psgdkrt8.fsf@ebiederm.dsl.xmission.com>
	<20060710155051.326e49da.rdunlap@xenotime.net>
	<m1veq4kcij.fsf@ebiederm.dsl.xmission.com>
	<1152601640.3128.7.camel@laptopd505.fenrus.org>
	<m1irm2bxk3.fsf_-_@ebiederm.dsl.xmission.com>
	<44B5283E.7090806@redhat.com>
Date: Wed, 12 Jul 2006 11:42:47 -0600
In-Reply-To: <44B5283E.7090806@redhat.com> (Ulrich Drepper's message of "Wed,
	12 Jul 2006 09:50:06 -0700")
Message-ID: <m1hd1mafe0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> writes:

> Eric W. Biederman wrote:
>> But uname is noticeably faster than sysctl and uname is more portable
>> across linux flavors.  So updating the glibc pthread code to use
>> uname looks like the right way to implement is_smp_system. 
>
> This is (was?) not the universal through.  We used uname at some point
> but then I did some profiling and sysctl turned out to be faster.

I track the code bask as far as I could and back to about 2000 in
pthread.c when the code was introduced it always used sys_sysctl.

> If the reverse is true now I can certainly look into changing this but
> the evidence and ideally has to be there.  The simplicity of the uname
> code should mean that it's faster.

The evidence and ideally what has to be there?

> In a year or two I'll remove the test anyway.  By then there will likely
> not be any UP kernels on reasonable machines anymore and I can drop all
> the conditional code.

Well there are embedded targets but I guess uclibc takes care of them.

Unless a darn good reason for keeping it is found, sys_sysctl won't be
in the kernel several months from now.  And uname is faster by a large
margin than /proc.

Right now because there has been a deprecated note in
"include/linux/sysctl.h" since 2003 people currently feel fine with
letting sys_sysctl code bit rot.  I am trying to resolve that
situation most likely by just updating the few stray pieces of user
space that care and then cutting out that chunk of kernel code.

Eric


