Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWDLSyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWDLSyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 14:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWDLSyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 14:54:36 -0400
Received: from xenotime.net ([66.160.160.81]:28289 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932217AbWDLSyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 14:54:36 -0400
Date: Wed, 12 Apr 2006 11:56:57 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: zippel@linux-m68k.org, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>
Subject: [PATCH] config: update usage/help info
Message-Id: <20060412115657.409b71bc.rdunlap@xenotime.net>
In-Reply-To: <20060412165929.GA20573@mars.ravnborg.org>
References: <20060406224134.0430e827.rdunlap@xenotime.net>
	<87odzdh1fp.fsf@duaron.myhome.or.jp>
	<20060409220426.8027953a.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0604121253540.32445@scrub.home>
	<20060412091751.feba2dd4.rdunlap@xenotime.net>
	<20060412165929.GA20573@mars.ravnborg.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2006 18:59:29 +0200 Sam Ravnborg wrote:

> > IMO the main points/questions are:
> > 
> > - where to document the command-line options and environment variables
> >   (including the recent KCONFIG_CONFIG):  in a usage() function or in
> >   Documentation/kbuild/usage.txt file?
> 
> The latter...
> make help was the other alternative and it is too big already.
> 
> For kbuild I also need to add some stuff.

Here's a shot at it, although it seemed that top-level README was
sufficient for the make *config additions.  We can move whatever you
think should be moved to a new file.
(This is missing a recent KCONFIG_OVERWRITECONFIG environment variable
that I think Roman just added.)
---

From: Randy Dunlap <rdunlap@xenotime.net>

Replace outdated help message with a reference to README.
Update README for make *config variants and environment
variable info.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 README                 |   23 ++++++++++++++++++++++-
 scripts/kconfig/conf.c |    3 ++-
 2 files changed, 24 insertions(+), 2 deletions(-)

--- linux-2617-rc1.orig/scripts/kconfig/conf.c
+++ linux-2617-rc1/scripts/kconfig/conf.c
@@ -5,6 +5,7 @@
 
 #include <ctype.h>
 #include <stdlib.h>
+#include <stdio.h>
 #include <string.h>
 #include <unistd.h>
 #include <time.h>
@@ -546,7 +547,7 @@ int main(int ac, char **av)
 			break;
 		case 'h':
 		case '?':
-			printf("%s [-o|-s] config\n", av[0]);
+			fprintf(stderr, "See README for usage info\n");
 			exit(0);
 		}
 	}
--- linux-2617-rc1.orig/README
+++ linux-2617-rc1/README
@@ -165,10 +165,31 @@ CONFIGURING the kernel:
 	"make xconfig"     X windows (Qt) based configuration tool.
 	"make gconfig"     X windows (Gtk) based configuration tool.
 	"make oldconfig"   Default all questions based on the contents of
-			   your existing ./.config file.
+			   your existing ./.config file and asking about
+			   new config symbols.
 	"make silentoldconfig"
 			   Like above, but avoids cluttering the screen
 			   with questions already answered.
+	"make defconfig"   Create a ./.config file by using the default
+			   symbol values from arch/$ARCH/defconfig.
+	"make allyesconfig"
+			   Create a ./.config file by setting symbol
+			   values to 'y' as much as possible.
+	"make allmodconfig"
+			   Create a ./.config file by setting symbol
+			   values to 'm' as much as possible.
+	"make allnoconfig" Create a ./.config file by setting symbol
+			   values to 'n' as much as possible.
+	"make randconfig"  Create a ./.config file by setting symbol
+			   values to random values.
+
+   The allyesconfig/allmodconfig/allnoconfig/randconfig variants can
+   also use the environment variable KCONFIG_ALLCONFIG to specify a
+   filename that contains config options that the user requires to be
+   set to a specific value.  If KCONFIG_ALLCONFIG=filename is not used,
+   "make *config" checks for a file named "all{yes/mod/no/random}.config"
+   for symbol values that are to be forced.  If this file is not found,
+   it checks for a file named "all.config" to contain forced values.
    
 	NOTES on "make config":
 	- having unnecessary drivers will make the kernel bigger, and can
