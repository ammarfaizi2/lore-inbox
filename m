Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpHAVHd7uB24STWeB5j6SbV8ciA==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 12:30:06 +0000
Message-ID: <01ca01c415a4$70159920$d100000a@sbs2003.local>
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Date: Mon, 29 Mar 2004 16:42:27 +0100
From: "Mikael Pettersson" <mikpe@csd.uu.se>
To: <Administrator@smtp.paston.co.uk>
Subject: Re: Pentium M config option for 2.6
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:29.0906 (UTC) FILETIME=[71AADF20:01C415A4]

On Sun, 4 Jan 2004 03:28:48 +0100, Tomas Szepe wrote:
>Since the Pentium M has 64 byte cache lines and is not a K7 or K8...  ;)
...
>--- a/arch/i386/Makefile	2003-09-28 11:38:05.000000000 +0200
>+++ b/arch/i386/Makefile	2004-01-04 03:02:52.000000000 +0100
>@@ -35,6 +35,7 @@
> cflags-$(CONFIG_MPENTIUMII)	+= $(call check_gcc,-march=pentium2,-march=i686)
> cflags-$(CONFIG_MPENTIUMIII)	+= $(call check_gcc,-march=pentium3,-march=i686)
> cflags-$(CONFIG_MPENTIUM4)	+= $(call check_gcc,-march=pentium4,-march=i686)
>+cflags-$(CONFIG_MPENTIUMM)	+= $(call check_gcc,-march=pentium4,-march=i686)
> cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)
> # Please note, that patches that add -march=athlon-xp and friends are pointless.
> # They make zero difference whatsosever to performance at this time.

P-M is not a P4 core, it's an enhanced PIII core.
SSE2 was added, but compiler support for SSE2 f.p.
math shouldn't matter for the kernel.

Using P4 optimisations on a P-M may actually reduce
performance, due to the different micro-architectures.
(P4 made shifts and some leas more expensive, and
simple add/and/sub/etc less expensive.)

IOW, don't lie to the compiler and pretend P-M == P4
with that -march=pentium4.

And since P-M doesn't do SMP, does cache line size even
matter? There are no locks to protect from ping-ponging.

/Mikael
