Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTJFQ6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbTJFQ6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:58:08 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:271 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263857AbTJFQ5U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:57:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix cleanup option of fat (4/6)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 07 Oct 2003 01:57:13 +0900
Message-ID: <8765j2pamu.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is just misc cleanup of fat option.

Please apply.

 linux-2.6.0-test6-hirofumi/fs/fat/inode.c |  137 ++++++++++--------------------
 1 files changed, 47 insertions(+), 90 deletions(-)

diff -puN fs/fat/inode.c~fat_cleanup-option fs/fat/inode.c
--- linux-2.6.0-test6/fs/fat/inode.c~fat_cleanup-option	2003-10-07 01:51:39.000000000 +0900
+++ linux-2.6.0-test6-hirofumi/fs/fat/inode.c	2003-10-07 01:51:39.000000000 +0900
@@ -246,25 +246,15 @@ static int fat_show_options(struct seq_f
 	return 0;
 }
 
-static void print_obsolete_option(char *optname)
-{
-	printk(KERN_INFO "FAT: %s option is obsolete, "
-			"not supported now\n", optname);
-}
-
 enum {
-	Opt_blocksize, Opt_charset, Opt_check_n, Opt_check_r, Opt_check_s,
-	Opt_fat, Opt_codepage, Opt_conv_a, Opt_conv_b, Opt_conv_t,
-	Opt_debug, Opt_dots, Opt_err, Opt_gid, Opt_immutable,
-	Opt_nocase, Opt_nodots, Opt_quiet, Opt_showexec, Opt_uid,
-	Opt_shortname_lower, Opt_shortname_win95, Opt_shortname_winnt, Opt_shortname_mixed,
-	Opt_umask, Opt_dmask, Opt_fmask, Opt_posix, Opt_cvf_format, Opt_cvf_options,
-	Opt_utf8_off, Opt_utf8_no, Opt_utf8_false,
-	Opt_utf8_on, Opt_utf8_yes, Opt_utf8_true, Opt_utf8_opt,
-	Opt_uni_xl_off, Opt_uni_xl_no, Opt_uni_xl_false,
-	Opt_uni_xl_on, Opt_uni_xl_yes, Opt_uni_xl_true, Opt_uni_xl_opt,
-	Opt_nonumtail_off, Opt_nonumtail_no, Opt_nonumtail_false,
-	Opt_nonumtail_on, Opt_nonumtail_yes, Opt_nonumtail_true, Opt_nonumtail_opt,
+	Opt_check_n, Opt_check_r, Opt_check_s, Opt_uid, Opt_gid,
+	Opt_umask, Opt_dmask, Opt_fmask, Opt_codepage, Opt_nocase,
+	Opt_quiet, Opt_showexec, Opt_debug, Opt_immutable,
+	Opt_dots, Opt_nodots,
+	Opt_charset, Opt_shortname_lower, Opt_shortname_win95,
+	Opt_shortname_winnt, Opt_shortname_mixed, Opt_utf8_no, Opt_utf8_yes,
+	Opt_uni_xl_no, Opt_uni_xl_yes, Opt_nonumtail_no, Opt_nonumtail_yes,
+	Opt_obsolate, Opt_err,
 };
 
 static match_table_t fat_tokens = {
@@ -274,35 +264,35 @@ static match_table_t fat_tokens = {
 	{Opt_check_r, "check=r"},
 	{Opt_check_s, "check=s"},
 	{Opt_check_n, "check=n"},
-	{Opt_conv_b, "conv=binary"},
-	{Opt_conv_t, "conv=text"},
-	{Opt_conv_a, "conv=auto"},
-	{Opt_conv_b, "conv=b"},
-	{Opt_conv_t, "conv=t"},
-	{Opt_conv_a, "conv=a"},
 	{Opt_uid, "uid=%d"},
 	{Opt_gid, "gid=%d"},
 	{Opt_umask, "umask=%o"},
 	{Opt_dmask, "dmask=%o"},
 	{Opt_fmask, "fmask=%o"},
-	{Opt_fat, "fat=%d"},
 	{Opt_codepage, "codepage=%d"},
-	{Opt_blocksize, "blocksize=%d"},
 	{Opt_nocase, "nocase"},
-	{Opt_cvf_format, "cvf_format=%20s"},
-	{Opt_cvf_options, "cvf_options=%100s"},
 	{Opt_quiet, "quiet"},
 	{Opt_showexec, "showexec"},
 	{Opt_debug, "debug"},
 	{Opt_immutable, "sys_immutable"},
-	{Opt_posix, "posix"},
+	{Opt_obsolate, "conv=binary"},
+	{Opt_obsolate, "conv=text"},
+	{Opt_obsolate, "conv=auto"},
+	{Opt_obsolate, "conv=b"},
+	{Opt_obsolate, "conv=t"},
+	{Opt_obsolate, "conv=a"},
+	{Opt_obsolate, "fat=%d"},
+	{Opt_obsolate, "blocksize=%d"},
+	{Opt_obsolate, "cvf_format=%20s"},
+	{Opt_obsolate, "cvf_options=%100s"},
+	{Opt_obsolate, "posix"},
 	{Opt_err, NULL}
 };
 static match_table_t msdos_tokens = {
 	{Opt_nodots, "nodots"},
 	{Opt_nodots, "dotsOK=no"},
-	{Opt_dots, "dotsOK=yes"},
 	{Opt_dots, "dots"},
+	{Opt_dots, "dotsOK=yes"},
 	{Opt_err, NULL}
 };
 static match_table_t vfat_tokens = {
@@ -311,27 +301,27 @@ static match_table_t vfat_tokens = {
 	{Opt_shortname_win95, "shortname=win95"},
 	{Opt_shortname_winnt, "shortname=winnt"},
 	{Opt_shortname_mixed, "shortname=mixed"},
-	{Opt_utf8_off, "utf8=0"},	/* 0 or no or false */
+	{Opt_utf8_no, "utf8=0"},		/* 0 or no or false */
 	{Opt_utf8_no, "utf8=no"},
-	{Opt_utf8_false, "utf8=false"},
-	{Opt_utf8_on, "utf8=1"},	/* empty or 1 or yes or true */
+	{Opt_utf8_no, "utf8=false"},
+	{Opt_utf8_yes, "utf8=1"},		/* empty or 1 or yes or true */
 	{Opt_utf8_yes, "utf8=yes"},
-	{Opt_utf8_true, "utf8=true"},
-	{Opt_utf8_opt, "utf8"},
-	{Opt_uni_xl_off, "uni_xlate=0"},	/* 0 or no or false */
+	{Opt_utf8_yes, "utf8=true"},
+	{Opt_utf8_yes, "utf8"},
+	{Opt_uni_xl_no, "uni_xlate=0"},		/* 0 or no or false */
 	{Opt_uni_xl_no, "uni_xlate=no"},
-	{Opt_uni_xl_false, "uni_xlate=false"},
-	{Opt_uni_xl_on, "uni_xlate=1"},		/* empty or 1 or yes or true */
+	{Opt_uni_xl_no, "uni_xlate=false"},
+	{Opt_uni_xl_yes, "uni_xlate=1"},	/* empty or 1 or yes or true */
 	{Opt_uni_xl_yes, "uni_xlate=yes"},
-	{Opt_uni_xl_true, "uni_xlate=true"},
-	{Opt_uni_xl_opt, "uni_xlate"},
-	{Opt_nonumtail_off, "nonumtail=0"},	/* 0 or no or false */
+	{Opt_uni_xl_yes, "uni_xlate=true"},
+	{Opt_uni_xl_yes, "uni_xlate"},
+	{Opt_nonumtail_no, "nonumtail=0"},	/* 0 or no or false */
 	{Opt_nonumtail_no, "nonumtail=no"},
-	{Opt_nonumtail_false, "nonumtail=false"},
-	{Opt_nonumtail_on, "nonumtail=1"},	/* empty or 1 or yes or true */
+	{Opt_nonumtail_no, "nonumtail=false"},
+	{Opt_nonumtail_yes, "nonumtail=1"},	/* empty or 1 or yes or true */
 	{Opt_nonumtail_yes, "nonumtail=yes"},
-	{Opt_nonumtail_true, "nonumtail=true"},
-	{Opt_nonumtail_opt, "nonumtail"},
+	{Opt_nonumtail_yes, "nonumtail=true"},
+	{Opt_nonumtail_yes, "nonumtail"},
 	{Opt_err, NULL}
 };
 
@@ -380,10 +370,10 @@ static int parse_options(char *options, 
 			opts->name_check = 's';
 			break;
 		case Opt_check_r:
- 				opts->name_check = 'r';
+			opts->name_check = 'r';
 			break;
 		case Opt_check_n:
- 				opts->name_check = 'n';
+			opts->name_check = 'n';
 			break;
 		case Opt_nocase:
 			if (!is_vfat)
@@ -435,8 +425,6 @@ static int parse_options(char *options, 
 			if (match_int(&args[0], &option))
 				return 0;
 			opts->codepage = option;
-			printk("MSDOS FS: Using codepage %d\n",
- 					opts->codepage);
 			break;
 
 		/* msdos specific */
@@ -453,8 +441,6 @@ static int parse_options(char *options, 
 			opts->iocharset = match_strdup(&args[0]);
 			if (!opts->iocharset)
 				return 0;
-			printk("MSDOS FS: IO charset %s\n",
-			       opts->iocharset);
 			break;
 		case Opt_shortname_lower:
 			opts->shortname = VFAT_SFN_DISPLAY_LOWER
@@ -472,63 +458,34 @@ static int parse_options(char *options, 
 			opts->shortname = VFAT_SFN_DISPLAY_WINNT
 					| VFAT_SFN_CREATE_WIN95;
 			break;
-		case Opt_utf8_off:	/* 0 or no or false */
-		case Opt_utf8_no:
-		case Opt_utf8_false:
+		case Opt_utf8_no:		/* 0 or no or false */
 			opts->utf8 = 0;
 			break;
-		case Opt_utf8_on:	/* empty or 1 or yes or true */
-		case Opt_utf8_opt:
-		case Opt_utf8_yes:
-		case Opt_utf8_true:
+		case Opt_utf8_yes:		/* empty or 1 or yes or true */
 			opts->utf8 = 1;
 			break;
-		case Opt_uni_xl_off:	/* 0 or no or false */
-		case Opt_uni_xl_no:
-		case Opt_uni_xl_false:
+		case Opt_uni_xl_no:		/* 0 or no or false */
 			opts->unicode_xlate = 0;
 			break;
-		case Opt_uni_xl_on:	/* empty or 1 or yes or true */
-		case Opt_uni_xl_yes:
-		case Opt_uni_xl_true:
-		case Opt_uni_xl_opt:
+		case Opt_uni_xl_yes:		/* empty or 1 or yes or true */
 			opts->unicode_xlate = 1;
 			break;
-		case Opt_nonumtail_off:		/* 0 or no or false */
-		case Opt_nonumtail_no:
-		case Opt_nonumtail_false:
+		case Opt_nonumtail_no:		/* 0 or no or false */
 			opts->numtail = 1;	/* negated option */
 			break;
-		case Opt_nonumtail_on:		/* empty or 1 or yes or true */
-		case Opt_nonumtail_yes:
-		case Opt_nonumtail_true:
-		case Opt_nonumtail_opt:
+		case Opt_nonumtail_yes:		/* empty or 1 or yes or true */
 			opts->numtail = 0;	/* negated option */
 			break;
 
 		/* obsolete mount options */
-		case Opt_conv_b:
-		case Opt_conv_t:
-		case Opt_conv_a:
-			print_obsolete_option("conv");
-			break;
-		case Opt_blocksize:
-			print_obsolete_option("blocksize");
-			break;
-		case Opt_posix:
-			print_obsolete_option("posix");
-			break;
-		case Opt_fat:
-			print_obsolete_option("fat");
-			break;
-		case Opt_cvf_format:
-		case Opt_cvf_options:
-			print_obsolete_option("cvf");
+		case Opt_obsolate:
+			printk(KERN_INFO "FAT: \"%s\" option is obsolete, "
+			       "not supported now\n", p);
 			break;
 		/* unknown option */
 		default:
 			printk(KERN_ERR "FAT: Unrecognized mount option \"%s\" "
-					"or missing value\n", p);
+			       "or missing value\n", p);
 			return 0;
 		}
 	}

_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
