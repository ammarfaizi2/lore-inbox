Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVECSLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVECSLs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 14:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVECSLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 14:11:48 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:42882 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261495AbVECSHZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 14:07:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PGbDGZN1FT9OzhlMFaRgzkJiOQpVRY/Rnkhd63DMLJeV+v56yxJ84vKdKXyXzfj7vmu56cRbQsMGo4fhmiChXuL0slyh2BpcaV0pFrqNiHq2VOS3xmEqtqEYKTmqQKHlu2vo3iWrazQC5tyVzc81woJsKQIHRzxl4A8DPeH8MMo=
Message-ID: <29495f1d050503110753b644b2@mail.gmail.com>
Date: Tue, 3 May 2005 11:07:25 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: [RFC][PATCH] new timeofday-based soft-timer subsystem
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, albert@users.sourceforge.net,
       paulus@samba.org, schwidefsky@de.ibm.com, mahuja@us.ibm.com,
       donf@us.ibm.com, mpm@selenic.com, benh@kernel.crashing.org
In-Reply-To: <4277B34C.4000403@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1114814747.28231.2.camel@cog.beaverton.ibm.com>
	 <20050429233546.GB2664@us.ibm.com> <20050503170224.GA2776@us.ibm.com>
	 <4277B34C.4000403@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/05, Chris Friesen <cfriesen@nortel.com> wrote:
> Nishanth Aravamudan wrote:
> 
> > but then there is another issue: the restart_block used by
> > sys_nanosleep() only allows for 4 unsigned long arguments, when, in
> > fact, nanoseconds are a 64-bit quantity in the kernel. As long as the
> > nanosleep() request is no more than around 4 seconds, we should be ok
> > using unsigned longs.
> 
> My man page for nanosleep specifies that the "nanoseconds" portion of
> the timespec must be under 1 billion and is of type "long".  Is that no
> longer valid?

Certainly would be, but the problem is if you pass in a timespec ts, where

    ts.tv_sec = 10;
    ts.tv_nsec = 99999;

This will overflow a 32-bit nanosecond representation internally
(10000099999 > 4294967296). Sorry for the confusion, the unsigned long
I was referring to was the internal representation of the nanoseconds
converted from the timespec parameter.

Thanks,
Nish
