Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbTEDS22 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 14:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbTEDS22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 14:28:28 -0400
Received: from mail.webmaster.com ([216.152.64.131]:7088 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261399AbTEDS21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 14:28:27 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Mikhail Kruk" <meshko@cs.brandeis.edu>,
       "Jamie Lokier" <jamie@shareable.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: fcntl file locking and pthreads
Date: Sun, 4 May 2003 11:40:50 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEHKCLAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.33.0305040922020.32427-100000@iole.cs.brandeis.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> CLONE_FILES is an argument to clone(), I'm using pthreads and I don't
> know if LinuxThreads implementation of pthreads gives me control of
> how clone is called. Anyway, if I understand what CLONE_FILES does,
> it should be given to clone, because threads do have to be able
> to share file
> descriptors, probably. But not the locks!

	What if I have an application where requests are written to files. Thread A
comes along and notices a job in a file, so it locks the file and reads the
job. The job will require some network I/O, so the thread goes on to do
other things. Later on, thread B notices the network I/O has completed, so
it needs to write to the file, release the lock, and close the file.

	Making locks local to specific threads is contrary to the whole purpose of
threads. Work that needs to be done on a file descriptor is supposed to be
doable by any thread.

	This is something that can be solved with application code. Just keep a
table of all your file locks and consult the table before attempting to
acquire a lock from the system. This is no different than the housekeeping
required around 'malloc' (or more accurately 'sbrk').

	DS


