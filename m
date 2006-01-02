Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWABK5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWABK5a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 05:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWABK5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 05:57:30 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:18635 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932270AbWABK5a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 05:57:30 -0500
Date: Mon, 2 Jan 2006 12:01:45 +0100
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client on	interactive response
Message-ID: <20060102110145.GA25624@aitel.hist.no>
References: <43A8EF87.1080108@bigpond.net.au> <1135145341.7910.17.camel@lade.trondhjem.org> <43A8F714.4020406@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A8F714.4020406@bigpond.net.au>
User-Agent: Mutt/1.5.11
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 05:32:52PM +1100, Peter Williams wrote:
> Trond Myklebust wrote:
[...]
> >
> >Sorry. That theory is just plain wrong. ALL of those case _ARE_
> >interactive sleeps.
> 
> It's not a theory.  It's a result of observing a -j 16 build with the 
> sources on an NFS mounted file system with top with and without the 
> patches and comparing that with the same builds with the sources on a 
> local file system.  Without the patches the tasks in the kernel build 
> all get the same dynamic priority as the X server and other interactive 
> programs when the sources are on an NFS mounted file system.  With the 
> patches they generally have dynamic priorities between 6 to 10 higher 
> than the X server and other interactive programs.
> 
A process waiting for NFS data looses cpu time, which is spent on running 
something else.  Therefore, it gains some priority so it won't be
forever behind when it wakes up.  Same as for any other io waiting.

Perhaps expecting a 16-way parallel make to have "no impact" is
a bit optimistic.  How about nicing the make, explicitly telling
linux that it isn't important?  Or how about giving important
tasks extra priority?

Helge Hafting
