Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUJRNn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUJRNn1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 09:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUJRNn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 09:43:27 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6016 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266491AbUJRNnX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 09:43:23 -0400
Date: Mon, 18 Oct 2004 08:53:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Greg KH <greg@kroah.com>, Lee Revell <rlrevell@joe-job.com>,
       David Woodhouse <dwmw2@infradead.org>, Josh Boyer <jdub@us.ibm.com>,
       gene.heskett@verizon.net, Linux kernel <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>
Subject: Re: Fw: signed kernel modules?
In-Reply-To: <Pine.LNX.4.61.0410151744220.3651@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0410180845040.3512@chaos.analogic.com>
References: <27277.1097702318@redhat.com> <Pine.LNX.4.61.0410150723180.8573@chaos.analogic.com>
 <1097843492.29988.6.camel@weaponx.rchland.ibm.com> <200410151153.08527.gene.heskett@verizon.net>
 <1097857049.29988.29.camel@weaponx.rchland.ibm.com>
 <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com>
 <1097860121.13633.358.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.61.0410151319460.6877@chaos.analogic.com>
 <1097873791.5119.10.camel@krustophenia.net> <20041015211809.GA27783@kroah.com>
 <4170426E.5070108@nortelnetworks.com> <Pine.LNX.4.61.0410151744220.3651@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, 15 Oct 2004, Chris Friesen wrote:
>
>> Greg KH wrote:
>> 
>>> If you have a BSD licensed module, you do not have to provide the source
>>> code for it.
>> 
>> Maybe we need a "BSD with source" module string that doesn't taint?  Or is 
>> that getting too ridiculous?
>> 
>> Chris

If the whole module license issue is truly one of being able
to review the source, then certainly nobody would fear the
inclusion of a "PUBLIC" license string. This would fit the
broad classification of publicly-available sources, not
necessarily just in the "Public domain". For instance, when
a company puts the sources for some driver on it's Web Page,
but doesn't want to have anything to do with Mr. Stallman.

Here is a patch. I also added an array containing, possibly
more in the future, acceptable strings.



--- linux-2.6.8/kernel/module.c.orig	2004-10-18 08:21:28.000000000 -0400
+++ linux-2.6.8/kernel/module.c	2004-10-18 08:37:19.000000000 -0400
@@ -48,6 +48,18 @@
  #define ARCH_SHF_SMALL 0
  #endif

+/*
+ *  List of acceptable module-license strings.
+ */
+static const char *licok[]= {
+    "GPL",
+    "GPL v2",
+    "CPL and additional rights",
+    "Dual BSD/GPL",
+    "Dual MPL/GPL",
+    "PUBLIC" };
+
+
  /* If this is set, the section belongs in the init part of the module */
  #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))

@@ -1362,11 +1374,11 @@

  static inline int license_is_gpl_compatible(const char *license)
  {
-	return (strcmp(license, "GPL") == 0
-		|| strcmp(license, "GPL v2") == 0
-		|| strcmp(license, "GPL and additional rights") == 0
-		|| strcmp(license, "Dual BSD/GPL") == 0
-		|| strcmp(license, "Dual MPL/GPL") == 0);
+    size_t i;
+    for(i=0; i < sizeof(licok) / sizeof(licok[0]); i++)
+        if(strcmp(license, licok[i]) == 0)
+            return 1;
+   return 0;
  }

  static void set_license(struct module *mod, const char *license)


Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

