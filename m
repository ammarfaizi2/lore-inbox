Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUCAG1Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 01:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbUCAG1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 01:27:24 -0500
Received: from dp.samba.org ([66.70.73.150]:33469 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262259AbUCAG1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 01:27:15 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Add a MODULE_VERSION macro 
In-reply-to: Your message of "Fri, 27 Feb 2004 18:38:58 +0200."
             <CA71EA605D@vcnet.vc.cvut.cz> 
Date: Mon, 01 Mar 2004 16:41:24 +1100
Message-Id: <20040301062725.844652C39D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <CA71EA605D@vcnet.vc.cvut.cz> you write:
> >  ifneq ($(filter-out $(modules),$(__modules)),)
> > +  $(warning Trouble: $(__modules) )
> >    $(warning *** Uh-oh, you have stale module entries. You messed with SUBDIRS,)
> >    $(warning     do not complain if something goes wrong.)
> >  endif
> 
> Hi Rusty,
>   what is this line supposed to do, except making it impossible
> to build kernel modules in temporary directories? Now when I build
> out-of-tree modules, I get 'Trouble:' followed by approximate 16000
> characters listing paths to all modules I have in kernel

Patch below: does it help?

Rusty
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.4-rc1-bk1/scripts/Makefile.modpost tmp/scripts/Makefile.modpost
--- linux-2.6.4-rc1-bk1/scripts/Makefile.modpost	2004-02-29 19:11:38.000000000 +1100
+++ tmp/scripts/Makefile.modpost	2004-03-01 16:40:33.000000000 +1100
@@ -14,7 +14,7 @@ __modules := $(shell head -q -n1 /dev/nu
 modules := $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=.o)))
 
 ifneq ($(filter-out $(modules),$(__modules)),)
-  $(warning Trouble: $(__modules) )
+  $(warning Trouble: $(filter-out $(modules),$(__modules)))
   $(warning *** Uh-oh, you have stale module entries. You messed with SUBDIRS,)
   $(warning     do not complain if something goes wrong.)
 endif
