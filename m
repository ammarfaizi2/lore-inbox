Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280531AbRLBQRi>; Sun, 2 Dec 2001 11:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280133AbRLBQR3>; Sun, 2 Dec 2001 11:17:29 -0500
Received: from pl475.nas921.ichikawa.nttpc.ne.jp ([210.165.235.219]:44856 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S280190AbRLBQRM>;
	Sun, 2 Dec 2001 11:17:12 -0500
Date: Mon, 3 Dec 2001 01:17:03 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Kilobug <kilobug@freesurf.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.1-pre5] Unresolved symbols in nfs module
Message-Id: <20011203011703.13a2ee1a.bruce@ask.ne.jp>
In-Reply-To: <3C0A4E56.1070409@freesurf.fr>
In-Reply-To: <3C0A4E56.1070409@freesurf.fr>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Dec 2001 16:52:54 +0100
Kilobug <kilobug@freesurf.fr> wrote:

> make modules_install:
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.1-pre5; fi
> depmod: *** Unresolved symbols in 
> /lib/modules/2.5.1-pre5/kernel/fs/nfs/nfs.o
> depmod:         seq_escape
> depmod:         seq_printf

The following patch is not guaranteed to not eat your entire HD, chew it up
and spit it out, or for that matter to work.
(Original patch from Tommy Reynolds, but if it breaks anything for you, don't
blame him and preferably not me either).

--- ksyms.c_ORIG        Mon Dec  3 01:08:46 2001
+++ ksyms.c     Mon Dec  3 01:12:30 2001
@@ -46,6 +46,7 @@
 #include <linux/tty.h>
 #include <linux/in6.h>
 #include <linux/completion.h>
+#include <linux/seq_file.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -553,3 +554,12 @@
 
 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(pidhash);
+
+/* Sequential file systems */
+
+EXPORT_SYMBOL(seq_open);
+EXPORT_SYMBOL(seq_read);
+EXPORT_SYMBOL(seq_lseek);
+EXPORT_SYMBOL(seq_release);
+EXPORT_SYMBOL(seq_escape);
+EXPORT_SYMBOL(seq_printf);
