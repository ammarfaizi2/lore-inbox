Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262658AbRE3IxP>; Wed, 30 May 2001 04:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262659AbRE3IxF>; Wed, 30 May 2001 04:53:05 -0400
Received: from smtp4.jp.psi.net ([154.33.63.114]:43794 "EHLO smtp4.jp.psi.net")
	by vger.kernel.org with ESMTP id <S262658AbRE3Iwz>;
	Wed, 30 May 2001 04:52:55 -0400
Message-ID: <3B14B3A2.2843422E@centurysys.co.jp>
Date: Wed, 30 May 2001 17:47:30 +0900
From: Tania Oka <tania@centurysys.co.jp>
Organization: Century Systems
X-Mailer: Mozilla 4.75 [ja] (Win98; U)
X-Accept-Language: ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: glenn@centurysys.co.jp
Subject: boundary condition bug in do_mmap()
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

There seems to be a boundary condition bug in do_mmap()
(include/linux/mm.h).  It is in kernels as late as 2.4.4 (not sure about
later).   I saw it reported on a mailing list a year ago but I guess it
didn't make it to the right place.

In the inline function do_mmap(), there is a check for overflow of the
topmost address (line 449 of include/linux/mm.h in the 2.4.4 kernel I
have):

    if ((offset + PAGE_ALIGN(len)) < offset)

This test causes the function to return -EINVAL if offset is 0xfffff000
and len is 0x1000, although these should be valid values to map the last
4K according to the mmap() man page.

Please forward this to the right place.  I couldn't find anyone specific
in the MAINTAINERS file.

Thank you,
Tania

