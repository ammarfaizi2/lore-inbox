Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133040AbRDZBQz>; Wed, 25 Apr 2001 21:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133029AbRDZBQp>; Wed, 25 Apr 2001 21:16:45 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:13799 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S133040AbRDZBQb>; Wed, 25 Apr 2001 21:16:31 -0400
Message-ID: <3AE77578.42A62EA6@uow.edu.au>
Date: Wed, 25 Apr 2001 18:10:16 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tobias Ringstrom <tori@tellus.mine.nu>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Weird problem with 2.4.4-pre6
In-Reply-To: <Pine.LNX.4.30.0104250842420.13663-100000@svea.tellus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Ringstrom wrote:
> 
> Yesterday, I was running tcpdump, paging the output with less.  All of a
> sudden, less started to dump core (SIGSEGV).  I could not even start less
> by itself:
> 
>     > less
> 
> without it getting a SIGSEGV, and in fact no user could run less without
> getting a SIGSEGV, but it did work perfectly a few minutes earlier.  This
> morning, I tried to run less again, and now it was working!  No core
> dumps!
> 
> How can this happen?  Something overwriting the page/buffer cache?

Yes.  Something scribbled on the pagecache, most likely.

If this happens, take a copy of the offending binary and all its shared
libraries - simply copy them into a temp directory.  The corrupted version
will be written to disk, from the pagecache.  Make sure you keep
a copy of the offending vmlinux as well for looking things up in.

Then reboot and start diffing things; the differences can provide
clues.  If the diffs show single-bit errors then it's a RAM
problem.  If the diffs look like pointers into kernel space
then look 'em up in vmlinux and shout loudly.  etc.

-
