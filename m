Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263077AbSJJDcV>; Wed, 9 Oct 2002 23:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263193AbSJJDcU>; Wed, 9 Oct 2002 23:32:20 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:13326
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263077AbSJJDcO>; Wed, 9 Oct 2002 23:32:14 -0400
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
From: Robert Love <rml@tech9.net>
To: andersen@codepoet.org
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Mark Mielke <mark@mark.mielke.cc>,
       Giuliano Pochini <pochini@denise.shiny.it>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021010032950.GA11683@codepoet.org>
References: <1034104637.29468.1483.camel@phantasy>
	<XFMail.20021009103325.pochini@shiny.it>
	<20021009170517.GA5608@mark.mielke.cc> <3DA4852B.7CC89C09@denise.shiny.it>
	<20021009222438.GD5608@mark.mielke.cc>
	<20021009232002.GC2654@bjl1.asuk.net>  <20021010032950.GA11683@codepoet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Oct 2002 23:37:46 -0400
Message-Id: <1034221067.794.505.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-09 at 23:29, Erik Andersen wrote:

> I don't think grep is a very good candidate for O_STREAMING.  I
> usually want the stuff I grep to stay in cache.  O_STREAMING is
> much better suited to applications like ogle, vlc, xine, xmovie,
> xmms etc since there is little reason for the OS to cache things
> like songs and movies you aren't likely to hear/see again any
> time soon.

Yes.  Good point.  People are taking this too far.  There is a big
difference between being just sequential and use-once.  Grep(1) is a
great example of something that _should_ use the pagecache.  Subsequent
file accesses, which will occur, should hit.

Look, the pagecache is already smart.  New stuff will replace unusued
old stuff.  On VM pressure, the pagecache will be pruned.  Streaming I/O
is a fundamentally different problem in that the data is so large it
_continually_ thrashes the pagecache.  Such I/O is sequential and
use-once.  You end up with a permanent waste of memory (the cached
I/O).  

Let's prove we have a solution to this problem before going after
tangent ones.

	Robert Love

