Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWCLF0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWCLF0l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 00:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWCLF0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 00:26:41 -0500
Received: from mail.gmx.de ([213.165.64.20]:62647 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751407AbWCLF0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 00:26:40 -0500
X-Authenticated: #14349625
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
From: Mike Galbraith <efault@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <1142139283.25358.68.camel@mindpipe>
References: <200603102054.20077.kernel@kolivas.org>
	 <200603111650.23727.kernel@kolivas.org> <1142056851.7819.54.camel@homer>
	 <200603111824.06274.kernel@kolivas.org>  <1142063500.7605.13.camel@homer>
	 <1142139283.25358.68.camel@mindpipe>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 06:27:36 +0100
Message-Id: <1142141256.8021.18.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-11 at 23:54 -0500, Lee Revell wrote:
> On Sat, 2006-03-11 at 08:51 +0100, Mike Galbraith wrote:
> > There used to be a pages in flight 'restrictor plate' in there that
> > would have probably helped this situation at least a little.  But in
> > any case, it sounds like you'll have to find a way to submit the IO in
> > itty bitty synchronous pieces. 
> 
> echo 64 > /sys/block/hd*/queue/max_sectors_kb
> 
> There is basically a straight linear relation between whatever you set
> this to and the maximum scheduling latency you see.  It was developed to
> solve the exact problem you are describing.

Ah, a very useful bit of information, thanks.

It won't help Con though, because he'll be dealing with every possible
configuration.  I think he's going to have to either submit, wait,
bandwidth limiting sleep, repeat or something clever that does that.
Even with bandwidth restriction though, seek still bites mightily, so I
suspect he's stuck with little trickles of IO started when we'd
otherwise be idle.  We'll see I suppose.

	-Mike

