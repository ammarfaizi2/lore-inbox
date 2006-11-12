Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWKLNh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWKLNh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 08:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbWKLNh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 08:37:27 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:3482 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S932543AbWKLNh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 08:37:26 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: 2.6.19-rc5-mm1 fails to compile with gcc 4.2
Date: Sun, 12 Nov 2006 14:36:15 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <200611112334.28889.bero@arklinux.org> <200611121005.58939.bero@arklinux.org> <4556E860.700@qumranet.com>
In-Reply-To: <4556E860.700@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611121436.15492.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 12. November 2006 10:24, Avi Kivity wrote:
> >> Or better yet, preprocessed source and full gcc command line (as seen on
> >> 'make V=1').

gcc -m32 -Wp,-MD,drivers/kvm/.kvm_main.o.d  -nostdinc -isystem /usr/lib/gcc/i586-ark-linux/4.2.0/include -D__KERNEL__ -Iinclude  -include 
include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -O2 -pipe -msoft-float -mpreferred-stack-boundary=2  -march=i686 -mtune=pentium3 -maccumulate-outgoing-args -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -Iinclude/asm-i386/mach-default -fomit-frame-pointer  -fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign   -DMODULE -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(kvm_main)"  -D"KBUILD_MODNAME=KBUILD_STR(kvm)" -c -o 
drivers/kvm/.tmp_kvm_main.o drivers/kvm/kvm_main.c
drivers/kvm/kvm_main.c: In function 'kvm_dev_ioctl_run':
drivers/kvm/kvm_main.c:153: error: 'asm' operand has impossible constraints
drivers/kvm/kvm_main.c:158: error: 'asm' operand has impossible constraints

> > It does look like a gcc bug -- -O0 makes it go away.
> > Details at http://gcc.gnu.org/bugzilla/show_bug.cgi?id=29808
>
> That's a different bug, gcc generates code that the assembler can't
> handle.  Might be an assembler bug.

It's the same thing, the code is taken from kvm_main.c:

static void load_fs(u16 sel)
{
        asm ("mov %0, %%fs" : : "g"(sel));	<--- line 153
}

static void load_gs(u16 sel)
{
        asm ("mov %0, %%gs" : : "g"(sel));	<--- line 158
}


> Can you compile it with -S and post the generated assembly?

It can't generate assembly with asm() constructs it perceives as invalid -- -S 
produces the same error.
