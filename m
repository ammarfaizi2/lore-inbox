Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbWGJNIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbWGJNIA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbWGJNIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:08:00 -0400
Received: from mail.gmx.de ([213.165.64.21]:50308 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161090AbWGJNH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:07:59 -0400
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 10 Jul 2006 15:07:54 +0200
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
In-Reply-To: <20060710125150.GM25911@suse.de>
Message-ID: <20060710130754.26280@gmx.net>
MIME-Version: 1.0
References: <20060710121110.26260@gmx.net> <20060710125150.GM25911@suse.de>
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

> > What are the semantics of splice() supposed to be with respect 
> > to the current file offsets of 'fd_in' and 'fd_out', and how
> > is the presence or absence (NULL) of 'off_in' and 'off_out'
> > supposed to affect things.
> > 
> > Using the program below, here is what I observe for 
> > fd_out/off_out:
> > 
> > 1. If off_out is NULL, then 
> >    a) splice() changes the current file offset of fd_out.
> > 
> > 2. If off_out is not NULL, then splice() 
> >    a) does not change the current file offset of fd_out, but 
> >    b) treats off_out as a value result parameter, returning 
> >       an updated offset of the file.
> > 
> > It is "2 a)" that surprises me.  But perhaps it's expected 
> > behaviour; or I'm doing something dumb in my test program.
> 
> Not sure why you find that surprising, that is exactly what is supposed
> to happen :-)
>
> If you don't give off_out, we use the current position. For most people,
> that's probably what they want. If you are sharing the fd, that doesn't
> work though. So you pass off_in/off_out as you please, and the kernel
> uses those and passes the updated parameter back out so you don't have
> to update it manually.

I'm still not clear here.  Let me phrase my question another way:
why is it that the presence or absence of off_out affects whether
or not splice() changes the current file offset for fd_out?

> It's identical to how sendfile() works.

But it isn't: sendfile() never changes the file offset 
of its 'in_fd'.

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
