Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267222AbTBDLDc>; Tue, 4 Feb 2003 06:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbTBDLDc>; Tue, 4 Feb 2003 06:03:32 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:14486 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267222AbTBDLDa>;
	Tue, 4 Feb 2003 06:03:30 -0500
Date: Tue, 4 Feb 2003 12:12:56 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200302041112.MAA02028@harpo.it.uu.se>
To: hpa@zytor.com
Subject: Re: [UPDATED PATCH] Removal of boot sector code
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jan 2003 19:12:31 -0800, H. Peter Anvin wrote:
>I have updated the boot sector removal code so that it now:
>
>a) Supports "make zdisk", "make bzdisk" and "make fdimage"
>   (Requires mtools and syslinux, but will work as a non-root user
>   as long as you have your floppy in /etc/fstab or syslinux setuid
>   root.)
>
>   There is also "make fdimage288" to create a 2.88 MB floppy image.

This works reasonably well for me, but it does require
MS-DOS fs support in the kernel, and having a /dev/fd0 entry
in /etc/fstab with "user" permissions (for some reason, "owner"
doesn't work).

I'd like to use my own recipe for "make bzdisk", to avoid these
restrictions. What about having "make bzdisk" optionally invoke
and external script, similarly to how "make install" works?

>The boot sector was very cool in 1992, but in 2003 it has outlived its
>usefulness, and it no longer supports what Linux boot loaders need,
>especially not with the 1 MB limit and the lack of support for
>non-legacy floppy devices (the geometry detection hack fails on
>those.)  Even a relatively simple 2.5 build exceeds that size for me,
>and with this patch "make bzdisk" actually works, whereas the original
>boot sector doesn't.

Indeed. Another reason is that gcc-3.2 generates (for me anyway)
much larger kernel images than gcc-2.95.3.

/Mikael
