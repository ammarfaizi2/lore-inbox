Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbTJJSGT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 14:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTJJSGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 14:06:17 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:15040 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S263078AbTJJSGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 14:06:10 -0400
Date: Fri, 10 Oct 2003 11:05:35 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010180535.GE29301@ca-server1.us.oracle.com>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20031010172001.GA29301@ca-server1.us.oracle.com> <Pine.LNX.4.44.0310101024200.20420-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310101024200.20420-100000@home.osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 10:40:40AM -0700, Linus Torvalds wrote:
> Actually, the kernel has a "readahead(fd, offset, size)" system call that
> will start asynchronous read-ahead on any mapping. After that, just
> touching the page will obviously map in and synchronize the result.

	Ok, a quick peruse of sys_readahead() seems to say that it
doesn't check for existing uptodate()ness.  That would be interesting.
I could have missed it, though.  

> I don't think anybody uses it, and the interface may be broken, but it was
> literally 20 lines of code, and I had a trivial test program that
> populated the cache for a directory structure really quickly using it.

	The problem we have with msync() and friends is not 'quick
population', it's "page is in the page cache already; another node
writes to the storage; must mark page as !uptodate so as to force a
re-read from disk".  I can't find where sys_readahead() checks for
uptodate, so perhaps calling sys_readahead() on a range always causes
I/O.  Correct me if I missed it.

> For example, things we can do, but don't, partly because of interface 
> issues and because there is no point in doing it if people wouldn't use 
> it:

	Lots of interesting stuff snipped.  This discussion has me
thinking, knowing now that there's possibility to move to a more optimal
interface.

Joel

-- 

Life's Little Instruction Book #464

	"Don't miss the magic of the moment by focusing on what's
	 to come."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
