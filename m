Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265114AbUELPzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265114AbUELPzv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 11:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbUELPzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 11:55:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50334 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265115AbUELPzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 11:55:49 -0400
To: Ulrich Drepper <drepper@redhat.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, fastboot@lists.osdl.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
References: <20040511212625.28ac33ef.rddunlap@osdl.org>
	<40A1AF53.3010407@redhat.com>
	<m13c66qicb.fsf@ebiederm.dsl.xmission.com> <40A243C8.401@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 May 2004 09:54:28 -0600
In-Reply-To: <40A243C8.401@redhat.com>
Message-ID: <m1brktod3f.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> writes:

> Eric W. Biederman wrote:
> 
> 
> >>  sym = dlsym (RTLD_DEFAULT, "the_symbol_name")
> > [...]
> 
> > 
> > For the momen the only finished port is x86, so we should be able
> > to do that, it would make the kernel patch a little bigger though.
> > Last time I saw that conversation I thought you didn't like symbols in
> > the vdso for syscalls because it slowed things down.
> 
> I don't want to  use this in glibc for every syscall.  But for your
> random application in need of a syscall it's fine.

The question that had come up earlier was fast path syscalls like
gettimeofday.

> And there is one more thing: the above code is actually not what should
> be used.  The symbol able entries should be position independent.  So
> one will have to compute the final address (which will be fun for archs
> with function descriptors).  I'll have to see how randomization is
> actually implemented.  The __kernel_vsyscall symbol is probably not
> changed, so we need an out-of-band mechanisms to report the load address
> to the userlevel code.

We currently have AT_SYSINFO_EHDR and AT_SYSINFO which should
report the basic location information.

As a first draft we should be able to use the standard ELF mechanisms
for this.  It is not like PIC shared libraries were new.   Or is
there some specific problem you are thinking of with respect to
randomization?

Eric
