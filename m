Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVANRAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVANRAe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 12:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVANRAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 12:00:34 -0500
Received: from pool-151-203-218-166.bos.east.verizon.net ([151.203.218.166]:4868
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262019AbVANRA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 12:00:28 -0500
Message-Id: <200501141922.j0EJMKnV003227@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: blaisorblade_spam@yahoo.it
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 02/11] uml: fix compilation for missing headers 
In-Reply-To: Your message of "Thu, 13 Jan 2005 22:00:51 +0100."
             <20050113210051.99326AB30@zion> 
References: <20050113210051.99326AB30@zion> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 14 Jan 2005 14:22:20 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade_spam@yahoo.it said:
> If you think it cannot make sense to include both <sys/ptrace.h> and
> <linux/ptrace.h> (as userspace process, i.e. host includes), go
> complaining with glibc, or follow the linux-abi includes idea.

> However, the compilation failure is possibly glibc-version (or better
> glibc includes version) related - what I now is that the failure
> happens on my system with a glibc 2.3.4 (from Gentoo).

> Also, remove some syscalls from the syscall table, since some syscalls
> were added which are only inside -mm currently, and this prevents
> currently compilation. 

Hold off on this one.  I have different fixes for this in my tree.

The system ptrace headers (asm/ptrace.h, sys/ptrace.h, linux/ptrace.h) have
varying effects, depending on distro and architecture.  So, I decided to put
sysdep/ptrace_user.h in charge of supplying the system ptrace information to
the rest of UML.  This has some ripple effects which I am in the process of
sorting out.

On the system calls, I have them indef-ed depending on whether one of the
__NR_vperf symbols are defined.  This will go away when the entry points
are in both -mm and -linus.

				Jeff

