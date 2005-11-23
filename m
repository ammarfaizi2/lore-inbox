Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbVKWBEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbVKWBEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 20:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030296AbVKWBEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 20:04:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54487 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030294AbVKWBEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 20:04:46 -0500
Date: Tue, 22 Nov 2005 17:05:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jeffrey.hundstad@mnsu.edu, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc2
Message-Id: <20051122170507.37ebbc0c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511221642310.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
	<43829ED2.3050003@mnsu.edu>
	<20051122150002.26adf913.akpm@osdl.org>
	<Pine.LNX.4.64.0511221642310.13959@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Tue, 22 Nov 2005, Andrew Morton wrote:
> 
> > Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu> wrote:
> > >
> > >                 from fs/compat_ioctl.c:52,
> > >                  from arch/x86_64/ia32/ia32_ioctl.c:14:
> > > include/linux/ext3_fs.h: In function 'ext3_raw_inode':
> > > include/linux/ext3_fs.h:696: error: dereferencing pointer to incomplete type
> > 
> > This might help?

The patch didn't help.

> 
> Why does it happen at all, though?

davem recently merged a patch which adds ext3 ioctls to fs/compat_ioctl.c. 
That required inclusion of ext3 and jbd header files.  Those files explode
unpleasantly when CONFIG_JBD=n.

No trivial fix was apparent - perhaps we should disable the compat wrappers
if CONFIG_EXT3=n and/or CONFIG_JBD=n.

> And why aren't more people reporting 
> this? Something strange going on.

Most people use ext3.
