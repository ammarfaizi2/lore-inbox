Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265285AbUGGTYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbUGGTYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 15:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUGGTYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 15:24:19 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:42247 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265285AbUGGTYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 15:24:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] FAT: update document
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 08 Jul 2004 04:24:07 +0900
Message-ID: <87d637mxig.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 Documentation/filesystems/vfat.txt |   32 +++++++++++++++++++++++---------
 fs/Kconfig                         |   15 +++++++++------
 2 files changed, 32 insertions(+), 15 deletions(-)

diff -puN Documentation/filesystems/vfat.txt~fat_doc-update Documentation/filesystems/vfat.txt
--- linux-2.6.7/Documentation/filesystems/vfat.txt~fat_doc-update	2004-07-04 02:37:33.000000000 +0900
+++ linux-2.6.7-hirofumi/Documentation/filesystems/vfat.txt	2004-07-05 03:32:52.000000000 +0900
@@ -10,23 +10,35 @@ VFAT MOUNT OPTIONS
 ----------------------------------------------------------------------
 umask=###     -- The permission mask (for files and directories, see umask(1)).
                  The default is the umask of current process.
+
 dmask=###     -- The permission mask for the directory.
                  The default is the umask of current process.
+
 fmask=###     -- The permission mask for files.
                  The default is the umask of current process.
-codepage=###  -- Sets the codepage for converting to shortname characters
-		 on FAT and VFAT filesystems.  By default, codepage 437
-		 is used.  This is the default for the U.S. and some
-		 European countries.
-iocharset=name -- Character set to use for converting between 8 bit characters
-		 and 16 bit Unicode characters. Long filenames are stored on
-		 disk in Unicode format, but Unix for the most part doesn't
-		 know how to deal with Unicode. There is also an option of
-		 doing UTF8 translations with the utf8 option.
+
+codepage=###  -- Sets the codepage number for converting to shortname
+		 characters on FAT filesystem.
+		 By default, FAT_DEFAULT_CODEPAGE setting is used.
+
+iocharset=name -- Character set to use for converting between the
+		 encoding is used for user visible filename and 16 bit
+		 Unicode characters. Long filenames are stored on disk
+		 in Unicode format, but Unix for the most part doesn't
+		 know how to deal with Unicode.
+		 By default, FAT_DEFAULT_IOCHARSET setting is used.
+
+		 There is also an option of doing UTF8 translations
+		 with the utf8 option.
+
+		 NOTE: "iocharset=utf8" is not recommended. If unsure,
+		 you should consider the following option instead.
+
 utf8=<bool>   -- UTF8 is the filesystem safe version of Unicode that
 		 is used by the console.  It can be be enabled for the
 		 filesystem with this option. If 'uni_xlate' gets set,
 		 UTF8 gets disabled.
+
 uni_xlate=<bool> -- Translate unhandled Unicode characters to special
 		 escaped sequences.  This would let you backup and
 		 restore filenames that are created with any Unicode
@@ -37,6 +49,7 @@ uni_xlate=<bool> -- Translate unhandled 
 		 illegal on the vfat filesystem.  The escape sequence
 		 that gets used is ':' and the four digits of hexadecimal
 		 unicode.
+
 nonumtail=<bool> -- When creating 8.3 aliases, normally the alias will
                  end in '~1' or tilde followed by some number.  If this
                  option is set, then if the filename is 
@@ -45,6 +58,7 @@ nonumtail=<bool> -- When creating 8.3 al
                  be the short alias instead of 'longfi~1.txt'. 
                   
 quiet         -- Stops printing certain warning messages.
+
 check=s|r|n   -- Case sensitivity checking setting.
                  s: strict, case sensitive
                  r: relaxed, case insensitive
diff -puN fs/Kconfig~fat_doc-update fs/Kconfig
--- linux-2.6.7/fs/Kconfig~fat_doc-update	2004-07-04 02:37:33.000000000 +0900
+++ linux-2.6.7-hirofumi/fs/Kconfig	2004-07-05 04:31:56.000000000 +0900
@@ -678,18 +678,21 @@ config FAT_DEFAULT_CODEPAGE
 	default 437
 	help
 	  This option should be set to the codepage of your FAT filesystems.
-	  It can be overridden with the 'codepage' mount option.
+	  It can be overridden with the "codepage" mount option.
+	  See <file:Documentation/filesystems/vfat.txt> for more information.
 
 config FAT_DEFAULT_IOCHARSET
 	string "Default iocharset for FAT"
 	depends on VFAT_FS
 	default "iso8859-1"
 	help
-	  Set this to the default I/O character set you'd like FAT to use.
-	  It should probably match the character set that most of your
-	  FAT filesystems use, and can be overridded with the 'iocharset'
-	  mount option for FAT filesystems.  Note that UTF8 is *not* a
-	  supported charset for FAT filesystems.
+	  Set this to the default input/output character set you'd
+	  like FAT to use. It should probably match the character set
+	  that most of your FAT filesystems use, and can be overrided
+	  with the "iocharset" mount option for FAT filesystems.
+	  Note that "utf8" is not recommended for FAT filesystems.
+	  If unsure, you shouldn't set "utf8" to here.
+	  See <file:Documentation/filesystems/vfat.txt> for more information.
 
 config UMSDOS_FS
 #dep_tristate '    UMSDOS: Unix-like file system on top of standard MSDOS fs' CONFIG_UMSDOS_FS $CONFIG_MSDOS_FS
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
