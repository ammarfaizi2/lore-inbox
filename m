Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277176AbRKGJZu>; Wed, 7 Nov 2001 04:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277722AbRKGJZl>; Wed, 7 Nov 2001 04:25:41 -0500
Received: from [212.18.232.186] ([212.18.232.186]:19462 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S277176AbRKGJZc>; Wed, 7 Nov 2001 04:25:32 -0500
Date: Wed, 7 Nov 2001 09:24:15 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Kurt Roeckx <Q@ping.be>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Riley Williams <rhw@MemAlpha.cx>, Pavel Machek <pavel@suse.cz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <20011107092415.A24654@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.21.0111062347080.16087-100000@Consulate.UFP.CX> <812671195.1005093860@[195.224.237.69]> <20011107020137.A1887@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011107020137.A1887@ping.be>; from Q@ping.be on Wed, Nov 07, 2001 at 02:01:37AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 02:01:37AM +0100, Kurt Roeckx wrote:
> On Wed, Nov 07, 2001 at 12:44:21AM -0000, Alex Bligh - linux-kernel wrote:
> > --On Wednesday, 07 November, 2001 12:00 AM +0000 Riley Williams 
> > <rhw@MemAlpha.cx> wrote:
> > 
> > >  2. The kernel makes no internal reference to the /dev/rtc driver,
> > >     and it is left to userland tools to sync to the RTC on boot,
> > >     and at other times as required.
> > 
> > I think the kernel should set the machine time to the RTC time
> > as an initializer on boot. Other than that, I agree.
> 
> Which is something you do from userspace.

One problem with that approach is the things in kernel that need to be
initialised to a random value, such that on two consecutive boots, the
values are different.  Currently, that's NFS XIDs.  As Linux currently
stands, running on some embedded machines where there is no real time
clock, you can hit the possibility of file corruption if you happen to
reboot the machine twice in within two minutes - non-Linux NFS servers
could well be longer.

With your proposed change, you'd be inflicting that pain on all NFS root
machines, even ones with RTCs, so may I suggest that if you're thinking
about removing the RTC stuff that you also think of a way of solving this
problem at the same time?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

