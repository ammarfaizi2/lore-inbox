Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbUCKWUd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 17:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbUCKWUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 17:20:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:49086 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261773AbUCKWU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 17:20:27 -0500
Date: Thu, 11 Mar 2004 14:22:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-Id: <20040311142229.1918500f.akpm@osdl.org>
In-Reply-To: <20040311134017.GA2813@ncsu.edu>
References: <20040310233140.3ce99610.akpm@osdl.org>
	<20040311134017.GA2813@ncsu.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@unity.ncsu.edu wrote:
>
> On Wed, Mar 10, 2004 at 11:31:40PM -0800, Andrew Morton wrote:
> >   This affects I/O scheduling potentially quite significantly.  It is no
> >   longer the case that the kernel will submit pages for I/O in the order in
> >   which the application dirtied them.  We instead submit them in file-offset
> >   order all the time.
> 
> Hi Andrew,
>     I have a feeling this change might significantly improve the external
> sorting benchmark I emailed you ( http://lkml.org/lkml/2003/12/20/46 ).
> I will try running it when I get a chance and let you know.

That thing's still sitting in by Inbox awaiting attention :(

I just took a quick peek.  The `testfile' file which it lays out is well
laid-out so yes, if you're seeking all over that file then 2.6.4-mm1 may
indeed help throughput.

But `tesfile.tmp' is not well laid-out.  Looks like it was created seekily,
so its blocks are all jumbled up.

The code in 2.6.4-mm1 favours unjumbled-up files.  The code in 2.4 and
2.6.4 favours jumbled-up files.

When kjournald performs writeback it favours jumbled-up files, even in
2.6.4-mm1.

So it's hard to say what will happen ;)  I'll take a look later.

> It gives me a good excuse to get 2.6 kernels working on my systems :-)

Luddite.
