Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWAOSK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWAOSK6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 13:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWAOSK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 13:10:58 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:36769 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1750783AbWAOSK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 13:10:58 -0500
Date: Sun, 15 Jan 2006 10:21:55 -0800
From: thockin@hockin.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: Zan Lynx <zlynx@acm.org>, David Lang <dlang@digitalinsight.com>,
       Andreas Steinmetz <ast@domdv.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual core Athlons and unsynced TSCs
Message-ID: <20060115182155.GA31941@hockin.org>
References: <Pine.LNX.4.62.0601131315310.9821@qynat.qvtvafvgr.pbz> <20060113215609.GA30634@hockin.org> <Pine.LNX.4.62.0601131404311.9821@qynat.qvtvafvgr.pbz> <1137190698.2536.65.camel@localhost.localdomain> <Pine.LNX.4.62.0601131448150.9821@qynat.qvtvafvgr.pbz> <43C848C7.1070701@domdv.de> <Pine.LNX.4.62.0601131701590.9821@qynat.qvtvafvgr.pbz> <1137315165.28041.12.camel@localhost> <20060115162516.GA21791@hockin.org> <1137342817.25801.17.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137342817.25801.17.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 11:33:36AM -0500, Lee Revell wrote:
> On Sun, 2006-01-15 at 08:25 -0800, thockin@hockin.org wrote:
> > On Sun, Jan 15, 2006 at 01:52:44AM -0700, Zan Lynx wrote:
> > > A laptop user could also bind a process to a single CPU, and use the
> > > scaling min/max values to lock CPU speed to a single value.  The TSC may
> > > still stop during HLT, but software must be handling that already.
> > > 
> > > Wouldn't that provide an accurate TSC?
> > 
> > monotonic but not linear.  Also remember that the OS will use rdtsc here
> > and there, and you can't affine the OS :)
> > 
> 
> So the options are either to fix the TSC handling on these systems (by
> resyncing the TSCs when exiting from HLT), or eliminate the use of rdtsc
> by the OS?

Or both.  You can trap rdtsc users in userland, you have to manually audit
kernel users.

It should be abolished or properly wrapped in kernel code, as soon as a
resync path is available.
