Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292339AbSCFAUQ>; Tue, 5 Mar 2002 19:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290946AbSCFAUJ>; Tue, 5 Mar 2002 19:20:09 -0500
Received: from mail.powweb.com ([64.63.125.220]:31239 "EHLO mail.powweb.com")
	by vger.kernel.org with ESMTP id <S291043AbSCFAT6>;
	Tue, 5 Mar 2002 19:19:58 -0500
Message-ID: <3C85602D.2090809@divsol.com>
Date: Tue, 05 Mar 2002 17:17:49 -0700
From: Jim Cromie <jcromie@divsol.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020222
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: newbie PATCH:  add MODULE_AUTHORS_VERSION  macro
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I humbly submit for your consideration: (please cc, im not subscribed)

[jimc@groucho linux]$ diff -u module.h module.h.new
--- module.h    Wed Feb 27 04:22:33 2002
+++ module.h.new    Tue Mar  5 15:39:39 2002
@@ -206,6 +206,10 @@
 const char __module_author[] __attribute__((section(".modinfo"))) =     
   \
 "author=" name
 
+#define MODULE_AUTHORS_VERSION(name)                       \
+const char __module_authors_version[] 
__attribute__((section(".modinfo"))) = \
+"authors_version=" name
+
 #define MODULE_DESCRIPTION(desc)                       \
 const char __module_description[] __attribute__((section(".modinfo"))) 
=   \
 "description=" desc


intent is to make more info available to modinfo.
hopefully the macro name is good enough to make this obvious,
ie distinguish it from MODVERSIONS etc..

Im slightly puzzled why its not already there, (it makes me think Im 
missing something),
but I did the search (this isnt same as AUTHOR printk thread (83) from 
last summer),
so what the heck ...


assuming this patch is accepted, should I ?  (being an optimist here)?

1. grep sources and patch modules which have a VERSION of some sort, like

arch/i386/kernel/mtrr.c:#define MTRR_VERSION            "1.40 (20010327)"
arch/i386/kernel/microcode.c:#define MICROCODE_VERSION     "1.09"

ie should i do the janitor work, or leave it to authors/maintainers ? 
case-by-case ?


2. or should I try to devise a better macro that slaps together __FILE__ 
and "_VERSION" to
automatically provide the macro definitions created by the above #defines.
This could be mis-used where filename != module-name, unless the macro, 
when cppd in,
can selectively undef itself.  ( this option is mostly food for thought, 
dunno if its practical )


3. modinfo patches ?

