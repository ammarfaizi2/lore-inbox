Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAKAG2>; Wed, 10 Jan 2001 19:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRAKAGT>; Wed, 10 Jan 2001 19:06:19 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:37552 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129511AbRAKAGL>; Wed, 10 Jan 2001 19:06:11 -0500
Date: Wed, 10 Jan 2001 15:46:57 -0800
From: Dan Kegel <dank@alumni.caltech.edu>
Subject: Re: Poll and Select not scaling
To: angelcode@myrealbox.com, linux-kernel@vger.kernel.org
Reply-to: dank@alumni.caltech.edu
Message-id: <3A5CF471.17C03480@alumni.caltech.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micah wrote:
> I have been trying to increase the scalabilty of
> an email server that has been ported to Linux. It
> was originally written for Netware, and there we
> are able to provide over 30,000 connections at any
> given time. On Linux however select stops working
> after the first 1024 connections. I have changed
> include/linux/fs.h and updated NR_FILE to be 81920. 

On modern kernels, you no longer need to change NR_FILE;
all you need to do is increase ulimit -n and a few proc 
entries; see 
http://www.kegel.com/c10k.html#limits.filehandles

> In test applications I have been able to create well
> over 30,000 connections but I am unable to do either
> a select or a poll on them. 

select() is usually limited to 1024 file descriptors, so
poll() is a slightly better choice.  However, although
it can handle 30000 file descriptors, the performance sucks;
see http://www.kegel.com/dkftpbench/Poller_bench.html#results

You may wish to use an alternative to poll().
See http://www.kegel.com/c10k.html#strategies for a list of possibilities.

The only one that performs well on Linux at 30000 fds would be
the real time signal stuff.  That's a little tricky to use.
Or you could recode your app to use one thread or process
per 1000 fd's.
Solaris and FreeBSD both offer friendlier poll alternatives
that perform quite well.  You might consider using one of those
operating systems if all else fails.

- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
