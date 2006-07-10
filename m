Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbWGJNy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWGJNy3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWGJNy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:54:29 -0400
Received: from mail.gmx.net ([213.165.64.21]:34492 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965027AbWGJNy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:54:29 -0400
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 10 Jul 2006 15:54:27 +0200
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
In-Reply-To: <20060710132529.GD5210@suse.de>
Message-ID: <20060710135427.26270@gmx.net>
MIME-Version: 1.0
References: <20060710121110.26260@gmx.net> <20060710125150.GM25911@suse.de>
 <20060710130754.26280@gmx.net> <20060710132529.GD5210@suse.de>
Subject: Re: splice() and file offsets
To: Jens Axboe <axboe@suse.de>
X-Authenticated: #24879014
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

> > I'm still not clear here.  Let me phrase my question another way:
> > why is it that the presence or absence of off_out affects whether
> > or not splice() changes the current file offset for fd_out?
> 
> The logic is simple - either you don't give an explicit offset, and the
> current position is used and updated. Or you give an offset, and the
> current position is ignored (not read, not updated).

Yes, I understand what the code is doing, but *why* do 
things this way?  (To put things another way: why not *always 
have splice() update the file offset?)  I realise there may be
some good reason for this, and if there is, it will go into the
man page!

> > > It's identical to how sendfile() works.
> > 
> > But it isn't: sendfile() never changes the file offset 
> > of its 'in_fd'.
> 
> Ehm, yes it does. Would you expect the app to do an appropriate lseek()
> on every sendfile() call?

No!  It does not!  See the sendfile.2 man page: "sendfile() 
does not modify the current file offset of in_fd."  
(You had me worried -- I just now went and *tested* 
the operation of sendfile().)  The app does not need to 
do an lseek() call because the 'offset' argument is *always* 
updated with the new "virtual" offset.  This is part of why I 
am disturbed/confused: sendfile() always updates its 'offset' 
argument and *never* changes the file offset; splice() only 
does that if its 'offset' argument is non-NULL.

Cheers,

Michael
-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
