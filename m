Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267881AbTBRRHF>; Tue, 18 Feb 2003 12:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267883AbTBRRHF>; Tue, 18 Feb 2003 12:07:05 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:14347 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267881AbTBRRGs>;
	Tue, 18 Feb 2003 12:06:48 -0500
Date: Tue, 18 Feb 2003 18:16:48 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: why is "scripts/elfconfig.h" not removed with "make mrproper"?
Message-ID: <20030218171648.GA2470@mars.ravnborg.org>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302181059210.15334-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302181059210.15334-100000@dell>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 11:01:29AM -0500, Robert P. J. Day wrote:
> 
>   i just verified that the original 2.5.62 kernel tree does not
> start with the header file "scripts/elfconfig.h".  this file is
> created by running "make xconfig", even when nothing is configured.
> but that file is *not* removed by running "make mrproper", which
> i would think it should be.
> 
>   won't this cause a problem when generating patches, since
> that elfconfig.h file will show up every time?

The following patch fixes this:

===== scripts/Makefile 1.30 vs edited =====
--- 1.30/scripts/Makefile	Mon Feb 17 04:20:26 2003
+++ edited/scripts/Makefile	Tue Feb 18 18:12:22 2003
@@ -11,6 +11,7 @@
 host-progs    := fixdep split-include conmakehash docproc kallsyms modpost \
 		 mk_elfconfig
 build-targets := $(host-progs) empty.o
+EXTRA_TARGETS := elfconfig.h
 
 modpost-objs  := modpost.o file2alias.o
 
@@ -30,4 +31,3 @@
 $(obj)/elfconfig.h: $(obj)/empty.o $(obj)/mk_elfconfig FORCE
 	$(call if_changed,elfconfig)
 
-targets += $(obj)/elfconfig.h
