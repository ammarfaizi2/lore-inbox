Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVBHKXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVBHKXZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 05:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVBHKXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 05:23:24 -0500
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:18048 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261505AbVBHKXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 05:23:19 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [BUG report] UML linux-2.6 latest BK doesn't compile
Date: Tue, 8 Feb 2005 11:22:22 +0100
User-Agent: KMail/1.7.2
Cc: Jeff Dike <jdike@addtoit.com>, lkml <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502081122.22613.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 February 2005 11:09, Anton Altaparmakov wrote:
> Hi,
>
> With the current linux-2.6 BK tree I get this when trying to compile
> UML:
>
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/um/kernel/built-in.o(__ksymtab+0x2b0): In function `um_execve':
> arch/um/kernel/exec_kern.c:59: undefined reference to `__bb_init_func'
> collect2: ld returned 1 exit status
>   KSYM    .tmp_kallsyms1.S
> nm: '.tmp_vmlinux1': No such file
> /bin/bash: line 1: 26161 Exit 1                  nm -n .tmp_vmlinux1
>      26162 Segmentation fault      | scripts/kallsyms >.tmp_kallsyms1.S
> make: *** [.tmp_kallsyms1.S] Error 139
>
> This is with SKAS mode enabled and TT disabled.  My .config is attached.

Hmm - I do not understand at all where `__bb_init_func' comes from (not from 
UML by sure, only from kernel headers possibly). And from preprocessing the 
source (of the -bk4 snapshot), nothing similar comes out.

long um_execve(char *file, char * *argv, char * *env)
{
 long err;

 err = execve1(file, argv, env);
 if(!err)
  do_longjmp((current_thread_info()->task)->thread.exec_buf, 1);
 return(err);
}

make arch/um/kernel/exec_kern.i ARCH=um

grep bb_init arch/um/kernel/exec_kern.i
gives nothing (tested with your config, too).

Try adding a "#undef execve1" before the problematic line, and reporting (here 
I don't get the failure).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

