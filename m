Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbUELFG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUELFG3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 01:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbUELFG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 01:06:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19868 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262963AbUELFG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 01:06:26 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: fastboot@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [announce] kexec for linux 2.6.6
References: <20040511212625.28ac33ef.rddunlap@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 May 2004 23:05:13 -0600
In-Reply-To: <20040511212625.28ac33ef.rddunlap@osdl.org>
Message-ID: <m1ekpq5j7a.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> kexec for Linux 2.6.6 is now available at:
> http://developer.osdl.org/rddunlap/kexec/2.6.6/
> 
> 
> kexec userspace tools are at:
> http://developer.osdl.org/rddunlap/kexec/kexec-tools/
> 
> 
> For 2.6.6, the kexec_load syscall number had to move due to
> some new syscall additions in 2.6.6.  However, I didn't
> update the kexec userspace program for that 1-line change.
> The change is in kexec-syscall.c, line 46:
> 
> change
> #define __NR_kexec_load 274
> to
> #define __NR_kexec_load 283
> 
> (for i386).
> 
> There is one outstanding patch from Albert Herranz
> that I will review and possibly use/merge soon.
> His email is here:
>   http://lists.osdl.org/pipermail/fastboot/2004-May/000290.html
> 
> 
> And if anyone has suggestions for handling a variable/moving
> syscall number (target), I'm interested in hearing them.

The easiest would be to update the ./configure script, and
have the syscall number as a parameter.  Quite possibly it
could just point to an appropriate file that would grep for 
__NR_kexec_load.  This does not prevent the recompile problem
but it does help a little.

On the issue of needing $BIGNUM testers, I see a small challenge.
kexec is near useless on an unstable kernel.  So it really needs
to get into a stable series or people will be fighting kernel
bugs so much that they won't be able to see kexec specific issues.

Possibly the sanest route is 2.7.early and then 2.6 at about
the same time.  At any point that kexec makes it into a mainline
kernel though the syscall number will be frozen and things will
get easier.

Eric

