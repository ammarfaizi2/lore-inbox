Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265006AbUFMGAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbUFMGAU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 02:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbUFMGAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 02:00:20 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:13847 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265006AbUFMGAP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 02:00:15 -0400
Date: Sun, 13 Jun 2004 08:08:12 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Paul Jackson <pj@sgi.com>
Cc: Clemens Schwaighofer <schwaigl@eunet.at>, gullevek@gullevek.org,
       linux-kernel@vger.kernel.org, cs@tequila.co.jp
Subject: Re: compile error with 2.6.7-rc3-mm1
Message-ID: <20040613060812.GA2195@mars.ravnborg.org>
Mail-Followup-To: Paul Jackson <pj@sgi.com>,
	Clemens Schwaighofer <schwaigl@eunet.at>, gullevek@gullevek.org,
	linux-kernel@vger.kernel.org, cs@tequila.co.jp
References: <40C9AF48.2040807@gullevek.org> <20040611062829.574db94f.pj@sgi.com> <40CA6835.2070405@eunet.at> <20040612034430.72a8207e.pj@sgi.com> <40CBC809.3000102@eunet.at> <20040612204207.0136b76f.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040612204207.0136b76f.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2004 at 08:42:07PM -0700, Paul Jackson wrote:
> Try doing the make with V=1
> 
>   make V=1 drivers/perfctr/x86.o
> 
> Determine the exact compilation line (perhaps a couple hundred chars
> long) that issues the error, then manually repeat that line manually
> (cut+paste), adding the option "-save-temps".
> 
> This will look something similar to the following, which I generated for
> a different file, different compilation environment (I added the wrapping
> and backslashes for display purposes here):
> 
>     gcc -save-temps -Wp,-MD,kernel/.cpuset.o.d -nostdinc -iwithprefix \
>     include -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs \
>     -fno-strict-aliasing -fno-common -pipe -msoft-float \
>     -mpreferred-stack-boundary=2  -march=pentium4 -mregparm=3 \
>     -Iinclude/asm-i386/mach-default -O2 -fomit-frame-pointer \ 
>     -DKBUILD_BASENAME=cpuset -DKBUILD_MODNAME=cpuset -c -o kernel/cpuset.o \
>     kernel/cpuset.c
> 
> Then look at the ./x86.i file (in top directory), which is the
> preprocessor output, to see if the (cpumask_t) cast is present.

Much simpler method is to just use:

	make drivers/perfctr/x86.i

Same goes for .lst (mixed assembly and c)
and for .s (pure assembler)

	Sam
