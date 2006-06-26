Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWFZHke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWFZHke (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 03:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWFZHke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 03:40:34 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:44233 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932386AbWFZHkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 03:40:33 -0400
Date: Mon, 26 Jun 2006 16:39:59 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Toralf Foerster <toralf.foerster@gmx.de>
Subject: Re: linux-2.6.17.1: undefined reference to `online_page'
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Hansen <haveblue@us.ibm.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <200606251704_MC3-1-C36D-5D33@compuserve.com>
References: <200606251704_MC3-1-C36D-5D33@compuserve.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060626163235.A022.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In-Reply-To: <200606231001.33766.toralf.foerster@gmx.de>
> 
> On Fri, 23 Jun 2006 10:01:33 +0200, Toralf Foerster wrote:
> 
> > I got the compile error :
> > 
> > ...
> >   UPD     include/linux/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > mm/built-in.o: In function `online_pages':
> > : undefined reference to `online_page'
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > with this config:
> 
> > CONFIG_X86_32=y
> 
> > CONFIG_NOHIGHMEM=y
> 
> > CONFIG_SPARSEMEM_MANUAL=y
> > CONFIG_SPARSEMEM=y
> > CONFIG_HAVE_MEMORY_PRESENT=y
> > CONFIG_SPARSEMEM_STATIC=y
> > CONFIG_MEMORY_HOTPLUG=y
> 
> Yes, that config is broken. mm/memory_hotplug.c::online_pages() calls
> online_page() but without HIGHMEM that doesn't get built and no dummy
> function gets defined.

Toralf-san. How is this patch?
Or do you want to use memory hotplug without highmem?

Bye.

---

add_memory() for i386 add memory to highmem. So, if CONFIG_HIGHMEM
is not set, CONFIG_MEMORY_HOTPLUG shouldn't be set.


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

---
 mm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.17/mm/Kconfig
===================================================================
--- linux-2.6.17.orig/mm/Kconfig	2006-06-26 14:19:11.000000000 +0900
+++ linux-2.6.17/mm/Kconfig	2006-06-26 14:19:53.000000000 +0900
@@ -115,7 +115,7 @@ config SPARSEMEM_EXTREME
 # eventually, we can have this option just 'select SPARSEMEM'
 config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
-	depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND
+	depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND && !(X86_32 && !HIGHMEM)
 
 comment "Memory hotplug is currently incompatible with Software Suspend"
 	depends on SPARSEMEM && HOTPLUG && SOFTWARE_SUSPEND

-- 
Yasunori Goto 


