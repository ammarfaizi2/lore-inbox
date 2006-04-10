Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWDJFCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWDJFCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 01:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWDJFCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 01:02:15 -0400
Received: from xenotime.net ([66.160.160.81]:8667 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750975AbWDJFCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 01:02:14 -0400
Date: Sun, 9 Apr 2006 22:04:26 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org, sam@ravnborg.org
Subject: Re: [RFC/POC] multiple CONFIG y/m/n
Message-Id: <20060409220426.8027953a.rdunlap@xenotime.net>
In-Reply-To: <87odzdh1fp.fsf@duaron.myhome.or.jp>
References: <20060406224134.0430e827.rdunlap@xenotime.net>
	<87odzdh1fp.fsf@duaron.myhome.or.jp>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Apr 2006 00:04:26 +0900 OGAWA Hirofumi wrote:

> "Randy.Dunlap" <rdunlap@xenotime.net> writes:
> 
> > Comments?
> 
> Umm... Oh, how about the following?  It seems work...
> 
> 	$ perl -spi -e 's/CONFIG_SND.*//' .config
>         $ KCONFIG_ALLCONFIG=.config make allmodconfig or allyesconfig

Hrm, that points out a lack of documentation for this feature.

Would the kconfig/kbuild people prefer this documentation in the source
code (see below) or in Documentation/kbuild/somefile ?

---
---
 scripts/kconfig/conf.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

--- linux-2617-rc1.orig/scripts/kconfig/conf.c
+++ linux-2617-rc1/scripts/kconfig/conf.c
@@ -504,6 +504,24 @@ static void check_conf(struct menu *menu
 		check_conf(child);
 }
 
+void usage(char *progname)
+{
+	printf("%s [-o|-s|-d|-D|-n|-m|-y|-r] Kconfig_filename\n", progname);
+	printf("  -o: oldconfig: ask only about new config symbols\n");
+	printf("  -s: silentoldconfig: don't ask about any symbol values\n");
+	printf("  -d: defconfig: use default symbol values\n");
+	printf("  -D: use default symbol values from the specified config file\n");
+	printf("  -n: set unknown symbol values to 'n'\n");
+	printf("  -m: set unknown symbol values to 'm'\n");
+	printf("  -y: set unknown symbol values to 'y'\n");
+	printf("  -r: set unknown symbol values randomly to one of y/m/n\n");
+	printf("The n/m/y/r options can also use the environment variable KCONFIG_ALLCONFIG\n");
+	printf("  to specify a filename that contains config options that are\n");
+	printf("  to be set to a specific value.  Otherwise config checks for\n");
+	printf("  all{no,mod,yes,random}.config and all.config\n");
+	exit(0);
+}
+
 int main(int ac, char **av)
 {
 	int i = 1;
@@ -546,8 +564,8 @@ int main(int ac, char **av)
 			break;
 		case 'h':
 		case '?':
-			printf("%s [-o|-s] config\n", av[0]);
-			exit(0);
+			usage(av[0]);
+			break;
 		}
 	}
   	name = av[i];
