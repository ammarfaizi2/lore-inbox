Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbUBUB0i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 20:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbUBUB0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 20:26:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:38073 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261469AbUBUB0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 20:26:35 -0500
Date: Fri, 20 Feb 2004 17:28:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chad Walstrom <chewie@wookimus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: NAT over 3c59x cards freezes interactivity on 2.6.2
Message-Id: <20040220172827.09fd7f9a.akpm@osdl.org>
In-Reply-To: <20040220224134.GA24203@wookimus.net>
References: <20040212171647.GW6864@wookimus.net>
	<20040212184208.48a93b39.akpm@osdl.org>
	<20040220224134.GA24203@wookimus.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chad Walstrom <chewie@wookimus.net> wrote:
>
> On Thu, Feb 12, 2004 at 06:42:08PM -0800, Andrew Morton wrote:
> > Chad Walstrom <chewie@wookimus.net> wrote:
> > >
> > > [2.] DETAILS: Upon upgrading from 2.4.x to 2.6.2, I've noticed that my
> > >  workstation/NAT box freezes on interactive processes while transfering
> > >  large files over NAT to other machines on the network. 
> > 
> > Please monitor the system time with top or `vmstat 1'.  Is it excessive?
> 
> I'm not sure what excessive might mean.  There doesn't seem to be any
> spikes in memory consumption.  Following is the output from 'vmstat 1'.
> The number of procs waiting for run time increases when the
> interactivity freezes (while the laptop is downloading files over the
> workstation's NAT).  The '6' and '5' both occur during download attempts
> and interactivy freezes.  When I kill the download, interactivy resumes,
> and the waiting processes drops.
> 
> Script started on Fri Feb 20 16:17:30 2004
> [16:17:30] chewie@skuld (501)$ vmstat 1
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  2  0   9364   2560  46256 300188    0    0    10    12   35    44 96  1  3  0
>  1  0   9364   2560  46256 300188    0    0     0     0 1008    63 100  0  0  0
>  1  0   9364   2560  46264 300188    0    0     0    12 1008    56 100  0  0  0

It claims that the CPU is pegged in userspace.  What does `top' say?

> > A kernel profile might tell us what is going on.  See
> > Documentation/basic_profiling.txt.
> 
> I'll have to recompile the kernel to test this for you.  I'll do so and
> compile 2.6.3.

Well if you're spending 100% of CPU in userspace then a kernel profile
won't tell us much.

> > If you remove all the netfilter rules, what happens?
> 
> Then I wouldn't be able to NAT. ;-)  The workstation works fine as a
> standalone.  I've downloaded large files w/o too much difficulty, and
> interactivity remains stable.  The only time I see problems is when I'm
> downloading files through NAT to the laptop.

So it is the presence of the NAT rules which is causing the problem?

Perhaps the above vmstat trace is wrong?  Make sure that you have a nice and
recent procps package.

