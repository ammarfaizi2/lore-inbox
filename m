Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265766AbUFTQHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbUFTQHJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 12:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUFTQHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 12:07:09 -0400
Received: from mailgate1.uni-kl.de ([131.246.120.5]:44160 "EHLO
	mailgate1.uni-kl.de") by vger.kernel.org with ESMTP id S265766AbUFTQG7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 12:06:59 -0400
Date: Sun, 20 Jun 2004 18:06:56 +0200
From: Eduard Bloch <edi@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FAT: doesn't recognize "iocharset=utf8" and doesn't use NLS_DEFAULT
Message-ID: <20040620160656.GA14769@zombie.inka.de>
References: <87659mjnps.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87659mjnps.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* OGAWA Hirofumi [Sun, Jun 20 2004, 11:41:51PM]:

> Recently, the distributor has set "utf8" to NLS_DEFAULT, therefore,

Excuse my ignorance but I will comment this having things from various
HOWTOs in mind.

> FAT uses the "iocharset=utf8" as default.  But, since "iocharset=utf8"
> doesn't provide the function (lower <-> upper conversion) which FAT
> needs, so FAT can't provide suitable behavior.

I (as user) am completely confused now. I though that "iocharset" was
the option to convert the (UCS) VFAT names from Unicode (on disk) to some
limited encoding represented the Unix system (eg. ISO-8859-1) and vice
versa; but it was limited to single-byte encodings, so "utf8" switch was
invented to do direct UCS<->UTF-8 conversion.

> Then, this patch does,
> 
>      - doesn't recognize "utf8" as "iocharset"
>      - doesn't use NLS_DEFAULT as default "iocharset"

Is it possible to extend iocharset to allow UCS<->UTF-8 conversion?
Wouldn't this make the utf8 switch obsolete?

>      - instead of NLS_DEFAULT, adds FAT_DEFAULT_CODEPAGE and
>        FAT_DEFAULT_IOCHARSET

Excuse me, why do you need a special IOCHARSET setting for FAT
filesystems? Why should it be different from any other filesystems? Are
there any other filesystems except those from MS that support (widechar)
Unicode filenames on disk?

> NOTE: the following looks like buggy, so it's not recommended
> 
>     "codepage=437,iocharset=iso8859-1,utf8"
> 
> however, some utf8 file name can handle. (in this case, it uses the
> table of iso8859-1 for lower <-> upper conversion)

What do you man with "lower <-> upper"? The letter case? Isn't this a
task for the FAT16-names access method?

> +config FAT_DEFAULT_CODEPAGE
> +	int "Default codepage for FAT"
> +	depends on MSDOS_FS || VFAT_FS
> +	default 437
> +	help
> +	  This option should be set to the codepage of your FAT filesystems.
> +	  It can be overridden with the 'codepage' mount option.

Should describe explicitely that only the short "MS-DOS" names are meant
here.

> +config FAT_DEFAULT_IOCHARSET
> +	string "Default iocharset for FAT"
> +	depends on VFAT_FS
> +	default "iso8859-1"
> +	help
> +	  Set this to the default I/O character set you'd like FAT to use.

What is the "I/O charset"? The description is completely useless for a
user, it does not explain what is converted and where and why and what
happens with the data or what is this good for. In contrary, I would
think that this is the conversion method from a local encoding to equaly
limited I/O encoding.

> +	  It should probably match the character set that most of your
> +	  FAT filesystems use, and can be overridded with the 'iocharset'
> +	  mount option for FAT filesystems.  Note that UTF8 is *not* a
> +	  supported charset for FAT filesystems.

UTF-8 is not a charset, it is an encoding. Don't mix things together.

Regards,
Eduard.
-- 
Die ganz ganz Schlauen sehen um fünf Ecken - und sind geradeaus blind.
		-- Benjamin Franklin
