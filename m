Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUGLOCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUGLOCq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266836AbUGLOCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:02:46 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:9738 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266835AbUGLOCn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:02:43 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.8-rc1
References: <Pine.LNX.4.58.0407111120010.1764@ppc970.osdl.org>
	<Pine.GSO.4.58.0407121356510.17199@waterleaf.sonytel.be>
	<87pt71jre2.fsf@devron.myhome.or.jp>
	<Pine.GSO.4.58.0407121524420.17199@waterleaf.sonytel.be>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 12 Jul 2004 23:02:05 +0900
In-Reply-To: <Pine.GSO.4.58.0407121524420.17199@waterleaf.sonytel.be>
Message-ID: <87llhpjpcy.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> > configurable FAT_FS, instead it is internally used only.
> 
> If it's for internal use only, perhaps it should not be presented to the user
> and both MSDOS_FS and VFAT_FS should simply select it in Kconfig?

Yes. We have the select now, it should be fixed.

The quick fix are following. I'm going to also remove the
FAT_DEFAULT_xxx before 2.6.8 release.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN fs/Kconfig~fat_fs-no-configurable fs/Kconfig
--- linux-2.6.8-rc1/fs/Kconfig~fat_fs-no-configurable	2004-07-12 22:42:31.000000000 +0900
+++ linux-2.6.8-rc1-hirofumi/fs/Kconfig	2004-07-12 22:42:31.000000000 +0900
@@ -552,7 +552,7 @@ endmenu
 menu "DOS/FAT/NT Filesystems"
 
 config FAT_FS
-	tristate "DOS FAT fs support"
+	tristate
 	select NLS
 	help
 	  If you want to use one of the FAT-based file systems (the MS-DOS,
@@ -595,7 +595,7 @@ config FAT_FS
 
 config MSDOS_FS
 	tristate "MSDOS fs support"
-	depends on FAT_FS
+	select FAT_FS
 	help
 	  This allows you to mount MSDOS partitions of your hard drive (unless
 	  they are compressed; to access compressed MSDOS partitions under
@@ -624,7 +624,7 @@ config MSDOS_FS
 
 config VFAT_FS
 	tristate "VFAT (Windows-95) fs support"
-	depends on FAT_FS
+	select FAT_FS
 	help
 	  This option provides support for normal Windows file systems with
 	  long filenames.  That includes non-compressed FAT-based file systems
_
