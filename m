Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262320AbTCMNVF>; Thu, 13 Mar 2003 08:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262329AbTCMNVF>; Thu, 13 Mar 2003 08:21:05 -0500
Received: from ns.suse.de ([213.95.15.193]:30734 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262320AbTCMNVE>;
	Thu, 13 Mar 2003 08:21:04 -0500
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is get_current() not const function?
References: <20030313061926.S3910@devserv.devel.redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Mar 2003 14:31:50 +0100
In-Reply-To: Jakub Jelinek's message of "13 Mar 2003 12:23:14 +0100"
Message-ID: <p73ptov4cl5.fsf@amdsimf.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek <jakub@redhat.com> writes:

> E.g. on x86-64,
>         NEW_AUX_ENT(AT_UID, (elf_addr_t) current->uid);
>         NEW_AUX_ENT(AT_EUID, (elf_addr_t) current->euid);
>         NEW_AUX_ENT(AT_GID, (elf_addr_t) current->gid);
>         NEW_AUX_ENT(AT_EGID, (elf_addr_t) current->egid);
> results in 4 movq %gs:0,%rax instructions while one is completely
> enough.
> Anyone remembers why get_current function (on arches which define
> current to get_current()) is not const and why on x86-64

I tried it once. Then spent a day in fixing all the obvious problems
(addings lots of compile barriers to early bootup and the scheduler 
to make it boot again etc.)

In the end I gave up because there were some weird crashes left
and I ran out of time on this one.

Feel free to retry it, but it'll be lots of work I suspect.

-Andi
