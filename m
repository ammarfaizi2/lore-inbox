Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbTEDTQl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 15:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTEDTQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 15:16:41 -0400
Received: from calliope.cs.brandeis.edu ([129.64.3.189]:17669 "EHLO
	calliope.cs.brandeis.edu") by vger.kernel.org with ESMTP
	id S261588AbTEDTQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 15:16:40 -0400
Date: Sun, 4 May 2003 15:29:04 -0400 (EDT)
From: Mikhail Kruk <meshko@cs.brandeis.edu>
To: David Schwartz <davids@webmaster.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: fcntl file locking and pthreads
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKKEHKCLAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.44.0305041518530.14517-100000@calliope.cs.brandeis.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > CLONE_FILES is an argument to clone(), I'm using pthreads and I don't
> > know if LinuxThreads implementation of pthreads gives me control of
> > how clone is called. Anyway, if I understand what CLONE_FILES does,
> > it should be given to clone, because threads do have to be able
> > to share file
> > descriptors, probably. But not the locks!
> 
> 	What if I have an application where requests are written to files. Thread A
> comes along and notices a job in a file, so it locks the file and reads the
> job. The job will require some network I/O, so the thread goes on to do
> other things. Later on, thread B notices the network I/O has completed, so
> it needs to write to the file, release the lock, and close the file.

I am not persuaded by this example. Why didn't thread A close the file 
when it finished the network I/O? That would be logical time to do it. If 
it wasn't a file descriptor, but a shared memory region, would you argue 
the same about a mutex protecting that memory region?
I think this should not be a question of personal opinions or specific 
examples. It should just be consistent. Two reference platforms for 
threads are Solaris and Windows. I don't know how Solaris handles this, 
but on Windows file locks are per thread, not per process.

[Please cc]

