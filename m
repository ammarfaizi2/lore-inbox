Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbWGIDbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbWGIDbj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 23:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWGIDbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 23:31:39 -0400
Received: from xenotime.net ([66.160.160.81]:41938 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161077AbWGIDbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 23:31:38 -0400
Date: Sat, 8 Jul 2006 20:34:24 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: mreuther@umich.edu, linux-kernel@vger.kernel.org
Subject: Re: Compile Error on 2.6.17-mm6
Message-Id: <20060708203424.281400d2.rdunlap@xenotime.net>
In-Reply-To: <20060708174347.76391c7b.akpm@osdl.org>
References: <200607072222.31586.mreuther@umich.edu>
	<20060708174347.76391c7b.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2006 17:43:47 -0700 Andrew Morton wrote:

> On Fri, 7 Jul 2006 22:22:16 -0400
> Matt Reuther <mreuther@umich.edu> wrote:
> 
> > Here is the error:
> >   CHK     include/linux/compile.h
> >   UPD     include/linux/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > arch/i386/kernel/built-in.o(.text+0xe282): In function 
> > `cpu_request_microcode':
> > arch/i386/kernel/microcode.c:544: undefined reference to `request_firmware'
> > arch/i386/kernel/built-in.o(.text+0xe304):arch/i386/kernel/microcode.c:573: 
> > undefined reference to `release_firmware'
> 
> CONFIG_FW_LOADER=m
> CONFIG_MICROCODE=y
> 
> So
> 
> config MICROCODE
> 	tristate "/dev/cpu/microcode - Intel IA32 CPU microcode support"
> 	depends on FW_LOADER
> 
> is not sufficient.  There's a fix for this, but I cannot remember what it
> is.  Help.

That 1-line depends patch fixes the problem for me (on x86-64,
but they are the same in this area).

---
~Randy
