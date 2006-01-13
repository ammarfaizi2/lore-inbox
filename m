Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422740AbWAMRrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422740AbWAMRrr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422741AbWAMRrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:47:47 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:36039 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422740AbWAMRrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:47:47 -0500
Subject: RE: Dual core Athlons and unsynced TSCs
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Roger Heflin <rheflin@atipa.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <1137168254.7241.32.camel@localhost.localdomain>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com>
	 <1137168254.7241.32.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 12:47:42 -0500
Message-Id: <1137174463.15108.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 11:04 -0500, Steven Rostedt wrote:
> On Fri, 2006-01-13 at 09:10 -0600, Roger Heflin wrote:
> >  
> > > -----Original Message-----
> > > From: linux-kernel-owner@vger.kernel.org 
> > > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Lee Revell
> > > Sent: Thursday, January 12, 2006 4:18 PM
> > > To: linux-kernel
> > > Subject: Dual core Athlons and unsynced TSCs
> > > 
> > > It's been known for quite some time that the TSCs are not 
> > > synced between cores on Athlon X2 machines and this screws up 
> > > the kernel's timekeeping, as it still uses the TSC as the 
> > > default time source on these machines.
> > > 
> > > This problem still seems to be present in the latest kernels. 
> > >  What is the plan to fix it?  Is the fix simply to make the 
> > > kernel use the ACPI PM timer by default on Athlon X2?
> > 
> > 
> > Do we know if this also affects dual-core opterons?
> > 
> > The symptoms are that the clocks run at 2x the speed, correct?
> 
> No, worse.  The monotonic clock can go backwards.  The tscs of the CPUs
> are not in sync when one slows down due to idle.  So if you read from
> two different CPUs, you may get the second read have an earlier time
> than the first.  Breaks the rule of what a monotonic clock is.
> 

Steve,

I don't have hardware to test this, can you confirm that the only
workaround needed is to boot with "clock=pmtmr"?

Lee


