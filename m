Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262213AbSJJJER>; Thu, 10 Oct 2002 05:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262231AbSJJJER>; Thu, 10 Oct 2002 05:04:17 -0400
Received: from codepoet.org ([166.70.99.138]:54987 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S262213AbSJJJEQ>;
	Thu, 10 Oct 2002 05:04:16 -0400
Date: Thu, 10 Oct 2002 03:10:00 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linux-kernel@vger.kernel.org, Mark Mielke <mark@mark.mielke.cc>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>, Robert Love <rml@tech9.net>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021010091000.GA16695@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org,
	Mark Mielke <mark@mark.mielke.cc>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Robert Love <rml@tech9.net>
References: <20021010032950.GA11683@codepoet.org> <XFMail.20021010103336.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20021010103336.pochini@shiny.it>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Oct 10, 2002 at 10:33:36AM +0200, Giuliano Pochini wrote:
> 
> On 10-Oct-2002 Erik Andersen wrote:
> > I don't think grep is a very good candidate for O_STREAMING.  I
> > usually want the stuff I grep to stay in cache.  O_STREAMING is
> > much better suited to applications like ogle, vlc, xine, xmovie,
> > xmms etc since there is little reason for the OS to cache things
> > like songs and movies you aren't likely to hear/see again any
> > time soon.
> 
> The kernel already have cache pruning algorithm. O_STREAMING logic
> should not clear caches if there is no need to do that. We could

The entire point of O_STREAMING is to let user space specify
policy.  If user space user space knows with 100% certainty that
the data being read/written from a particular file descriptor is
use-once-and-discard data, then it makes sense to honor that
hint.  In this case, user space knows best and can set policy on
a per file descriptor basis.

Note that most applications do not want to use this flag.  But
for a few applications it just just perfect.  For example, if I
am playing a DVD there is absolutely no point in the kernel
trying to cache the content of the DVD.  A DVD has way too much
content for caching it to do any good, and since most people
watch a DVD once through from beginning to end, there is no point
stuffing the DVD's content into the pagecache, thereby crowding
out other things that should remain in cache.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
