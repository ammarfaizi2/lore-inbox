Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVESBtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVESBtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 21:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVESBtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 21:49:15 -0400
Received: from one.firstfloor.org ([213.235.205.2]:26501 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262436AbVESBtK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 21:49:10 -0400
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 32bit processes at compatbility mode on x86_64 machines fail to
 restart syscall after processing a signal
References: <8126E4F969BA254AB43EA03C59F44E84021E9C58@pdsmsx404>
From: Andi Kleen <ak@muc.de>
Date: Thu, 19 May 2005 03:49:10 +0200
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E84021E9C58@pdsmsx404> (Yanmin
 Zhang's message of "Thu, 19 May 2005 09:18:59 +0800")
Message-ID: <m164xgyoh5.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zhang, Yanmin" <yanmin.zhang@intel.com> writes:

> The test case at
> http://cvs.sourceforge.net/viewcvs.py/posixtest/posixtestsuite/conforman
> ce/interfaces/clock_nanosleep/1-5.c fails if it runs as a 32bit process
> on x86_86 machines.
>
> The root cause is the sub 32bit process fails to restart the syscall
> after it is interrupted
> by a signal.
>
> The syscall number of sys_restart_syscall in table sys_call_table is 
> __NR_restart_syscall (219) while it's __NR_ia32_restart_syscall (0) in
> ia32_sys_call_table. When regs->rax==(unsigned
> long)-ERESTART_RESTARTBLOCK,
> function do_signal doesn't distinguish if the process is 64bit or 32bit,
> and always sets
> restart syscall number as __NR_restart_syscall (219).

Thanks for tracking this down. Queued.

-Andi

