Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136110AbRDVNUT>; Sun, 22 Apr 2001 09:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136108AbRDVNT7>; Sun, 22 Apr 2001 09:19:59 -0400
Received: from mail.mesatop.com ([208.164.122.9]:42761 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S136107AbRDVNT5>;
	Sun, 22 Apr 2001 09:19:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.3-ac12 fix renaming of CONFIG_SGI_PROM_CONSOLE 
Date: Sun, 22 Apr 2001 07:18:55 -0600
X-Mailer: KMail [version 1.2]
Cc: alan@lxorguk.ukuu.org.uk, esr@thyrsus.com, elenstev@mesatop.com
MIME-Version: 1.0
Message-Id: <01042207185504.01451@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like in 2.4.3-ac12  the option CONFIG_SGI_PROM_CONSOLE 
was renamed to CONFIG_ARC_CONSOLE in the Configure.help file.

However, in /usr/src/linux/arch/mips/config.in, we still have this line:

      bool 'SGI PROM Console Support' CONFIG_SGI_PROM_CONSOLE

and the new name CONFIG_ARC_CONSOLE does not appear in any Config.in
files.  I do see that this option appears in the arch/mips/arc/Makefile , and it
is used in arch/mips/arc/console.c.  And references to CONFIG_SGI_PROM_CONSOLE
were deleted from arch/mips/arc/console.c.

Here is a patch to complete the changeover.

Steven

--- linux/arch/mips/config.in.ac12	Sun Apr 22 07:06:04 2001
+++ linux/arch/mips/config.in	Sun Apr 22 07:09:13 2001
@@ -351,7 +351,7 @@
       else
 	 define_bool CONFIG_FONT_8x16 y
       fi
-      bool 'SGI PROM Console Support' CONFIG_SGI_PROM_CONSOLE
+      bool 'SGI PROM Console Support' CONFIG_ARC_CONSOLE
    fi
    bool 'Unix98 PTY support' CONFIG_UNIX98_PTYS
    if [ "$CONFIG_UNIX98_PTYS" = "y" ]; then


