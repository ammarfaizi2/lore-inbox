Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265810AbUGDWK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbUGDWK4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 18:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265813AbUGDWK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 18:10:56 -0400
Received: from smtp06.web.de ([217.72.192.224]:14731 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S265810AbUGDWKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 18:10:52 -0400
Subject: Re: [BUG] FAT broken in 2.6.7-bk15
From: Ali Akcaagac <aliakc@web.de>
To: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
Content-Type: text/plain
Date: Mon, 05 Jul 2004 00:11:01 +0200
Message-Id: <1088979061.1277.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ok after some further research I figured this out. My last working
> > version of the Linux Kernel was 2.6.7 which worked with my rescue
> > system. I now applied the bk* patches upwards to check which one caused
> > the issue and I figured that this happened between bk3 to bk4 (so the
> > problem occoured with the bk4 patch). The diskimage was created with
> > mtools 3.9.9 and worked perfectly before.

> Ah, my fault. I changed the handling of "codepage" options, but it wasn't
> mentioned on changelog at all. (Sorry, I didn't notice this changes.)
> 
> Now, the codepage option recognizes only real NLS codepage module.
> (It uses FAT_DEFAULT_CODEPAGE, not NLS_DEFAULT. And FAT_DEFAULT_CODEPAGE
> only recognizes the numbers.)
> 
> Previously, it recognized/loaded all NLS modules via CONFIG_NLS_DEFAULT,
> if it can't load the nls_cp437.ko or specified codepage.
> 
> But this is seriously wrong. For example, if fatfs using the
> nls_utf8.ko for codepage, it will store the wrong 8.3-alias to
> disk. (At least, windows can't read this. And several peoples reported
> this problem.)
> 
> Anyway, could you please check FAT_DEFAULT_CODE/FAT_DEFAULT_IOCHARSET
> and NLS_xxx in your .config.
> 
> Yes, this should be done automatically by config system. However...

Yeah here the .config snipplet. But I still wonder how this influences mounting an msdos or vfat partition. Unfortunately I am no expert in FAT related stuff but I assume that textual stuff stored in a filesystem shouldn't affect mounting and unmounting. The only thing NLS changes in a filesystem is special charakters for filenames but it doesn't change the technical structure of the FS itself so in worst case I only get some strange characters shown in filenames.

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set


