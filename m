Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272402AbTHIPuN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 11:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272403AbTHIPuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 11:50:13 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:3335 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S272402AbTHIPuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 11:50:07 -0400
To: linux-kernel@vger.kernel.org
Subject: [RFC] ioctl vs xattr for the filesystem specific attributes
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 10 Aug 2003 00:49:59 +0900
Message-ID: <8765l67rvc.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Bastien Roucaries <roucariesbastien@yahoo.fr> writes:

> This patch implement an "extended attributes" (XATTR) hook in aim to read or
> modify specific  fatfs flags' like ARCHIVE or SYSTEM.
> 
> I believe it's a good idea  because :
> 	- PAX ( GNU replacement of tar) save and restore XATTRs, so you can make more
> exact save of FATfs without use of specific programs.
> 	- It's an elegant means to avoid use of mattrib.
> 	- Samba can use this .
> but CONS :
> 	- use 2 Kb of kernel memory.

Bastien Roucaries <roucariesbastien@yahoo.fr> writes:

> Indeed some flags are shared by many namespace for instance immutable is 
> shared by xfs,ext2/3,jfs and by the fat ( with a special mount option). 
> Compress also is a very common flag
> This flags are in the "common" sub-namespace.
> 
> But some are fs specifics for instance notail attr of reiserfs,shortname of 
> fat.They are in the the "spec"sub-namespace

I received the above email.

This read/modify the file attributes of filesystem specific via xattr
interface (in this case, ARCHIVE, SYSTEM, HIDDEN flags of fatfs).

Yes, also we can provide it via ioctl like ext2/ext3 does now.

But if those flags provides by xattr interfaces and via one namespace
prefix, I guess the app can save/restore easy without dependency of
one fs.

Which interface would we use for attributes of filesystem specific?
Also if we use xattr, what namepace prefix should be used?

Any idea?

Thanks.

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
