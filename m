Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262763AbTCKAqS>; Mon, 10 Mar 2003 19:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262766AbTCKAqS>; Mon, 10 Mar 2003 19:46:18 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:29375 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S262763AbTCKAqR>;
	Mon, 10 Mar 2003 19:46:17 -0500
Date: Tue, 11 Mar 2003 01:56:50 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200303110056.h2B0uo6U005286@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: Re: [BK-2.5] Move "used FPU status" into new non-atomic thread_info->status field.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003 11:25:55 -0800 (PST), Linus Torvalds wrote:
>We could _probably_ do it on x86 too. The standard C calling convention on 
>x86 says FPU register state is clobbered, if I remember correctly. 
>However, some of the state is "long-term", like rounding modes, exception 
>masking etc, and even if we didn't save the register state we would have 
>to save that part.
...
>As it was, the x86 state was pretty much random after fork(), and that can 
>definitely lead to problems for real programs if they depend on things 
>like silent underflow etc. 

Do you mean x87 control or the x87 stack here?

>(Now, in _practice_ all processes on the machine tends to use the same
>rounding and exception control, so the "random" state wasn't actually very
>random, and would not lead to problems. It's a security issue, though).

Sorry for being dense, but can you clarify: will current 2.{2,4,5}
kernels preserve or destroy the parent process' FPU control at fork()?

We're using unmasked FPU exceptions on x86 (and Solaris/SPARC) in the
runtime system for the Erlang telecom systems programming language.
This gives a noticeable performance improvement, but it relies on
the FPU control not changing beneath it: the FPU control is only
initialised at startup and when SIGFPU has occurred.

/Mikael
