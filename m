Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280233AbRKIWYd>; Fri, 9 Nov 2001 17:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280238AbRKIWYW>; Fri, 9 Nov 2001 17:24:22 -0500
Received: from h55p103-2.delphi.afb.lu.se ([130.235.187.175]:62901 "EHLO gin")
	by vger.kernel.org with ESMTP id <S280233AbRKIWYL>;
	Fri, 9 Nov 2001 17:24:11 -0500
Date: Fri, 9 Nov 2001 23:23:43 +0100
To: Keith Owens <kaos@ocs.com.au>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Modutils can't handle long kernel names
Message-ID: <20011109232343.B32090@h55p111.delphi.afb.lu.se>
In-Reply-To: <20011108204210.A514@mikef-linux.matchmail.com> <7712.1005284040@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7712.1005284040@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.23i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 04:34:00PM +1100, Keith Owens wrote:
> It is not a modutils problem, it is a fixed restriction on the size of
> the uname() fields, modutils just uses what uname -r gives it.

this patch would catch it at compiletime, wouldn't it?

-- 

//anders/g

--- Makefile.orig	Fri Nov  9 23:17:36 2001
+++ Makefile	Fri Nov  9 23:18:25 2001
@@ -338,7 +338,7 @@
 	@mv -f .ver $@
 
 init/version.o: init/version.c include/linux/compile.h include/config/MARKER
-	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) -DUTS_MACHINE='"$(ARCH)"' -c -o init/version.o init/version.c
+	$(CC) $(CFLAGS) -Werror $(CFLAGS_KERNEL) -DUTS_MACHINE='"$(ARCH)"' -c -o init/version.o init/version.c
 
 init/main.o: init/main.c include/config/MARKER
 	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -c -o $*.o $<
