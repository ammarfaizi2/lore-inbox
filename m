Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265105AbUELPem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbUELPem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 11:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbUELPem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 11:34:42 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:60557
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S265105AbUELPeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 11:34:13 -0400
Message-ID: <40A243C8.401@redhat.com>
Date: Wed, 12 May 2004 08:33:28 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a) Gecko/20040511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, fastboot@lists.osdl.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
References: <20040511212625.28ac33ef.rddunlap@osdl.org>	<40A1AF53.3010407@redhat.com> <m13c66qicb.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m13c66qicb.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:


>>  sym = dlsym (RTLD_DEFAULT, "the_symbol_name")
> [...]

> 
> For the momen the only finished port is x86, so we should be able
> to do that, it would make the kernel patch a little bigger though.
> Last time I saw that conversation I thought you didn't like symbols in
> the vdso for syscalls because it slowed things down.

I don't want to  use this in glibc for every syscall.  But for your
random application in need of a syscall it's fine.

And there is one more thing: the above code is actually not what should
be used.  The symbol able entries should be position independent.  So
one will have to compute the final address (which will be fun for archs
with function descriptors).  I'll have to see how randomization is
actually implemented.  The __kernel_vsyscall symbol is probably not
changed, so we need an out-of-band mechanisms to report the load address
to the userlevel code.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
