Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932977AbWFZTo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932977AbWFZTo0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932976AbWFZTo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:44:26 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:36813 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932974AbWFZToZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:44:25 -0400
Date: Mon, 26 Jun 2006 15:43:03 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
Message-ID: <20060626194303.GK8985@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <E717642AF17E744CA95C070CA815AE550E163F@cceexc23.americas.cpqcorp.net> <m1veqnrae7.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1veqnrae7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 01:21:04PM -0600, Eric W. Biederman wrote:

[..]
> >> 
> >> Where does the init time penalty come from? How large is the 
> >> init penalty?  I suspect it is from waiting for the scsi 
> >> disks to spin up.
> >> But I am just guessing in the dark.
> >
> > The penalty is in the firmware and self-test operations.
> 
> Ok.  Reasonable. Roughly long does that take? 1 millisecond? 1 second?
> 1 minute? 1 hour? 
> 

IIRC, for MPT fusion, this delay was in order of seconds.


> >> > And I suspect this is a hard reset, also. Not sure if that would 
> >> > negatively impact kdump. If there were some condition we could test 
> >> > against and perform the reset when that condition is met it 
> >> would not 
> >> > impact 99.9% of users.
> >> 
> >> I am wondering if it is possible to look at the controller 
> >> and see if it is in a bad state, (i.e. in some state besides 
> >> just coming out of reset) and if so issue a reset.  If this 
> >> really is a long operation that would be the ideal way to handle it.
> >
> > It's not really in a bad state at this time, is it? Maybe some commands
> > hanging around.
> 
> Not bad as in broken.  But bad as in unexpected.  If it is just a matter
> of outstanding commands we might even be able to just ask the adapter
> to cancel all of the at initialization time.
> 
> >> If the amount of time is really user noticeable and testing 
> >> for it is impossible then it is probably time to talk kernel 
> >> command line options.
> >
> > I was informed of the crashboot command line parameter. I can implement
> > that as a test.
> 
> Sounds like a start.
> 
> >> Although it might simply be appropriate to handle commands 
> >> completing you didn't start.  I am not at all familiar with 
> >> that particular piece of hardware so I can't make a good 
> >> guess on what needs to happen there.
> >
> > Not sure about doing this.
> 
> Well I would certainly print a warning.

cciss already prints a warning message if it receives a command completion
message which driver thinks it has not issued. But what do you do after
that? Simply ignore it and assume that everything is fine or you think that
there is something wrong with the device (During normal boot it should
not happen) and raise a BUG()?

Thanks
Vivek 
