Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTEDVMN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 17:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTEDVMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 17:12:12 -0400
Received: from mark.mielke.cc ([216.209.85.42]:53774 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S261757AbTEDVK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 17:10:56 -0400
Date: Sun, 4 May 2003 17:29:59 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Mikhail Kruk <meshko@cs.brandeis.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fcntl file locking and pthreads
Message-ID: <20030504212959.GB12243@mark.mielke.cc>
References: <Pine.LNX.4.33.0305040206270.20509-100000@iole.cs.brandeis.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0305040206270.20509-100000@iole.cs.brandeis.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 02:13:25AM -0400, Mikhail Kruk wrote:
> on 2.4 kernels fcntl-based file locking does not work with 
> clone-based threads as expected (by me): two threads of the same process 
> can acquire exclusive lock on a file at the same time.
> flock()-based locks work as expected, i.e. only one thread can have an 
> exclusive lock at a time.
> What would it take to make fcntl work as flock?

I don't think per-thread locks is entirely reasonable. The file descriptor
is shared between threads, which means that attributes (including locks)
attached to the file descriptor, are shared between threads.

I would suggest that system resources such as advisory locks be considered
per process, and inter-thread synchronization be performed using thread
synchronization primitives such as the mutex. Feel free to quote from POSIX
to tell me that this suggestion is wrong.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

