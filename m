Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbVHIPzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbVHIPzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 11:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbVHIPzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 11:55:12 -0400
Received: from van-1-67.lab.dnainternet.fi ([62.78.96.67]:26840 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S964834AbVHIPzL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 11:55:11 -0400
Date: Tue, 9 Aug 2005 18:55:04 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Soft lockup in e100 driver ?
Message-ID: <20050809155504.GP22165@mea-ext.zmailer.org>
References: <20050809133647.GK22165@mea-ext.zmailer.org> <9a87484905080906556d9f531c@mail.gmail.com> <20050809143705.GM22165@mea-ext.zmailer.org> <1123602100.18332.174.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123602100.18332.174.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 11:41:40AM -0400, Steven Rostedt wrote:
> On Tue, 2005-08-09 at 17:37 +0300, Matti Aarnio wrote:
> > On Tue, Aug 09, 2005 at 03:55:49PM +0200, Jesper Juhl wrote:
> > > On 8/9/05, Matti Aarnio <matti.aarnio@zmailer.org> wrote:
> > > > Running very recent Fedora Core Development kernel I can following
> > > > soft-oops..   ( 2.6.12-1.1455_FC5smp )
> > > > 
> > > Various patches to the e100 driver have been merged since 2.6.12.1
> > > (which is ~1.5months old), so it would make sense to try a more recent
> > > kernel like 2.6.13-rc6, 2.6.13-rc6-git1 or 2.6.13-rc5-mm1 and see if
> > > you can still reproduce the problem with those.
> > 
> > The kernel in question is less than 3 days old RedHat Fedora Core
> > Development kernel with baseline as:
> >   * Sun Aug 07 2005 Dave Jones <davej@redhat.com>
> >     - 2.6.13-rc5-git4
> > 
> > Those merges have not helped.
> 
> Matti,
> 
> I believe Fedora must have added Ingo's soft lockup detect code.  I've
> made additions to this code as well. Could you point me to a link that I
> could download this kernel source.  No rpm's or packagemanagers please.
> Just a tarball would be fine.

The fundamental thing is, IT LOCKS UP (for a while), when I do 
"ifconfig eth0 down" and there is active traffic but the card DIES
somehow.  Apparently it requires marginal/unreliable hardware to
happen as well.  (Which for e100 is rather rare.)

That is: at first the card dies, then I notice it, and do the ifconfig.
Then things go _bad_, and recover.  Then I do 'rmmod e100', and
restart network (which reloads the driver module), and things work
once again.

Fedora kernel sources have this "softlockups" patch file: (size and date)
   6159 May 12 04:50 linux-2.6.12-detect-softlockups.patch

That file I can upload, if you want.  Or send in email.
Rest of the RPM-wrapper CPIO package I would prefer not to...


> Thanks,
> -- Steve

/Matti Aarnio
