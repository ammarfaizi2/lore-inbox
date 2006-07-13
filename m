Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbWGMK7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWGMK7u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 06:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWGMK7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 06:59:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40394 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751512AbWGMK7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 06:59:49 -0400
Subject: Re: Linker error with latest tree on EM64T
From: Arjan van de Ven <arjan@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: jakub@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1152788160.4838.2.camel@localhost>
References: <1152788160.4838.2.camel@localhost>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 12:59:47 +0200
Message-Id: <1152788387.3024.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 12:56 +0200, Marcel Holtmann wrote:
> Hi,
> 
> when trying to build the latest tree on an EM64T Dual-Core, I am getting
> this error:
> 
>   LD      .tmp_vmlinux1
> init/built-in.o: In function `try_name':
> do_mounts.c:(.text+0x51d): undefined reference to `__stack_chk_fail'
> init/built-in.o: In function `name_to_dev_t':
> (.text+0x797): undefined reference to `__stack_chk_fail'
> init/built-in.o: In function `mount_block_root':
> (.init.text+0x823): undefined reference to `__stack_chk_fail'
> init/built-in.o: In function `md_run_setup':
> (.init.text+0x1131): undefined reference to `__stack_chk_fail'
> init/built-in.o: In function `do_header':
> initramfs.c:(.init.text+0x24a4): undefined reference to `__stack_chk_fail'
> arch/x86_64/kernel/built-in.o:(.text+0x2f52): more undefined references to `__st
> ack_chk_fail' follow
> make: *** [.tmp_vmlinux1] Error 1

you are using ubuntu which has a compiler that adds -fstack-protector
implicitly to the compiler options, yet you don't have a kernel that
provides this infrastructure ;)
(I have code for that but it's not merged yet, it's pending one gcc
patch to get merged upstream)
in the mean time.. I'm pretty sure Sam sent a patch to Linus that adds
-fno-stack-protector...

