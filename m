Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbTE0AEq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 20:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbTE0AEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 20:04:46 -0400
Received: from pop.gmx.net ([213.165.65.60]:42086 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262383AbTE0AEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 20:04:38 -0400
Message-ID: <3ED2AEA9.1000401@gmx.net>
Date: Tue, 27 May 2003 02:17:45 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5] [Cool stuff] "checking" mode for kernel builds
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

while eagerly waiting for the release of that tool, I have a few
comments about the patch itself.

> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 03/05/07	torvalds@home.transmeta.com	1.1063.14.3
> # Support a "checking" mode for kernel builds, that runs a
> # user-supplied source checker on all C files before compiling
> # them.
> # 
> # I'll release the actual checker once I've cleaned it up a
> # bit more (yay, all the copyright paperwork completed!)
> # --------------------------------------------
> #
> [...]
> @@ -172,6 +182,7 @@
>  DEPMOD		= /sbin/depmod
>  KALLSYMS	= scripts/kallsyms
>  PERL		= perl
> +CHECK		= /home/torvalds/parser/check

Hardcoded path

>  MODFLAGS	= -DMODULE
>  CFLAGS_MODULE   = $(MODFLAGS)
>  AFLAGS_MODULE   = $(MODFLAGS)
> @@ -66,6 +66,12 @@
>  	 $(subdir-ym) $(always)
>  	@:
>  
> +# Linus's kernel sanity checking tool

IIRC my english lessons it should be
+# Linus' kernel sanity checking tool

> +ifneq ($(KBUILD_CHECKSRC),0)
> +quiet_cmd_checksrc = CHECK   $<
> +      cmd_checksrc = $(CHECK) $(CFLAGS) $< ;
> +endif
> + 
>  # Module versioning
>  # ------------------------------------------------------
>  

Regards,
Carl-Daniel

