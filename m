Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264784AbTFBBrx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 21:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264785AbTFBBrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 21:47:53 -0400
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:37554 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264784AbTFBBrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 21:47:52 -0400
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030601130704.5f3cc1a8.akpm@digeo.com>
References: <1054441433.1722.33.camel@iso-8590-lx.zeusinc.com>
	 <20030531214520.5b7facf4.akpm@digeo.com>
	 <1054488992.1722.42.camel@iso-8590-lx.zeusinc.com>
	 <20030601130704.5f3cc1a8.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054519196.1722.70.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2003 21:59:57 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4, required 10, AWL,
	EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, SPAM_PHRASE_02_03)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-01 at 16:07, Andrew Morton wrote:
> Tom Sightler <ttsig@tuxyturvy.com> wrote:
> >
> > On Sun, 2003-06-01 at 00:45, Andrew Morton wrote:
> > > Tom Sightler <ttsig@tuxyturvy.com> wrote:
> > > >
> > > > I simply reniced this process to -10 and
> > > >  everything started working fine.  Upon looking a little further it
> > > >  seemed that the kernel was dynamically boosting the priority of the
> > > >  process much higher than it probably should be, in the end, not leaving
> > > >  enough CPU for playing the sounds without skipping.
> > > 
> > > Yes, it seems that too many real-world applications are accidentally
> > > triggering this problem.
> > > 
> > > Could you please run an strace of the boosted process, find out what it is
> > > doing to get itself boosted in this manner?  Wait until things are in
> > > steady state and the process is boosted, then run `strace -tt <pid>' so we
> > > see the timing info.
> > 
> > The strace was quite large so I have uploaded it to
> > http://tuxyturvy.com/strace-pluginserver.gz
> > 
> 
> Seems to be doing lots of small reads and writes.  Maybe to a pipe.  What
> is the system context switch rate while this is happening?  From `vmstat
> 1'?
> 

I just did a 10 second run, average was about 2000/sec, with a minimum
of around 1500/sec and a peak of 3700/sec.

With the rest of the system the same (same programs running, etc) but on
a page that doesn't use that particular plugin, the context switch rate
sits around 250/sec.

Would you like the actual full output from vmstat?

Later,
Tom


