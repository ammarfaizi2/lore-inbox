Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273888AbRIRTu5>; Tue, 18 Sep 2001 15:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273885AbRIRTur>; Tue, 18 Sep 2001 15:50:47 -0400
Received: from mail4.svr.pol.co.uk ([195.92.193.211]:57696 "EHLO
	mail4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S273883AbRIRTuc>; Tue, 18 Sep 2001 15:50:32 -0400
Date: Tue, 18 Sep 2001 20:39:46 +0100
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] multipath RAID personality, 2.4.10-pre9
Message-ID: <20010918203946.A12814@wyvern>
Reply-To: adrian.bridgett@iname.com
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010916150806.E1541@turbolinux.com> <Pine.LNX.4.33.0109170113010.3960-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109170113010.3960-100000@localhost.localdomain>
User-Agent: Mutt/1.3.20i
From: Adrian Bridgett <adrian.bridgett@iname.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 01:16:56 +0200 (+0000), Ingo Molnar wrote:
[snip]
> > [...] Also, it is my understanding that with some multipath hardware,
> > if you read from the "backup" path it will kill access to the primary
> > path (this can be used when more than one system access shared disk
> > for failover).  As a result, we should always read from the "primary"
> > path for each disk unless there is an error.
> 
> yes, and this is being done currently, only the primary path is used.

Do you have plans to change this?  I know that the SDD software for AIX load
balances between paths (and I think EMC's Powerpaths do for AIX too), DMP
(from Veritas) for Solaris doesn't.

In fact that brings up another point - which path do you use by default?  If
you have the SAN situation where you have a farm of servers each with two FC
cards two two FC switches and then to two ports on a storage array, you
don't want everything going to the first switch.  Just picking one path to
use at random would be preferable (unless you want to swap every other
servers cables around).

One thing I know SDD does is that it doesn't use a path which has started
working again until it's been working for a little while.  I had a quick
newbie grok through the code and couldn't see anything like that.  Just an
idea.

Just doing a quick read I came across this comment:

+ * TODO: now if there are 2 multipaths in the same 2 devices, performance
+ * degrades dramatically because position is multipath, not device based.
+ * This should be changed to be device based. Also atomic sequential
+ * reads should be somehow balanced.

shouldn't that read "more than one multipath to the same device"?

I presume it's not limited to 2 multipaths?

Thanks

Adrian

Email: adrian.bridgett@iname.com
Windows NT - Unix in beta-testing. GPG/PGP keys available on public key servers
Debian GNU/Linux  -*-  By professionals for professionals  -*-  www.debian.org
