Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269129AbUINNOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269129AbUINNOu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 09:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269378AbUINNNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 09:13:54 -0400
Received: from nl-ams-slo-l4-01-pip-5.chellonetwork.com ([213.46.243.21]:27671
	"EHLO amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S269298AbUINNMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 09:12:15 -0400
Date: Tue, 14 Sep 2004 15:12:12 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roland McGrath <roland@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Ralf Baechle <ralf@linux-mips.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc2
In-Reply-To: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0409141509100.10951@anakin>
References: <Pine.LNX.4.58.0409130937050.4094@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004, Linus Torvalds wrote:
> Roland McGrath:
>   o waitid system call

You forgot to add `struct rusage _rusage' members to struct siginfo._sigchld
for 2 architectures that define HAVE_ARCH_SIGINFO_T.

I needed the first patch below to fix compilation for m68k.
I guess Ralf needs the second one for MIPS.

--- linux-2.6.9-rc2/include/asm-m68k/siginfo.h	2004-04-27 20:42:20.000000000 +0200
+++ linux-m68k-2.6.9-rc2/include/asm-m68k/siginfo.h	2004-09-14 13:56:55.000000000 +0200
@@ -46,6 +46,7 @@
 			clock_t _utime;
 			clock_t _stime;
 			__kernel_uid32_t _uid32; /* sender's uid */
+			struct rusage _rusage;
 		} _sigchld;

 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
--- linux-2.6.9-rc2/include/asm-mips/siginfo.h	2004-05-03 20:05:06.000000000 +0200
+++ linux-m68k-2.6.9-rc2/include/asm-mips/siginfo.h	2004-09-14 14:48:51.000000000 +0200
@@ -50,6 +50,7 @@
 			clock_t _utime;
 			int _status;		/* exit code */
 			clock_t _stime;
+			struct rusage _rusage;
 		} _sigchld;

 		/* IRIX SIGCHLD */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
