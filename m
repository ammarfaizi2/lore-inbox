Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264986AbUFMDnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264986AbUFMDnY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 23:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264987AbUFMDnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 23:43:24 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:7845 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264986AbUFMDnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 23:43:22 -0400
Date: Sat, 12 Jun 2004 20:42:07 -0700
From: Paul Jackson <pj@sgi.com>
To: Clemens Schwaighofer <schwaigl@eunet.at>
Cc: gullevek@gullevek.org, linux-kernel@vger.kernel.org, cs@tequila.co.jp
Subject: Re: compile error with 2.6.7-rc3-mm1
Message-Id: <20040612204207.0136b76f.pj@sgi.com>
In-Reply-To: <40CBC809.3000102@eunet.at>
References: <40C9AF48.2040807@gullevek.org>
	<20040611062829.574db94f.pj@sgi.com>
	<40CA6835.2070405@eunet.at>
	<20040612034430.72a8207e.pj@sgi.com>
	<40CBC809.3000102@eunet.at>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try doing the make with V=1

  make V=1 drivers/perfctr/x86.o

Determine the exact compilation line (perhaps a couple hundred chars
long) that issues the error, then manually repeat that line manually
(cut+paste), adding the option "-save-temps".

This will look something similar to the following, which I generated for
a different file, different compilation environment (I added the wrapping
and backslashes for display purposes here):

    gcc -save-temps -Wp,-MD,kernel/.cpuset.o.d -nostdinc -iwithprefix \
    include -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs \
    -fno-strict-aliasing -fno-common -pipe -msoft-float \
    -mpreferred-stack-boundary=2  -march=pentium4 -mregparm=3 \
    -Iinclude/asm-i386/mach-default -O2 -fomit-frame-pointer \ 
    -DKBUILD_BASENAME=cpuset -DKBUILD_MODNAME=cpuset -c -o kernel/cpuset.o \
    kernel/cpuset.c

Then look at the ./x86.i file (in top directory), which is the
preprocessor output, to see if the (cpumask_t) cast is present.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
