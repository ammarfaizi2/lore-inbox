Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWBMJHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWBMJHo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 04:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWBMJHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 04:07:44 -0500
Received: from mo00.po.2iij.net ([210.130.202.204]:22729 "EHLO
	mo00.po.2iij.net") by vger.kernel.org with ESMTP id S1751179AbWBMJHn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 04:07:43 -0500
Date: Mon, 13 Feb 2006 18:07:30 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Jan Dittmer <jdi@l4x.org>
Cc: yoichi_yuasa@tripeaks.co.jp, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc3
Message-Id: <20060213180730.2ce8031c.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <43F04780.7020605@l4x.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	<43F04780.7020605@l4x.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan

On Mon, 13 Feb 2006 09:46:56 +0100
Jan Dittmer <jdi@l4x.org> wrote:

> Linus Torvalds wrote:
> > The most user-visible one (eventually) is the unshare() system call, which 
> > glibc wanted. Along with some fixes for fstatat() (use the proper 64-bit 
> > interfaces, not the "newer old" one).
> 
> This breaks compilation on 3 archs compared to -rc2:
> 
> - mips: broke
>      AR      arch/mips/lib-32/lib.a
>      GEN     .version
>      CHK     include/linux/compile.h
>      UPD     include/linux/compile.h
>      CC      init/version.o
>      LD      init/built-in.o
>      LD      .tmp_vmlinux1
>    arch/mips/kernel/built-in.o(.text+0x9820): In function `einval':
>    /usr/src/ctest/rc/kernel/arch/mips/kernel/scall32-o32.S: undefined reference to `sys_newfstatat'
>    make[1]: *** [.tmp_vmlinux1] Error 1
>    make: *** [cdbuilddir] Error 2
> 
> 
>    Details: http://l4x.org/k/?d=10888

MIPS 32bit machines need fstatat64 support.

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index d7c4a38..d83e033 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -623,7 +623,7 @@ einval:	li	v0, -EINVAL
 	sys	sys_mknodat		4	/* 4290 */
 	sys	sys_fchownat		5
 	sys	sys_futimesat		3
-	sys	sys_newfstatat		4
+	sys	sys_fstatat64		4
 	sys	sys_unlinkat		3
 	sys	sys_renameat		4	/* 4295 */
 	sys	sys_linkat		4
