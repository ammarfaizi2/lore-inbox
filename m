Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751871AbWCNGuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbWCNGuy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 01:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWCNGuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 01:50:54 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6892 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751871AbWCNGux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 01:50:53 -0500
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
From: Lee Revell <rlrevell@joe-job.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <1142318403.4583.14.camel@homer>
References: <200603102054.20077.kernel@kolivas.org>
	 <200603111650.23727.kernel@kolivas.org> <1142056851.7819.54.camel@homer>
	 <200603111824.06274.kernel@kolivas.org>  <1142063500.7605.13.camel@homer>
	 <1142139283.25358.68.camel@mindpipe>  <1142318403.4583.14.camel@homer>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 01:50:46 -0500
Message-Id: <1142319048.13256.103.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 07:40 +0100, Mike Galbraith wrote:
> On Sat, 2006-03-11 at 23:54 -0500, Lee Revell wrote:
> > On Sat, 2006-03-11 at 08:51 +0100, Mike Galbraith wrote:
> > > There used to be a pages in flight 'restrictor plate' in there that
> > > would have probably helped this situation at least a little.  But in
> > > any case, it sounds like you'll have to find a way to submit the IO in
> > > itty bitty synchronous pieces. 
> > 
> > echo 64 > /sys/block/hd*/queue/max_sectors_kb
> > 
> > There is basically a straight linear relation between whatever you set
> > this to and the maximum scheduling latency you see.  It was developed to
> > solve the exact problem you are describing.
> 
> <head-scratching>
> 
> Is it possible that you mean pci latency?  I'm unable to measure any
> scheduling latency > 5ms while pushing IO for all my little Barracuda
> disk is worth.

It's only a big problem if LBA48 is in use which allows 32MB of IO to be
in flight at once, this depends on the size of the drive.

What does that value default to?

>   I _can_ generate mp3 player audio dropout though,
> despite mp3 files living on a separate drive/controller.
> 

Does this go away if you run the mp3 player at nice -20?

> 	-Mike
> 
> 

