Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSHFP7E>; Tue, 6 Aug 2002 11:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSHFP7E>; Tue, 6 Aug 2002 11:59:04 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:28809 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S311025AbSHFP7D>; Tue, 6 Aug 2002 11:59:03 -0400
Date: Tue, 6 Aug 2002 18:02:02 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode
Message-Id: <20020806180202.66f1865a.us15@os.inf.tu-dresden.de>
In-Reply-To: <200208061412.g76ECPB13837@karaya.com>
References: <20020806150447.2af350b0.us15@os.inf.tu-dresden.de>
	<200208061412.g76ECPB13837@karaya.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Aug 2002 10:12:25 -0400
Jeff Dike <jdike@karaya.com> wrote:

> Indeed.  I misread the !capable(CAP_KILL) as "I am not allowed to kill the
> other guy", which clearly you are when you just forked it.
> This looks like a bug to me.  If you own the process, you can send it any
> signal you want, so you should be allowed to sign it up for SIGURG/SIGIO via
> F_SETOWN.

I'm glad we agree on that one :)

Considering we're not using sockets with broken SIGIO, but pseudo-terminals
like UML instead, there's still a problem:

When the task is registered as socket owner and is just about to enter the
kernel due to a syscall, it will stop with a SIGTRAP and the tracing kernel
process will run sometime and see a SIGCHLD. But after the task stopped and
before the kernel process can change SIGIO ownership back, a new interrupt
could come in and the SIGIO would remain pending in the task's process until
the task was scheduled to run next time.

How do you solve this?

-Udo.
