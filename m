Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWCGNkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWCGNkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 08:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWCGNkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 08:40:40 -0500
Received: from mail.suse.de ([195.135.220.2]:7314 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750729AbWCGNkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 08:40:39 -0500
Message-ID: <440D8D97.6000300@suse.de>
Date: Tue, 07 Mar 2006 14:41:43 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix ELF entry point (i386)
References: <43FC4682.6050803@suse.de>	<m1bqwkc0l1.fsf@ebiederm.dsl.xmission.com> <440C363F.8000503@suse.de> <m1r75f8k21.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1r75f8k21.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Currently my assumptions are:
> 
> Standalone executables load at the physical not the virtual addresses.
> Standalone executables start executing at a physical address and not at
> a virtual address.

Well, that is true for real hardware.  xen guest kernels are booted with
paging already enabled and thus the entry point is in virtual memory,
and I'm trying to figure how to handle that best (both for initial boot
and kexec).

xen uses a special xen header anyway to give the domain builder a hint
how the initial page tables should look like (they look simliar to what
head.S creates on real hardware).  That can also be used to figure the
correct virtual entry point from the physical one.  It probably even
makes more sense to do that (instead of writing the virtual address into
the entry point) as the xen domain builder doesn't look at the virtual
addresses in the ELF headers too.  It uses PAGE_OFFSET+paddr instead.
That keeps the differences between real and virtual hardware small ...

cheers,

  Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg
