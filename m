Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264242AbUENFWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbUENFWk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 01:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbUENFWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 01:22:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5566 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264242AbUENFWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 01:22:37 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: akpm <akpm@osdl.org>, fastboot@lists.osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
References: <20040511212625.28ac33ef.rddunlap@osdl.org>
	<40A1AF53.3010407@redhat.com>
	<m13c66qicb.fsf@ebiederm.dsl.xmission.com> <40A243C8.401@redhat.com>
	<m1brktod3f.fsf@ebiederm.dsl.xmission.com>
	<40A2517C.4040903@redhat.com>
	<m17jvhoa6g.fsf@ebiederm.dsl.xmission.com>
	<20040512143233.0ee0405a.rddunlap@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 May 2004 23:21:11 -0600
In-Reply-To: <20040512143233.0ee0405a.rddunlap@osdl.org>
Message-ID: <m1wu3fy46w.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> On 12 May 2004 10:57:27 -0600 Eric W. Biederman wrote:
> 
> | Ulrich Drepper <drepper@redhat.com> writes:
> | 
> | > Eric W. Biederman wrote:
> | > 
> | > > As a first draft we should be able to use the standard ELF mechanisms
> | > > for this.  It is not like PIC shared libraries were new.   Or is
> | > > there some specific problem you are thinking of with respect to
> | > > randomization?
> | > 
> | > The official kernel does not have vdso randomization.  Ingo has a patch
> | > for the Red Hat kernel which is used in the FC2 kernel.  The patch
> | > effectively only changes the location at which the vdso is mapped.  It
> | > does not change the vdso content.  So the __kernel_vsyscall symbol in
> | > the vdso's symbol table is not changed.
> 
> [1:]
> | > AT_SYSINFO is the right way to go forward but it is not directly
> | > accessible to userlevel code.  And it is no pointer which will make
> | > architectures with function descriptors unhappy.
> | 
> | It sounds like the vdso just needs to be treated as a prelinked
> | vdso.  You can find everything you need with AT_SYSINFO_EHDR.
> | 
> | In the case of function descriptors they should be in a data segment
> | that can get copied to another page, and corrected.  Leaving the code
> | segment at it's randomized location.
> 
> Andrew tells me that he is OK with reserving a syscall number for
> kexec, which is easy & quick.  I don't know when vdso will be available
> (for non-x86[2]) or when the AT_SYSINFO data will work for userlevel
> code[1. above].
> 
> So is there any reason not to reserve the syscall number for kexec
> for now?  (patch is below)
> 
> --
> ~Randy
> 
> 
> [2] kexec is currently only available for x86, but there is interest
> in it for ia64 and ppc64 at least.

Also been work on x86-64 and ppc32.   So if we are going to reserve
syscall numbers  it would also be nice to have those reserved as well.

Eric
