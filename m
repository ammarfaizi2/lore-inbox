Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbTEDVwT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 17:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTEDVwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 17:52:19 -0400
Received: from iole.cs.brandeis.edu ([129.64.3.240]:2958 "EHLO
	iole.cs.brandeis.edu") by vger.kernel.org with ESMTP
	id S261210AbTEDVwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 17:52:17 -0400
Date: Sun, 4 May 2003 18:04:48 -0400 (EDT)
From: Mikhail Kruk <meshko@cs.brandeis.edu>
To: Ville Voutilainen <vjv@ee.oulu.fi>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: fcntl file locking and pthreads
In-Reply-To: <200305042156.h44LuJYe012089@stekt2.oulu.fi>
Message-ID: <Pine.LNX.4.33.0305041759370.1595-100000@iole.cs.brandeis.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> open()
> pthread_create()
> fcntl()
> 			(other thread)
> 			fcntl()
> will probably result in both threads acquiring the lock
> successfully. It would be reasonable IMHO to assume that
> a sequence like
> 
> open()
> pthread_create()
> fcntl()
> 
> 			(other thread)
> 			open()
> 			fnctl() /* lock the newly opened fd */

actually what I have is:
thread 0:
pthread_create() (1)
pthread_create() (2)

thread 1:
open()
fcntl()

thread 2:
open()
fcntl()

etc

and they all succeed. Even though the file descriptors are different. 

> would give you what you're after. The only problem being that
> even user space manuals suggest that fcntl can only detect
> that other *processes* hold a file lock. Given the muddy

Unfortunately man pages I have don't even mention thread vs process.

> nature of what is a thread/process in Linux, this requires
> someone more familiar with the clone stuff to clarify.
> 
> Another issue altogether is why you are trying to sync two
> threads with file locks, but I digress.

You digress, but I feel like I have to justify myself now :)
Those threads used to be processes and now want be threads with minimal 
modifications. The files that are locked are still used by other processes 
too.

