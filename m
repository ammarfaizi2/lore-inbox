Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUKPJJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUKPJJJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 04:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbUKPJJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 04:09:09 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:44748 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261944AbUKPJJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 04:09:03 -0500
To: torvalds@osdl.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org> (message from
	Linus Torvalds on Mon, 15 Nov 2004 14:35:12 -0800 (PST))
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
Message-Id: <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Nov 2004 10:08:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I did send a pointer to the cleaned up patch, maybe this wasn't
explicit enough:

  http://fuse.sourceforge.net/kernel_patches/fuse-2.1-2.6.10-rc2.patch

It's 90k uncompressed so I didnt want to include it inline, but I can
send it privately if you want.

> I'd like FUSE a whole lot more if it _only_ did the general page cache 
> reading, but it seems to do a whole lot more, most of it broken.

The cruft is the 2.4 code, and it _is_ removed from the patch.

Most of the 2.6 code is the page cache reading and writing.  It's
complicated because of

  - clustered reads with readpages()

  - async writes

Both are non-essential, but both improve performance.

The need to have a special fuse_file_read()/fuse_file_write() comes
from the fact that some filesystems want a 1 to 1 mapping betwen the
read/write syscalls and the read/write operations.  This is a sort of
"direct IO" operating mode.  Again this feature is non-essential, but
isn't the result of unmaintained code.

Miklos
