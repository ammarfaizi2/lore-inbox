Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311439AbSCZM43>; Tue, 26 Mar 2002 07:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293347AbSCZM4T>; Tue, 26 Mar 2002 07:56:19 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:2825 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S311439AbSCZM4G>;
	Tue, 26 Mar 2002 07:56:06 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Anthony Chee" <anthony.chee@polyu.edu.hk>
Cc: "Bart Trojanowski" <bart@jukie.net>, linux-kernel@vger.kernel.org,
        kbuild-devel@vger.kernel.org, kernelnewbies@vger.kernel.org
Subject: Re: undefined reference 
In-Reply-To: Your message of "Tue, 26 Mar 2002 12:17:50 +0800."
             <000701c1d47d$31daade0$ccd7fea9@winxp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Mar 2002 16:49:58 +1100
Message-ID: <21554.1017121798@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2002 12:17:50 +0800, 
"Anthony Chee" <anthony.chee@polyu.edu.hk> wrote:
>Or let me say clearly.
>
>The suitution is I want the kernel source use the symbol from module.
>
>What I did in the module code are:
>1. EXPORT_SYMBOL(func) in the source code of module
>2. Set "extern int func()" in the module header
>
>What I did in the kernel source code are:
>1. Insert "func()" in the inode.c
>2. Add the module header in the kernel source code
>
>Then I use "make bzImage", I got no error message on compiling inode.c, but
>I got
>
>"fs/fs.o(.text+0x1377d): undefined reference to `func'"

You cannot do that.  The kernel must be self contained.  The only way
for the kernel to access module code and data is for the module to
register that code and data when the module is loaded and for the
kernel to access the module via the registration list.

See any module that handles a filesystem.  sys_open() does not call the
module directly.  A module registers its file operations on load.  The
kernel (dentry_open) calls the module via f->f_op->open.

