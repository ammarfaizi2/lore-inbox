Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbUCTWue (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 17:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbUCTWue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 17:50:34 -0500
Received: from ns.suse.de ([195.135.220.2]:26063 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263565AbUCTWub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 17:50:31 -0500
Date: Sat, 20 Mar 2004 23:50:30 +0100
From: Olaf Hering <olh@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-ID: <20040320225030.GB8542@suse.de>
References: <20040314172809.31bd72f7.akpm@osdl.org> <20040315185458.GA17332@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040315185458.GA17332@mars.ravnborg.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Mar 15, Sam Ravnborg wrote:

> > 
> > +kbuild-fix-early-dependencies.patch
> > +kbuild-fix-early-dependencies-fix.patch
> > 
> >  Parallel build fix
> 
> Hi Andrew - here is an update, that includes the posted fixes.
> It also fixes 'make sgmldocs', using correct path to docproc.
> 
> It replaces the above two patches, but description is still ok.


> diff -Nru a/scripts/Makefile b/scripts/Makefile
> --- a/scripts/Makefile	Mon Mar 15 19:51:20 2004
> +++ b/scripts/Makefile	Mon Mar 15 19:51:20 2004
> @@ -17,10 +13,7 @@
>  subdir-$(CONFIG_MODVERSIONS)	+= genksyms
>  
>  # Let clean descend into subdirs
> -subdir-	+= lxdialog kconfig
> -
> -# fixdep is needed to compile other host programs
> -$(addprefix $(obj)/,$(filter-out fixdep,$(always)) $(subdir-y)): $(obj)/fixdep
> +subdir-	+= basic lxdialog kconfig
>  
>  # dependencies on generated files need to be listed explicitly
>  

I think that one made it into rc2. It breaks uml compilation, 

  CC      kernel/acct.o
  IKCFG   kernel/ikconfig.h
  GZIP    kernel/config_data.gz
  IKCFG   kernel/config_data.h
/bin/sh: line 1: scripts/bin2c: No such file or directory
make[1]: *** [kernel/config_data.h] Error 1
make: *** [kernel] Error 2
error: Bad exit status from /var/tmp/rpm-tmp.18419 (%build)

looks like IKCFG does not depend on scripts/bin2c anymore?

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
