Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317351AbSGTEcR>; Sat, 20 Jul 2002 00:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSGTEcQ>; Sat, 20 Jul 2002 00:32:16 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:12163 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317351AbSGTEcQ>;
	Sat, 20 Jul 2002 00:32:16 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] check shm mount succeeded in shmem_file_setup 
In-reply-to: Your message of "Fri, 19 Jul 2002 10:02:21 EST."
             <200207191502.KAA02022@ccure.karaya.com> 
Date: Sat, 20 Jul 2002 14:19:39 +1000
Message-Id: <20020720043607.090A241AC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200207191502.KAA02022@ccure.karaya.com> you write:
> rusty@rustcorp.com.au said:
> > And if the initialization fails at boot, we're screwed anyway. 
> 
> Why?  If it fails, it still boots fine until something tries using shared
> memory.  With UML and my Debian fs, that's Apache, which is the last thing
> before the gettys run.

Same argument applies to lots of subsystems, but I'd suggest a policy:
we should be failing the boot rather than coming partially up and
trying to deal with failures that shouldn't happen.

Unfortunately, we don't check init returns at boot, because we
*expect* device driver initialization to fail for builtin device
drivers who have found no device.  It'd be nice to standardize on
-ENODEV for these failures, so we *could* handle these failures
easily, and discourage the current sloppiness.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
