Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTJXNwt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 09:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTJXNws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 09:52:48 -0400
Received: from odalix.ida.liu.se ([130.236.186.10]:54174 "EHLO
	odalix.ida.liu.se") by vger.kernel.org with ESMTP id S262196AbTJXNwr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 09:52:47 -0400
From: Magnus Andersson <magan029@und.ida.liu.se>
Date: Fri, 24 Oct 2003 15:52:41 +0200
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
Message-ID: <20031024155241.A19052@student.liu.se>
References: <20031020003745.GA2794@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031020003745.GA2794@rushmore>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19, 2003 at 08:37:45PM -0400, rwhron@earthlink.net wrote:
> There was about a 50% regression in jobs/minute in AIM7
> database workload on quad P3 Xeon.  The CPU time has not
> gone up, so the extra run time is coming from something
> else.  (I/O or I/O scheduler?)

Hello all!

This sounds like the same problem I had with the 2.6 kernel.
I posted some stuff on the kernel-list about this.

Make a search for "2.6.0-test4 parallel seek & read problem"
on google to read my posts.

I think I ran into two different unrelated problems.
 
First problem was solved, but second problem is still there.
It is probably the same you are having.

My finding was that the problem is not the scheduler, but some
other part of the IO system.

1 seek & read issued by a program goes to the disk as 2 different
seeks & 2 reads, thus only giving 50 % performance.

I think the problem is that the elevators are flushed so often
so merges that should happend never happens.

/Magnus
