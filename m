Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbTBTP3I>; Thu, 20 Feb 2003 10:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265517AbTBTP3I>; Thu, 20 Feb 2003 10:29:08 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:7879 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S265513AbTBTP3E>; Thu, 20 Feb 2003 10:29:04 -0500
Date: Thu, 20 Feb 2003 09:38:58 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Muli Ben-Yehuda <mulix@mulix.org>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix bug 376 - tiny extra echo in Makefile
In-Reply-To: <20030220124948.GC17614@actcom.co.il>
Message-ID: <Pine.LNX.4.44.0302200935590.19487-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003, Muli Ben-Yehuda wrote:

> It's not really a bug, which means this isn't really a fix, but it
> does make things more consistent. Please consider for inclusion or let
> me know you aren't interested so I can close the bug. Thanks. 
> 
> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or higher.
> # This patch includes the following deltas:
> #	           ChangeSet	1.1004  -> 1.1005 
> #	            Makefile	1.362   -> 1.363  
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 03/02/20	mulix@alhambra.mulix.org	1.1005
> # don't print the echo command when printing 'Generating build number'
> # --------------------------------------------
> #
> diff -Nru a/Makefile b/Makefile
> --- a/Makefile	Thu Feb 20 13:40:59 2003
> +++ b/Makefile	Thu Feb 20 13:40:59 2003
> @@ -325,7 +325,7 @@
>  define rule_vmlinux__
>  	set -e
>  	$(if $(filter .tmp_kallsyms%,$^),,
> -	  echo '  Generating build number'
> +	  @echo '  Generating build number'
>  	  . $(src)/scripts/mkversion > .tmp_version
>  	  mv -f .tmp_version .version
>  	  $(Q)$(MAKE) $(build)=init

The thing is, I cannot reproduce it here.

Also, the entire rule_vmlinux__ is invoked with a '@' in front, so nothing
there should be echoed. However, for the original submitter that obviously
doesn't work, the ". $(src)..." line is echoed to. What version of "make"
is used?

--Kai


