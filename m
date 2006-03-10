Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752171AbWCJJ5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbWCJJ5f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 04:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbWCJJ5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 04:57:35 -0500
Received: from ns2.suse.de ([195.135.220.15]:3800 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752171AbWCJJ5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 04:57:34 -0500
Message-ID: <44114DD9.10007@suse.de>
Date: Fri, 10 Mar 2006 10:58:49 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix ELF entry point (i386)
References: <43FC4682.6050803@suse.de>	<m1bqwkc0l1.fsf@ebiederm.dsl.xmission.com> <440C363F.8000503@suse.de>	<m1r75f8k21.fsf@ebiederm.dsl.xmission.com> <440D8D97.6000300@suse.de> <m1y7zm16nn.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1y7zm16nn.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> Ok. The unmerged Xen case.
> 
> I have some pending patches that make a bzImage a ET_DYN executable.
> Would that be interesting to you?  Especially if that would just mean
> your initial page tables got to set physical == virtual?

i.e. you insert a additional state into the boot process which does the
relocation and page table setup?  URL would to the patch be nice, yes.
A paper (or at least a short outline how it works) even better ;)

> I believe Xen does expose the actual physical addresses to the guest.

Well, xen has two modes now:  One where the guest knows the machine
addresses and has to translate machine[1] <=> physical[2] addresses.
And one where xen does the translation transparantly.  The former
performs better, the later is easier to implement ;)

> Either that or this is a case where Xen probably needs to take a
> different path in the build system.

For the build system it shouldn't matter.  Ideally only the code
creating page tables has to care about that.  Right now xen creates
old-style ELF binaries (pre-kexec merge) with wrong paddr entries, but
that's fixable (have patches pending for xen).

Unlike real hardware xen virtual machines run with paging enabled all
the time, so you can't just turn off paging to get a identity (phys ==
virt) mapping.  That makes things a bit harder sometimes.

  Gerd

[1] machine address  == physical address of the real hardware.
[2] physical address == physical address of the virtual machine.

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg
