Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934438AbWKXGC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934438AbWKXGC0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 01:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934437AbWKXGC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 01:02:26 -0500
Received: from 1wt.eu ([62.212.114.60]:32517 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S934438AbWKXGCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 01:02:25 -0500
Date: Fri, 24 Nov 2006 07:02:17 +0100
From: Willy Tarreau <w@1wt.eu>
To: atoka <atrockz@gmail.com>
Cc: kernelnewbies@nl.linux.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel cross compilation error
Message-ID: <20061124060217.GD577@1wt.eu>
References: <db74e4d30611232150o36859417q78f688afa3709266@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db74e4d30611232150o36859417q78f688afa3709266@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 11:20:17AM +0530, atoka wrote:
> hi everyone,
>        im a kernel newbie. im using a debian linux(ie ubuntu).i did
> cross compilation for ia64 on my system which is ia32. Now im trying
> to cross compile ia64 kernel but im getting some error. before
> compiling kernel, i did made changes in Makefile to specify my
> ia64-linux compiler and libraries .

You should not have changed the contents of your makefile but just
passed it some parameters.

> when i gave make menuconfig command i got following errors
> 
> root@atoka-desktop:/linux-2.6.18# make ARCH=ia64 menuconfig
>  HOSTCC  scripts/basic/fixdep
> scripts/basic/fixdep.c: In function 'use_config':
> scripts/basic/fixdep.c:204: error: 'PATH_MAX' undeclared (first use in
> this function)
> scripts/basic/fixdep.c:204: error: (Each undeclared identifier is
> reported only once
> scripts/basic/fixdep.c:204: error: for each function it appears in.)
> scripts/basic/fixdep.c:204: warning: unused variable 's'
> scripts/basic/fixdep.c: In function 'parse_dep_file':
> scripts/basic/fixdep.c:300: error: 'PATH_MAX' undeclared (first use in
> this function)
> scripts/basic/fixdep.c:300: warning: unused variable 's'
> make[1]: *** [scripts/basic/fixdep] Error 1
> make: *** [scripts_basic] Error 2

It is because you have changed HOSTCC which is the compiler for the
host you're building from. Normally, you just have to do something
like this :

$ make ARCH=ia64 CC=ia64-gcc menuconfig vmlinux ...

And BTW, don't build as root, one day you will regret it.

> i tried defining the PATH_MAX macro in fixdep.c to 100, but then it
> gave error in some other file.
> Can anyone help me out with this error?

Regards,
Willy

