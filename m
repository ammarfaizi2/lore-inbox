Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTJJUYe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 16:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTJJUYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 16:24:34 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:24073 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262108AbTJJUYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 16:24:33 -0400
Date: Fri, 10 Oct 2003 22:33:45 +0200
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Joel.Becker@oracle.com
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010203345.GA1177@hh.idb.hist.no>
References: <20031010172001.GA29301@ca-server1.us.oracle.com> <Pine.LNX.4.44.0310101024200.20420-100000@home.osdl.org> <20031010180535.GE29301@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010180535.GE29301@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 11:05:35AM -0700, Joel Becker wrote:

> 	The problem we have with msync() and friends is not 'quick
> population', it's "page is in the page cache already; another node
> writes to the storage; must mark page as !uptodate so as to force a
> re-read from disk".  I can't find where sys_readahead() checks for
> uptodate, so perhaps calling sys_readahead() on a range always causes
> I/O.  Correct me if I missed it.
>
 
Wouldn't this be solvable by giving userspace a way of invalidating
a range of mmapped pages?  I.e. a "minvalidate();" to use when
the other node tells you it is about to write?

This will cause the pages to be paged in again on next reference,
or you can issue a read in advance if you believe you'll need them.

Helge Hafting
