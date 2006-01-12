Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932612AbWALSIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbWALSIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 13:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWALSIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 13:08:44 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:18121 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932612AbWALSIn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 13:08:43 -0500
Subject: Re: Back to the Future ? or some thing sinister ?
From: john stultz <johnstul@us.ibm.com>
To: Ram Gupta <ram.gupta5@gmail.com>
Cc: Nathan Lynch <ntl@pobox.com>, Chaitanya Hazarey <cvh.tcs@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <728201270601120633i1c9072fp3329d05b49de790f@mail.gmail.com>
References: <eaef64fc0601081131i17336398l304038c6dea3e057@mail.gmail.com>
	 <20060109040322.GA2683@localhost.localdomain>
	 <1137016986.2890.57.camel@cog.beaverton.ibm.com>
	 <728201270601120633i1c9072fp3329d05b49de790f@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 10:08:17 -0800
Message-Id: <1137089297.2890.118.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 08:33 -0600, Ram Gupta wrote:
> On 1/11/06, john stultz <johnstul@us.ibm.com> wrote:
> > On Sun, 2006-01-08 at 22:03 -0600, Nathan Lynch wrote:
> > > Chaitanya Hazarey wrote:
> > > >
> > > > We have got a machine, lets say X , make is IBM and the CPU is Intel
> > > > Pentium 4 2.60 GHz. Its running a 2.6.13.1 Kernel and previously,
> > > > 2.6.27-4 Kernel the distribution is Debian Sagre.
> 
> It may be BIOS related. But I feel it might be an overflow related
> issue. If the variable is signed int then there will be a transition
> from 0x7fffffff ns  to 0x80000000 ns which is basically from +2 sec to
> -2 sec which will result in 4 sec loss.

I'm pretty sure this is the BIOS issue. If your hesitant about updating
the BIOS, try booting w/ noapic, and see if that works around the issue.

The 4 second loss is the tv_nsec portion of the xtime timespec wrapping.
Since time is not accumulated (timer_interrupt isn't being called at the
normal HZ frequency), the TSC offset grows and grows (and finally will
wrap repeating the processes), causing the xtime.tv_nsec to wrap.

Thus you are correct that the symptom is overflow related, but the cause
is most likely the BIOS.

thanks
-john

