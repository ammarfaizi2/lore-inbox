Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262239AbTCMLIk>; Thu, 13 Mar 2003 06:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262241AbTCMLIk>; Thu, 13 Mar 2003 06:08:40 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:35850 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262239AbTCMLIj>; Thu, 13 Mar 2003 06:08:39 -0500
Date: Thu, 13 Mar 2003 06:19:26 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Why is get_current() not const function?
Message-ID: <20030313061926.S3910@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

E.g. on x86-64,
        NEW_AUX_ENT(AT_UID, (elf_addr_t) current->uid);
        NEW_AUX_ENT(AT_EUID, (elf_addr_t) current->euid);
        NEW_AUX_ENT(AT_GID, (elf_addr_t) current->gid);
        NEW_AUX_ENT(AT_EGID, (elf_addr_t) current->egid);
results in 4 movq %gs:0,%rax instructions while one is completely
enough.
Anyone remembers why get_current function (on arches which define
current to get_current()) is not const and why on x86-64
the movq %%gs:0, %0 inline asm is volatile with "memory" clobber?
AFAIK current ought to be constant in any function with the exception of
schedule.
If the reason is kernel/sched.c, then IMHO it is certainly
worth making get_current const everywhere but in kernel/sched.c
(e.g. through special define in sched.c before any includes).

	Jakub
