Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318369AbSGYI5J>; Thu, 25 Jul 2002 04:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318374AbSGYI5J>; Thu, 25 Jul 2002 04:57:09 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:15050 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318369AbSGYI5I>;
	Thu, 25 Jul 2002 04:57:08 -0400
Date: Thu, 25 Jul 2002 18:08:31 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] new module interface
Message-Id: <20020725180831.3b0b2449.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.44.0207242128030.8911-100000@serv>
References: <Pine.LNX.4.44.0207242128030.8911-100000@serv>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002 22:02:36 +0200 (CEST)
Roman Zippel <zippel@linux-m68k.org> wrote:

> The patch below is for 2.4 but it's easily ported to 2.5, beside of this I
> think the core is stable and will allow a more flexible module handling
> in the future. After updating to 2.5 and updating some more archs I will
> submit the patch officially, so any feedback now would be very welcome.
> (The patch requires no new modutils, although a new version could avoid
> some workarounds, but that can wait.)

Hi Roman!

	Firstly, I give up: what kernel is this patch against?  It's
hard to read a patch this big which doesn't apply to any kernel I can find 8(

> DEFINE_MODULE
> 	.start =	start_affs_fs,
> 	.stop =		stop_affs_fs,
> 	.exit =		exit_affs_fs,
> 	.usecount =	usecount_affs_fs,
> DEFINE_MODULE_END

Interesting approach.  Splitting init and start and stop and exit is
normal, but encapsulating the usecount is different.  I made start
and exit return void, though.

Hmmm... you sidestepped the "rmmod -f" problem, by running module->start()
again if module->exit() fails.  I decided against this because module
authors have to make sure this works.

I chose the more standard "INIT(init, start)" & "EXIT(stop, exit)" which
makes it easier to drop the exit part if it's built-in.

My favorite part is including the builtin-modules.  I assume this means
that "request_module("foo")" returns success if CONFIG_DRIVER_FOO=y now?

Sorry I've been slack in posting my patch: will do tonight I promise 8)

Cheers!
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
