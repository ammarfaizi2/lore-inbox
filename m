Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWCGRzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWCGRzs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCGRzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:55:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18395 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751407AbWCGRzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:55:47 -0500
To: Gerd Hoffmann <kraxel@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix ELF entry point (i386)
References: <43FC4682.6050803@suse.de>
	<m1bqwkc0l1.fsf@ebiederm.dsl.xmission.com> <440C363F.8000503@suse.de>
	<m1r75f8k21.fsf@ebiederm.dsl.xmission.com> <440D8D97.6000300@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Mar 2006 10:55:24 -0700
In-Reply-To: <440D8D97.6000300@suse.de> (Gerd Hoffmann's message of "Tue, 07
 Mar 2006 14:41:43 +0100")
Message-ID: <m1y7zm16nn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Hoffmann <kraxel@suse.de> writes:

>> Currently my assumptions are:
>> 
>> Standalone executables load at the physical not the virtual addresses.
>> Standalone executables start executing at a physical address and not at
>> a virtual address.
>
> Well, that is true for real hardware.  xen guest kernels are booted with
> paging already enabled and thus the entry point is in virtual memory,
> and I'm trying to figure how to handle that best (both for initial boot
> and kexec).
>
> xen uses a special xen header anyway to give the domain builder a hint
> how the initial page tables should look like (they look simliar to what
> head.S creates on real hardware).  That can also be used to figure the
> correct virtual entry point from the physical one.  It probably even
> makes more sense to do that (instead of writing the virtual address into
> the entry point) as the xen domain builder doesn't look at the virtual
> addresses in the ELF headers too.  It uses PAGE_OFFSET+paddr instead.
> That keeps the differences between real and virtual hardware small ...

Ok. The unmerged Xen case.

I have some pending patches that make a bzImage a ET_DYN executable.
Would that be interesting to you?  Especially if that would just mean
your initial page tables got to set physical == virtual?

I believe Xen does expose the actual physical addresses to the guest.

Either that or this is a case where Xen probably needs to take a
different path in the build system.

Eric


