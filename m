Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264719AbTFATxm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 15:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264720AbTFATxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 15:53:42 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:8071 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264719AbTFATxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 15:53:41 -0400
Date: Sun, 1 Jun 2003 13:07:04 -0700
From: Andrew Morton <akpm@digeo.com>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
Message-Id: <20030601130704.5f3cc1a8.akpm@digeo.com>
In-Reply-To: <1054488992.1722.42.camel@iso-8590-lx.zeusinc.com>
References: <1054441433.1722.33.camel@iso-8590-lx.zeusinc.com>
	<20030531214520.5b7facf4.akpm@digeo.com>
	<1054488992.1722.42.camel@iso-8590-lx.zeusinc.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jun 2003 20:07:04.0870 (UTC) FILETIME=[5F21A460:01C32879]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sightler <ttsig@tuxyturvy.com> wrote:
>
> On Sun, 2003-06-01 at 00:45, Andrew Morton wrote:
> > Tom Sightler <ttsig@tuxyturvy.com> wrote:
> > >
> > > I simply reniced this process to -10 and
> > >  everything started working fine.  Upon looking a little further it
> > >  seemed that the kernel was dynamically boosting the priority of the
> > >  process much higher than it probably should be, in the end, not leaving
> > >  enough CPU for playing the sounds without skipping.
> > 
> > Yes, it seems that too many real-world applications are accidentally
> > triggering this problem.
> > 
> > Could you please run an strace of the boosted process, find out what it is
> > doing to get itself boosted in this manner?  Wait until things are in
> > steady state and the process is boosted, then run `strace -tt <pid>' so we
> > see the timing info.
> 
> The strace was quite large so I have uploaded it to
> http://tuxyturvy.com/strace-pluginserver.gz
> 

Seems to be doing lots of small reads and writes.  Maybe to a pipe.  What
is the system context switch rate while this is happening?  From `vmstat
1'?

