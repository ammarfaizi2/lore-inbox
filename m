Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264253AbTKKEYZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 23:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTKKEYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 23:24:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:2224 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264253AbTKKEYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 23:24:22 -0500
Date: Mon, 10 Nov 2003 20:28:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Venezia <pvenezia@jpj.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I/O issues, iowait problems, 2.4 v 2.6
Message-Id: <20031110202819.7e7433a8.akpm@osdl.org>
In-Reply-To: <1068523328.25805.97.camel@soul.jpj.net>
References: <1068519213.22809.81.camel@soul.jpj.net>
	<20031110195433.4331b75e.akpm@osdl.org>
	<1068523328.25805.97.camel@soul.jpj.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Venezia <pvenezia@jpj.net> wrote:
>
>  > As next steps I'd suggest that you log into the server and do
>  > 
>  > 	time (dd if=/dev/zero of=x bs=1M count=2048 ; sync)
>  > 
>  > and
>  > 
>  > 	time (dd if=x of=/dev/null bs=1M count=2048 ; sync)
>  > 
>  > (this assumes that the machine has less that 2G of memory, to avoid caching
>  > effects).
> 
>  The raw file read/write is the ticket. The box tightens right up at 100% iowait.

Well that's nice and simple.  Could you please run `vmstat 1' during that
big `dd'?  Wait for everything to achieve steady state, send us twenty
lines of the vmstat trace?

> 
>  I'd done bonnie++ i/o tests already, and except for an apparent NPTL issue on the per char,
>  the block i/o numbers were fine; no abnormal results whatsoever. In fact, block r/w
>  numbers were improved compared to 2.4.22. Now that I'm looking for it, however, I 
>  do note extremely elevated iowait numbers during a bonnie++ run. Something in the MPT
>  modules?

Greater than 90% I/O wait is to be expected in these tests.  What is of
interest is the overall bandwidth.  2.5 megabytes per second is very
broken.  I have a 53c1030 box here which uses the MPT fusion driver and it
happily does 50MB/sec to a single disk, but I guess that's a different
setup.

