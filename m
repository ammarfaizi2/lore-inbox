Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTEYSi7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 14:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbTEYSi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 14:38:59 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:56550 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262098AbTEYSi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 14:38:58 -0400
From: dan carpenter <d_carpenter@sbcglobal.net>
To: Jens Axboe <axboe@suse.de>, "Paulo Andre'" <fscked@iol.pt>
Subject: Re: [PATCH] Check copy_*_user return value in drivers/block/scsi_ioctl.c
Date: Sun, 25 May 2003 03:29:03 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20030525172549.7df834f9.fscked@iol.pt> <20030525162844.GJ812@suse.de>
In-Reply-To: <20030525162844.GJ812@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305250329.04506.d_carpenter@sbcglobal.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 May 2003 06:28 pm, Jens Axboe wrote:
> On Sun, May 25 2003, Paulo Andre' wrote:
> > Hi Jens,
> >
> > Please find attached a trivial patch that checks both
> > copy_to_user() and copy_from_user() returns values in scsi_ioctl.c,
> > returning accordinly in case of a transfer error.
>
> See above, we've already done access_ok() on the buffer so the
> "unchecked" copy_to/from_user are done that way on purpose. I suppose it
> could be made more explicit with __copy_to/from_user().

access_ok() doesn't seem to mean copy_to_user will return 0.

438 unsigned long copy_to_user(void *to, const void *from, unsigned long n)
439 {
440         prefetch(from);
441         if (access_ok(VERIFY_WRITE, to, n))
442                 n = __copy_to_user(to, from, n);
443         return n;
444 }

I have a script that finds all the unchecked calls to copy_to_user() and
I am curious about what cases it does not need to be checked.

http://kbugs.org/cgi-bin/index.py?page=bug_list&&script=UncheckedReturn&skernel=2.5.69&sfile=&start_bug=0&

Thanks,
dan carpenter


