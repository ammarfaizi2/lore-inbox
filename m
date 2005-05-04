Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVEDDZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVEDDZu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 23:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVEDDZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 23:25:50 -0400
Received: from web60513.mail.yahoo.com ([209.73.178.176]:17766 "HELO
	web60513.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261985AbVEDDZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 23:25:41 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=4vI/FzyOmzAgvbNoF0/JY8+a82NeynF2qjRbqc38pV6ptFPMuPQaDg0bHdvsnoiNOL6Z4UIpXOxOUH6p+hD1XWXAiCmVfx9GfjS6GOLTI68JQw1/uSy5C1MOKQ+6oENFBp7XmWhkBgWJPMkxbxvkrRxVSjgCCSzaK9lUWGC1Tg8=  ;
Message-ID: <20050504032541.58650.qmail@web60513.mail.yahoo.com>
Date: Tue, 3 May 2005 20:25:41 -0700 (PDT)
From: Paul Gortmaker <p_gortmaker@yahoo.com>
Subject: Re: RTC problem on 8208CA
To: Horms <horms@verge.net.au>
Cc: linux-kernel@vger.kernel.org, 277298@bugs.debian.org
In-Reply-To: <20050502051634.GA18295@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At a glance this sounds like the case of having the HPET enabled causes
the RTC IRQ functionality to become crippled or non-functional.  The
concept of hwclock using alarm or similar to handle broken and
misconfigured hardware is a sensible idea.

Paul.

--- Horms <horms@verge.net.au> wrote:

> Hi,
> 
> I am doing some investigations into a problem that has been reported
> with RTC on some Dell Machines.  It seems to be relate exclusively to
> machines that have the 8208CA ICH3 I/O Hub. I have been able to
> reproduce this on a Dell 8400, which I have access to today while I am
> on holidays. The output of lspci -v -x is attached.
> 
> For reference this problem is being tracked at
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=277298
> 
> There are various user-space work arounds for this problem, but I would
> like to offer what I have discovered from a brief poke-around in rtc.c.
> 
> An strace of hwclock looks a bit like this
> 
> open("/dev/rtc", O_RDONLY|O_LARGEFILE);
> ioctl(3, RTC_UIE_ON, 0);
> read(3, ...
> 
> the read never returns.
> 
> If my reading of the code is correct, what is occuring is that
> rtc_read() is in its do/while loop, waiting to be rescheduled. This
> should occur once an interupt is handled by rtc_interrupt(), but I guess
> that this is not occuring. Any insights into why this might be happening
> would be more than welcome.
> 
> The kernel in question is Ubuntu's 2.6.8.1, the rtc.c is identical from
> what was in linus' tree this morning. The config is also attached.
> 
> Please CC me on replies
> 
> Thanks
> 
>

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
