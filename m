Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317431AbSFXIIn>; Mon, 24 Jun 2002 04:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317432AbSFXIIm>; Mon, 24 Jun 2002 04:08:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:62948 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317431AbSFXIIl> convert rfc822-to-8bit; Mon, 24 Jun 2002 04:08:41 -0400
Date: Mon, 24 Jun 2002 10:08:37 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
cc: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sander van Malssen <svm@kozmix.cistron.nl>
Subject: Re: 1000000000 as irq count init (was: Procinfo behaving strange
 under 2.4.19-pre10)
In-Reply-To: <20020623220208.A5272@bonzo.nirvana>
Message-ID: <Pine.NEB.4.44.0206241006330.21028-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2002, Axel Thimm wrote:

> On Fri, Jun 21, 2002 at 08:57:25AM +0200, Rasmus Bøg Hansen wrote:
> > I upgraded a short time ago from kernel 2.4.18 to 2.4.19-pre10, but now
> > procinfo reports interrupts in a strange way.
> >
> > 2.4.19-pre10:
> >
> > # procinfo
> > [...]
> > irq  0:1000207681 timer                 irq  8:1000000003
> > irq  1:1000004868 keyboard              irq  9:1000000000 acpi
> > irq  2:1000000000 cascade [4]           irq 10:1000007854 eth0
> > irq  3:1000000000                       irq 11:1000114199 nvidia
> > irq  4:1000000000                       irq 12:1000026199 PS/2 Mouse
> > irq  5:1000003195 es1370                irq 13:1000000000
> > irq  6:1000000000                       irq 14:1000016806 ide0
> > irq  7:1000000000                       irq 15:1000000000
> > [...]
>
> I can second this (while I switched from 2.4.19-pre6 to 2.4.18 with RedHat/SGI
> patches, but obviously the same patch hit me also).
>...

This is a known issue. The following patch to fix it is already in
Marcelos BK reporsitory (which means that the fix will be in -pre11/-rc1):

# --------------------------------------------
# 02/06/07	akpm@zip.com.au	1.537.1.44
# [PATCH] Remove debug code from /proc/stat
#
# This patch removes a piece of debug code which crept into the kernel
# by accident.
# --------------------------------------------
#
diff -Nru a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
--- a/fs/proc/proc_misc.c	Wed Jun 12 17:08:55 2002
+++ b/fs/proc/proc_misc.c	Wed Jun 12 17:08:55 2002
@@ -336,7 +336,7 @@
 #if !defined(CONFIG_ARCH_S390)
 	for (i = 0 ; i < NR_IRQS ; i++)
 		proc_sprintf(page, &off, &len,
-			     " %u", kstat_irqs(i) + 1000000000);
+			     " %u", kstat_irqs(i));
 #endif

 	proc_sprintf(page, &off, &len, "\ndisk_io: ");

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

