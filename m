Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbTHSVSC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTHSVPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:15:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:47521 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261388AbTHSVLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:11:39 -0400
Date: Tue, 19 Aug 2003 13:56:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: andersen@codepoet.org
Cc: vda@port.imtp.ilyichevsk.odessa.ua, russo.lutions@verizon.net,
       linux-kernel@vger.kernel.org
Subject: Re: cache limit
Message-Id: <20030819135639.5df1c1c6.akpm@osdl.org>
In-Reply-To: <20030819133211.GA27047@codepoet.org>
References: <3F41AA15.1020802@verizon.net>
	<200308190533.h7J5XoL06419@Port.imtp.ilyichevsk.odessa.ua>
	<20030818232024.20c16d1f.akpm@osdl.org>
	<20030819133211.GA27047@codepoet.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen <andersen@codepoet.org> wrote:
>
> On Mon Aug 18, 2003 at 11:20:24PM -0700, Andrew Morton wrote:
> > Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> > >
> > > There was a discussion (and patches) in the middle of 2.5 series
> > >  about O_STREAMING open flag which mean "do not aggressively cache
> > >  this file". Targeted at MP3/video playing, copying large files and such.
> > > 
> > >  I don't know whether it actually was merged. If it was,
> > >  your program can use it.
> > 
> > It was not.  Instead we have fadvise.  So it would be appropriate to change
> > applications such as rsync to optionally run
> > 
> > 	posix_fadvise(fd, 0, -1, POSIX_FADV_DONTNEED)
> > 
> > against file descriptors just before closing them, so all the pagecache
> > gets thrown away.  (Well, most of the pagecache - dirty pages won't get
> > dropped - the app must fsync the files by hand first if it wants this)
> 
> This is not supported in 2.4.x though, right?

No, it is not.

> What if I don't want to fill up the pagecache with garbage in the
> first place?

Call fadvise(POSIX_FADV_DONTNEED) more frequently or use O_DIRECT.

