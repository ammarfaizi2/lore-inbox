Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSILNAF>; Thu, 12 Sep 2002 09:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSILNAF>; Thu, 12 Sep 2002 09:00:05 -0400
Received: from pat.uio.no ([129.240.130.16]:32955 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S315483AbSILNAE>;
	Thu, 12 Sep 2002 09:00:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15744.37092.812502.970281@charged.uio.no>
Date: Thu, 12 Sep 2002 15:04:36 +0200
To: Chuck Lever <cel@citi.umich.edu>
Cc: Daniel Phillips <phillips@arcor.de>, Andrew Morton <akpm@digeo.com>,
       Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <Pine.BSO.4.33.0209091933150.6471-100000@citi.umich.edu>
References: <E17oWsf-0006vQ-00@starship>
	<Pine.BSO.4.33.0209091933150.6471-100000@citi.umich.edu>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Chuck Lever <cel@citi.umich.edu> writes:

     > rpciod must never call a function that sleeps.  if this
     > happens, the whole NFS client stops working until the function
     > wakes up again.  this is not really bogus -- it is similar to
     > restrictions placed on socket callbacks.

I'm in France at the moment, and am therefore not really able to
follow up on this thread for the moment. I'll try to clarify the above
though:

2 reasons why rpciod cannot block:

  1) Doing so will slow down I/O for *all* NFS users.
  2) There's a minefield of possible deadlock situations: waiting on a
     locked page is the main no-no since rpciod itself is the process
     that needs to complete the read I/O and unlock the page.

Cheers,
  Trond
