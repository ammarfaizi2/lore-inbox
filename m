Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbUJ0Uc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbUJ0Uc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbUJ0Uct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:32:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:36319 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262619AbUJ0U3V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:29:21 -0400
Date: Wed, 27 Oct 2004 13:24:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mathieu Segaud <matt@minas-morgul.org>
Cc: axboe@suse.de, jfannin1@columbus.rr.com, agk@redhat.com,
       christophe@saout.de, linux-kernel@vger.kernel.org, bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
Message-Id: <20041027132422.760d5f5e.akpm@osdl.org>
In-Reply-To: <877jpcgolt.fsf@barad-dur.crans.org>
References: <87oeitdogw.fsf@barad-dur.crans.org>
	<1098731002.14877.3.camel@leto.cs.pocnet.net>
	<20041026123651.GA2987@zion.rivenstone.net>
	<20041026135955.GA9937@agk.surrey.redhat.com>
	<20041026213703.GA6174@rivenstone.net>
	<20041026151559.041088f1.akpm@osdl.org>
	<87hdogvku7.fsf@barad-dur.crans.org>
	<20041026222650.596eddd8.akpm@osdl.org>
	<20041027054741.GB15910@suse.de>
	<20041027064146.GG15910@suse.de>
	<877jpcgolt.fsf@barad-dur.crans.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Segaud <matt@minas-morgul.org> wrote:
>
> Jens Axboe <axboe@suse.de> disait dernièrement que :
> 
> 
> > This feels pretty icky, but should suffice for testing. Does it make a
> > difference?
> >
> > --- /opt/kernel/linux-2.6.10-rc1-mm1/fs/direct-io.c	2004-10-27 08:29:51.866931262 +0200
> > +++ linux-2.6.10-rc1-mm1/fs/direct-io.c	2004-10-27 08:41:20.292172299 +0200
> > @@ -987,8 +987,8 @@
> >  	isize = i_size_read(inode);
> >  	if (bytes_todo > (isize - offset))
> >  		bytes_todo = isize - offset;
> > -	if (!bytes_todo)
> > -		return 0;
> > +	if (bytes_todo < PAGE_SIZE)
> > +		bytes_todo = PAGE_SIZE;
> >  
> >  	for (seg = 0; seg < nr_segs && bytes_todo; seg++) {
> >  		user_addr = (unsigned long)iov[seg].iov_base;
> 
> As 2.6.10-rc1-mm1 failed (as expected), I tried tour fix applied upon
> 2.6.10-rc1-mm1. This did not make any difference.
> The only workaround for now is backing out dio-handle-eof-fix.patch and
> dio-handle-eof.patch

Could someone pleeeeze send out a simple recipe for repeating this problem?
