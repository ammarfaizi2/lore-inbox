Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263748AbTCVRRy>; Sat, 22 Mar 2003 12:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263739AbTCVRRw>; Sat, 22 Mar 2003 12:17:52 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64715 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263714AbTCVRRv>; Sat, 22 Mar 2003 12:17:51 -0500
Date: Sat, 22 Mar 2003 17:28:54 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4+ptrace exploit fix breaks root's ability to strace
Message-ID: <20030322172854.B12071@devserv.devel.redhat.com>
References: <20030322103121.A16994@flint.arm.linux.org.uk> <1048345130.8912.9.camel@irongate.swansea.linux.org.uk> <20030322141006.A8159@flint.arm.linux.org.uk> <1048346885.1708.2.camel@laptop.fenrus.com> <20030322171312.H8712@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030322171312.H8712@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Mar 22, 2003 at 05:13:12PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 05:13:12PM +0000, Russell King wrote:
> 
> int ptrace_check_attach(struct task_struct *child, int kill)
> {
> 	...
> +       if (!is_dumpable(child))
> +               return -EPERM;
> }
> 
> So, we went from being able to ptrace daemons as root, to being able to
> attach daemons and then being unable to do anything with them, even if
> you're root (or have the CAP_SYS_PTRACE capability).  I think this
> behaviour is getting on for being described as "insane" 8) and is
> clearly wrong.

ok it seems this check is too strong. It *has* to check
child->task_dumpable and return -EPERM, but child->mm->dumpable is not
needed. 
