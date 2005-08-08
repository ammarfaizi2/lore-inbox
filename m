Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVHHWdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVHHWdG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVHHWcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:32:47 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:50086 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S932320AbVHHWc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:32:29 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: [PATCH] Posix file attribute support on VFAT
To: Hiroyuki Machida <machida@sm.sony.co.jp>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 09 Aug 2005 00:32:18 +0200
References: <4zfoZ-5u4-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1E2GAN-0003Pj-2l@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiroyuki Machida <machida@sm.sony.co.jp> wrote:

> For newly created and/or modified files/dirs, system can utilize
> full posix attributes, because memory resident inode storage can
> hold those. After umount-mount cycle, system may lose some
> attributes to preserve VFAT format.

Inodes may be reclaimed, therefore you might also lose some attributes at
runtime. For your users, that will look like a heisenbug. A similar bug
has been reported for procfs. Is your implementation affected?

> - Special file
>         To distinguish special files, look if this fat dir entry 
>         has ATTR_SYS, first. If it has ATTR_SYS, then check
>         1st. LSB bit in ctime_cs, refered as "special file flag".
>         If set,  this file is created under VFAT with "posix_attr". 
>         Look up TYPE field to decide special file type.
>         This spcial file detection mothod has some flaw to make
>         potential confusion. E.g. some system file created under
>         dos/win may be treated as special file.  However in most case,
>         user don't create system file under dos/win.

You can add additional magic, e.g.: nodes must be empty, except for symlinks
which must be not larger than 4KB (current PATH_MAX?). This will get rid
of io.sys, logo.sys etc.\. If you want to be really sure, prepend a magic
code to the on-disk representation of symlinks.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
