Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbUDBPGA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 10:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264071AbUDBPGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 10:06:00 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:42126 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S264066AbUDBPF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 10:05:58 -0500
Date: Fri, 2 Apr 2004 17:05:35 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Marco Fais <marco.fais@abbeynet.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Message-ID: <20040402150535.GA13340@localhost>
References: <406D3E8F.20902@abbeynet.it> <20040402131551.GA10920@localhost> <6.0.0.22.2.20040402163334.02abe7d8@pop.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6.0.0.22.2.20040402163334.02abe7d8@pop.localnet>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday April 2nd 2004 Marco Fais wrote:

> Mmmh, all the servers use an RTL-8139 compatible card, with the same 
> 8139too driver. So this can be the problem.

Hey, I'm by no means an expert. Suggesting the driver is to blame was
mostly based on the fact that compiling locally worked, and from a
remote machine triggered a panick. The rest of your description below
indicates that it probably *isnt't* the driver.
 
> But in this moment I'm doing a kernel compile while receiving and sending 
> huge amounts of data using netcat, as you suggested... and works perfectly.
 
> Ok, next I will test the second network card on the server, just to avoid 
> the possibility of an hardware failure -- but I have other 4 servers that 
> show the same behaviour, so I don't think it's caused by faulty hardware.

If 4 other servers show the same behaviour, and netcatting a lot of data
doesn't panick the machine, that highly suggests that the network card
and driver are innocent! I thought only one machine had the problem.
 
> Running this test for about an hour, using all the available bandwidth on 
> the NIC, while compiling the kernel in a loop... no problem. Using distcc, 
> compiling the same files, cause a kernel panic in a few seconds.
> So this test doesn't show the problem, but I think that anyway the network 
> card driver (or the hardware) is involved.

Why do you think so, it seems there's nothing wrong with it; you've just
tested that?

One last suggestion:

Have you tried a local distcc compile, but specifying the host name as
it's IP address or its real name. Distcc treats 'localhost' differently,
but if it sees an IP address it will use the network route. As specified
in the man page this is slower, but if there's something peculiar with
the interaction of distcc with the network layer, then perhaps this
triggers it. You can also use the '--verbose' option on distccd, perhaps
it reports something useful before panicking.
-- 
Marco Roeland
