Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262242AbRE2Wgi>; Tue, 29 May 2001 18:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262288AbRE2Wg2>; Tue, 29 May 2001 18:36:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:59632 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262242AbRE2WgT>;
	Tue, 29 May 2001 18:36:19 -0400
Date: Tue, 29 May 2001 18:36:13 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 84 bugs in 2.4.4/2.4.4-ac8 where NULL pointers are
 deref'd
In-Reply-To: <200105292149.OAA29781@csl.Stanford.EDU>
Message-ID: <Pine.GSO.4.21.0105291825410.11321-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 May 2001, Dawson Engler wrote:

> [BUG]  seems like it.  it's not guarded.  or is there some weird dependence?
> /u2/engler/mc/oses/linux/2.4.4-ac8/fs/ext2/dir.c:61:ext2_check_dir_entry: ERROR:INTERNAL_NULL:53:61: [type=set] (set at line 53) Dereferencing NULL ptr "dir" illegally!

No, it's simply a lump of fossilized crap. However, adding one more check
here is not a solution - it only adds to ugliness. The real fix is to get
rid of checking simgle entries and do all checks when we read the page -
at that point we obviously have the inode. Same goes for the second one.

Patch is available - see ftp.math.psu.edu/pub/viro/ext2-dir-patch-S4.gz
It's going to be very early 2.5.

