Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTENJqd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 05:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTENJqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 05:46:33 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:35640 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261827AbTENJqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 05:46:32 -0400
Date: Wed, 14 May 2003 03:00:31 -0700
From: Andrew Morton <akpm@digeo.com>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: jgarzik@pobox.com, dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PAG support only
Message-Id: <20030514030031.13f7bf8f.akpm@digeo.com>
In-Reply-To: <18809.1052905491@warthog.warthog>
References: <20030513175240.6313ea92.akpm@digeo.com>
	<18809.1052905491@warthog.warthog>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 09:59:15.0048 (UTC) FILETIME=[79FCEE80:01C319FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@warthog.cambridge.redhat.com> wrote:
>
> 
> So you'd rather have:

Doesn't matter.

We want all the code looking the same, and that is more important than the
arguable benefit of the minor changes which you propose.

> 	long sys_setpag(pag_t pag)
> 	{
> 		if (pag > 0)		return vfs_join_pag(pag);
> 		else if (pag == 0)	return vfs_leave_pag();
> 		else if (pag == -1)	return vfs_new_pag();
> 		else			return -EINVAL;
> 	}

If someone else comes along and makes changes to this, you'll end up with a
mix of styles.

> > and syscalls should return long, not int.
> 
> Fair enough, but in arch/i386/kernel/process.c:
> 
> 	asmlinkage int sys_fork(struct pt_regs regs)
> 	asmlinkage int sys_clone(struct pt_regs regs)
> 	asmlinkage int sys_vfork(struct pt_regs regs)
> 	asmlinkage int sys_execve(struct pt_regs regs)
> 	etc...
> 
> Should these be fixed too (the i386 arch is referred to quite a lot)?

I don't know really.  David M-T said "syscalls should return long".  I'm
not sure why - perhaps it's only those which need 32-bit wrappers (guess).

