Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266838AbUHRAIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266838AbUHRAIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 20:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUHRAIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 20:08:38 -0400
Received: from holomorphy.com ([207.189.100.168]:23475 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266838AbUHRAIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 20:08:36 -0400
Date: Tue, 17 Aug 2004 17:08:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-mm1: parallel make doesn't.
Message-ID: <20040818000826.GR11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@osdl.org>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1092787271.27346.118.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092787271.27346.118.camel@bach>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 10:01:11AM +1000, Rusty Russell wrote:
> Need to make the first few files without -j, othewise it barfs.  This is
> a regression over 2.6.8.1 (sorry, don't know when it crept into the -mm
> tree).  .config attached in case it matters.
> cd ~/devel/kernel/.28758-linux-2.6.8.1-mm1.updated/
> make -j5
>   CHK     include/linux/version.h
>   SYMLINK include/asm -> include/asm-i386
>   UPD     include/linux/version.h
>   SPLIT   include/linux/autoconf.h -> include/config/*
> make: *** No rule to make target `.tmp_kallsyms2.S', needed by
> `.tmp_kallsyms2.o'.  Stop.
> make: *** Waiting for unfinished jobs....
> make: *** Waiting for unfinished jobs....
> make: *** Waiting for unfinished jobs....
> Compilation exited abnormally with code 2 at Wed Aug 18 09:54:47

Sam Ravnborg already posted a fix. Yes, the semicolon is necessary.


Index: mm1-2.6.8.1/Makefile
===================================================================
--- mm1-2.6.8.1.orig/Makefile	2004-08-16 23:47:11.979962024 -0700
+++ mm1-2.6.8.1/Makefile	2004-08-17 00:03:56.918188192 -0700
@@ -610,6 +610,8 @@
 .tmp_vmlinux3: $(vmlinux-objs) .tmp_kallsyms2.o arch/$(ARCH)/kernel/vmlinux.lds FORCE
 	$(call if_changed_rule,vmlinux__)
 
+$(KALLSYMS): scripts;
+
 endif
 
 # Finally the vmlinux rule
