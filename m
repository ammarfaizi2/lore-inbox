Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265998AbUAKWOo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 17:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUAKWOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 17:14:44 -0500
Received: from [193.6.138.45] ([193.6.138.45]:54467 "EHLO delfin.unideb.hu")
	by vger.kernel.org with ESMTP id S265998AbUAKWOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 17:14:42 -0500
Date: Sun, 11 Jan 2004 23:15:03 +0100 (CET)
From: The NeverGone <never@delfin.klte.hu>
X-X-Sender: never@localhost
To: Tupshin Harper <tupshin@tupshin.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: UML (user-mode-linux) kernel-2.6.x
In-Reply-To: <4001C9DC.4070505@tupshin.com>
Message-ID: <Pine.LNX.4.58.0401112313350.1696@localhost>
References: <Pine.LNX.4.58.0401112222030.1401@localhost> <4001C68D.4010108@tupshin.com>
 <Pine.LNX.4.58.0401112300020.1585@localhost> <4001C9DC.4070505@tupshin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jan 2004, Tupshin Harper wrote:

> Is that guest 2.4.23 kernel stock, with only the mentioned patch (pasted
> below) applied?
>
> Are you absolutely positive that you rebuilt that guest kernel with the
> patch???(I'm guessing that this is really the problem)
>
> Are you still getting the same error message? ("I'm tracing myself...")
>
> -Tupshin
>
> --- 1.5/arch/um/os-Linux/process.c      Sat Jan 18 12:29:27 2003
> +++ 1.6/arch/um/os-Linux/process.c      Thu Oct  2 14:27:57 2003
> @@ -7,6 +7,7 @@
>  #include <stdio.h>
>  #include <errno.h>
>  #include <signal.h>
> +#include <linux/unistd.h>
>  #include <sys/mman.h>
>  #include <sys/wait.h>
>  #include "os.h"
> @@ -87,7 +88,8 @@
>
>  void os_usr1_process(int pid)
>  {
> -       kill(pid, SIGUSR1);
> +       syscall(__NR_tkill, pid, SIGUSR1);
> +/*     tkill(pid, SIGUSR1);*/
>  }
>
>  int os_getpid(void)

Hi...

It's also included in the host kernel (2.6.1-mm2) ...

Thx...

The NeverGone :)

==============================================================
 --------- Csatlakozz:  http://arenaportal.hix.com/ ---------
 ----- http://arenazo.cjb.net/ -- http://ironiq.hu/aDP/ -----
 --- Kurucz "The NeverGone" Istvan:  never@delfin.klte.hu ---
 -------------- http://delfin.klte.hu/~ki0029/ --------------
==============================================================

