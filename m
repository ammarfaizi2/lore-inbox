Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbVH0PXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbVH0PXk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 11:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbVH0PXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 11:23:40 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:55057 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751549AbVH0PXj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 11:23:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dv9rZEn5wy7ehtzBSKlF7W93FRVPvi9/0JHenJxhdo8VeYEXHZlOKrpIl4/J5vSz+lveuhl+gWrQIJESCyzKLfSRBtvszdZXfdcIkirILzZRxSPzPHFwZYnO/SJ3ZonHfhnQaHkSHfV0DNBIs5UT3dhSyxR9PT3lbjYCD2EBfrY=
Message-ID: <88ee31b7050827082345a393bd@mail.gmail.com>
Date: Sun, 28 Aug 2005 00:23:38 +0900
From: Jerome Pinot <ngc891@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [KCONFIG] Can't compile 2.6.12 without Gettext
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050827124751.GK6471@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <88ee31b705082421303697aef7@mail.gmail.com>
	 <20050827124751.GK6471@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/05, Adrian Bunk <bunk@stusta.de> wrote:
[...]
> are you using an ftp.kernel.org 2.6.12 kernel or a vendor kernel?

That's a vanilla 2.6.12.5 from kernel.org
For obvious reasons, I only do bugreports on lkml for vanilla kernel.

> If it's an ftp.kernel.org kernel, please send the exact error messages
> you are seeing.
[...]

---- snip ----
ngc891@comet:/usr/src/linux-2.6.12.5$ make V=1 menuconfig
make -f scripts/Makefile.build obj=scripts/basic
  gcc -Wp,-MD,scripts/basic/.fixdep.d -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer        -o scripts/basic/fixdep
scripts/basic/fixdep.c
  gcc -Wp,-MD,scripts/basic/.split-include.d -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer        -o scripts/basic/split-include
scripts/basic/split-include.c
  gcc -Wp,-MD,scripts/basic/.docproc.d -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer        -o scripts/basic/docproc
scripts/basic/docproc.c
if test ! /usr/src/linux-2.6.12.5 -ef /usr/src/linux-2.6.12.5; then \
/bin/sh /usr/src/linux-2.6.12.5/scripts/mkmakefile              \
    /usr/src/linux-2.6.12.5 /usr/src/linux-2.6.12.5 2 6         \
    > /usr/src/linux-2.6.12.5/Makefile;                                 \
    echo '  GEN    /usr/src/linux-2.6.12.5/Makefile';                   \
fi
make -f scripts/Makefile.build obj=scripts/kconfig menuconfig
  cat scripts/kconfig/zconf.tab.h_shipped > scripts/kconfig/zconf.tab.h
  gcc -Wp,-MD,scripts/kconfig/.conf.o.d -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer       -c -o scripts/kconfig/conf.o
scripts/kconfig/conf.c
In file included from scripts/kconfig/conf.c:14:
scripts/kconfig/lkc.h:11:21: libintl.h: No such file or directory
scripts/kconfig/conf.c: In function `check_stdin':
scripts/kconfig/conf.c:59: warning: implicit declaration of function `gettext'
make[1]: *** [scripts/kconfig/conf.o] Error 1
make: *** [menuconfig] Error 2
---- snip ----

Actually, adding libintl.h in /usr/include didn't solve the issue in
my case. My gettext implementation is not exactly complete. Anyway the
script shouldn't failed at this step.

Segher Boessenkool, who had the same problem, sent me a way to compile
the kernel by modifying a bit the lkc.h and mconf.c files. I suggested
him to send this to lkml too.

The fix to do is really small but it needs to define a policy about
how kconfig should decide about using gettext or not. It could use a
configure script or a parameter from command line to choose whether or
not to look for a gettext implementation (something like "make NLS=0
menuconfig" maybe). This should be define prior to any patch attempt.

So I just wonder what Roman Zippel think about this.

Regards,

-- 
Jerome Pinot
ftp://ngc891.blogdns.net/pub
