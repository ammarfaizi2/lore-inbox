Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUJROJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUJROJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 10:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUJROJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 10:09:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7296 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266517AbUJROJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 10:09:47 -0400
Date: Mon, 18 Oct 2004 10:09:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: signed kernel modules?
In-Reply-To: <E1CJXww-0006F4-00@chiark.greenend.org.uk>
Message-ID: <Pine.LNX.4.61.0410181001440.3963@chaos.analogic.com>
References: <27277.1097702318@redhat.com> <Pine.LNX.4.61.0410150723180.8573@chaos.analogic.com>
 <1097843492.29988.6.camel@weaponx.rchland.ibm.com> <200410151153.08527.gene.heskett@verizon.net>
 <1097857049.29988.29.camel@weaponx.rchland.ibm.com>
 <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com>
 <1097860121.13633.358.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.61.0410151319460.6877@chaos.analogic.com>
 <1097873791.5119.10.camel@krustophenia.net> <20041015211809.GA27783@kroah.com>
 <4170426E.5070108@nortelnetworks.com> <Pine.LNX.4.61.0410151744220.3651@chaos.analogic.com>
 <Pine.LNX.4.61.0410151744220.3651@chaos.analogic.com>
 <Pine.LNX.4.61.0410180845040.3512@chaos.analogic.com>
 <E1CJXww-0006F4-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004, Matthew Garrett wrote:

> Richard B. Johnson <root@chaos.analogic.com> wrote:
>
>> If the whole module license issue is truly one of being able
>> to review the source, then certainly nobody would fear the
>> inclusion of a "PUBLIC" license string. This would fit the
>> broad classification of publicly-available sources, not
>> necessarily just in the "Public domain". For instance, when
>> a company puts the sources for some driver on it's Web Page,
>> but doesn't want to have anything to do with Mr. Stallman.
>
> This potentially leds to arguments about whether developers who have
> seen your publically available code are then tainted. If you don't want

Tainted??? Tainted to what. The stated reason for having module-
license strings in kernel modules was to save developers from
having to locate "bugs" that were caused by proprietary modules
for which there was no source-code available. Now, you say that
if somebody were to review publicly-available source-code, they
become tainted?  This is unmitigated political bullshit.

> anything to do with Mr. Stallman, why not just use a BSD-style license?
>
> -- 
> Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
>

Because it doesn't allow "BSD"!  Also, even my mailer doesn't
like the patch!!! Here it is again....


--- linux-2.6.8/kernel/module.c.orig	2004-10-18 08:21:28.000000000 -0400
+++ linux-2.6.8/kernel/module.c	2004-10-18 08:37:19.000000000 -0400
@@ -48,6 +48,18 @@
  #define ARCH_SHF_SMALL 0
  #endif

+/*
+ *  List of acceptible module-license strings.
+ */
+static const char *licok[]= {
+    "GPL",
+    "GPL v2",
+    "GPL and additional rights",
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

