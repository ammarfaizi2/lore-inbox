Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270439AbTHSOMr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270420AbTHSOKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:10:14 -0400
Received: from codepoet.org ([166.70.99.138]:37251 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S270730AbTHSNgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 09:36:20 -0400
Date: Tue, 19 Aug 2003 07:32:11 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Andrew Morton <akpm@osdl.org>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, russo.lutions@verizon.net,
       linux-kernel@vger.kernel.org
Subject: Re: cache limit
Message-ID: <20030819133211.GA27047@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Andrew Morton <akpm@osdl.org>, vda@port.imtp.ilyichevsk.odessa.ua,
	russo.lutions@verizon.net, linux-kernel@vger.kernel.org
References: <3F41AA15.1020802@verizon.net> <200308190533.h7J5XoL06419@Port.imtp.ilyichevsk.odessa.ua> <20030818232024.20c16d1f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818232024.20c16d1f.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 18, 2003 at 11:20:24PM -0700, Andrew Morton wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> >
> > There was a discussion (and patches) in the middle of 2.5 series
> >  about O_STREAMING open flag which mean "do not aggressively cache
> >  this file". Targeted at MP3/video playing, copying large files and such.
> > 
> >  I don't know whether it actually was merged. If it was,
> >  your program can use it.
> 
> It was not.  Instead we have fadvise.  So it would be appropriate to change
> applications such as rsync to optionally run
> 
> 	posix_fadvise(fd, 0, -1, POSIX_FADV_DONTNEED)
> 
> against file descriptors just before closing them, so all the pagecache
> gets thrown away.  (Well, most of the pagecache - dirty pages won't get
> dropped - the app must fsync the files by hand first if it wants this)

This is not supported in 2.4.x though, right?

What if I don't want to fill up the pagecache with garbage in the
first place?  When closing a file descriptor, it is already too
late -- the one time only giant pile of data has already caused
the kernel to wastefully flush useful things out of cache...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
