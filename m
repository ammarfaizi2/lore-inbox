Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUHGQVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUHGQVX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 12:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUHGQVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 12:21:22 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:50191 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S263540AbUHGQVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 12:21:19 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
To: Alexander Stohr <Alexander.Stohr@gmx.de>, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: confirmed: kernel build for 2.6.8-rc3 is broken for at least i386
Date: Sat, 7 Aug 2004 18:21:07 +0200
User-Agent: KMail/1.6.2
References: <2695.1091715476@www33.gmx.net> <20040805203317.GA22342@mars.ravnborg.org>
In-Reply-To: <20040805203317.GA22342@mars.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408071821.08530.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 of August 2004 22:33, Sam Ravnborg wrote:
> On Thu, Aug 05, 2004 at 04:17:56PM +0200, Alexander Stohr wrote:
> > As you, and possibly others can see,
> > the compilation happens from the arch/i386/kernel/timers subdir,
> > where we got lead to by th arch/i386/kernel subdir directly
> > and in this case the needed settings seem to lack despite they
> > were present in a former stage of the compilation.
>
> What happens is that the value assigned to AFLAGS_vmlinux.lds.o is lost
> between the first and the second invocation of make in arch/i386/kernel
>
> The only difference is the setting of LANG etc. - which you deleted
> from the log.
>
> Pleae try to delete the following lines from the top-level Makefile and try
> again:
>
> line 622-626:
> 	$(Q)if [ ! -z $$LC_ALL ]; then          \
> 	export LANG=$$LC_ALL;           \
> 	export LC_ALL= ;                \
> 	fi;                                     \
> 	export LC_COLLATE=C; export LC_CTYPE=C; \

-	$(Q)if [ ! -z $$LC_ALL ]; then          \
-		export LANG=$$LC_ALL;           \
-		export LC_ALL= ;                \
-	fi;                                     \
-	export LC_COLLATE=C; export LC_CTYPE=C; \
+	$(Q) \

^^^ works for me.

> If this cures the problem then please provide me with you LANG settings.
> Both LANG and LC_* variables.

only LANG=pl_PL

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
