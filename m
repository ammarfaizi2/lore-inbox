Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262843AbVCPXA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbVCPXA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbVCPXAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:00:14 -0500
Received: from smtp06.auna.com ([62.81.186.16]:33242 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S262847AbVCPW5x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 17:57:53 -0500
Date: Wed, 16 Mar 2005 22:57:46 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: [PATCH] make gconfig build again
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20050316040654.62881834.akpm@osdl.org>
	<1110985632l.8879l.0l@werewolf.able.es>
	<20050316132600.3f6e4df2.akpm@osdl.org>
In-Reply-To: <20050316132600.3f6e4df2.akpm@osdl.org> (from akpm@osdl.org on
	Wed Mar 16 22:26:00 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1111013866l.23273l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.16, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > On 03.16, Andrew Morton wrote:
> >  > 
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm4/
> >  > 
> >  ...
> >  >
> >  > +revert-gconfig-changes.patch
> >  > 
> >  >  Back out a recent change which broke gconfig.
> >  > 
> > 
> >  What was broken ?
> 
> hm.  I emailed you twice, and had a feeling that things weren't getting
> through.
> 
> The patch caused those little pixmap buttons across the top of the main
> window to vanish when using gtk+-1.2.10-28.1.  See
> http://www.zip.com.au/~akpm/linux/patches/stuff/x.jpg.
> 
> I now note that scripts/kconfig/gconf.c doesn't compile at all with the
> above backout patch.  Drat.
> 

This is enough to make it compile:

diff -ruN linux-2.6.11-mm4/scripts/kconfig/gconf.c linux-2.6.11-mm4-gconf/scripts/kconfig/gconf.c
--- linux-2.6.11-mm4/scripts/kconfig/gconf.c	2005-03-16 23:45:56.000000000 +0100
+++ linux-2.6.11-mm4-gconf/scripts/kconfig/gconf.c	2005-03-16 23:48:25.000000000 +0100
@@ -11,6 +11,7 @@
 #endif
 
 #include "lkc.h"
+#include "images.c"
 
 #include <glade/glade.h>
 #include <gtk/gtk.h>
@@ -1171,42 +1172,6 @@
 }
 
 
-/* Conf management */
-
-static const char *xpm_menu[] = {
-"12 12 2 1",
-"  c white",
-". c black",
-"            ",
-"            ",
-"  .         ",
-"  ..        ",
-"  ...       ",
-"  ....      ",
-"  .....     ",
-"  ....      ",
-"  ...       ",
-"  ..        ",
-"  .         ",
-"            "};
-
-static const char *xpm_void[] = {
-"12 12 2 1",
-"  c white",
-". c black",
-"            ",
-"            ",
-"            ",
-"            ",
-"            ",
-"            ",
-"            ",
-"            ",
-"            ",
-"            ",
-"            ",
-"            "};
-
 /* Fill a row of strings */
 static gchar **fill_row(struct menu *menu)
 {


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.11-jam5 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-6mdk)) #1


