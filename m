Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVFUS4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVFUS4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 14:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVFUS4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 14:56:41 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:32307 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261311AbVFUS4i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 14:56:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cHJbXZlprwUXfN3C4D9edQiqMNa/kvKwxpsM8cybxUWFK9kQPC8TRYk/jYUhrrNjmQQIkKTtCW+w7+NtmMXkkx8i0jX2Fn6mYkH7XmtJRiiGs67tPhCAiJGa0ZCCywGziz80jHb1NH/WlbxMaGyby2ECPbHkGIA2mIfHtsPC18g=
Message-ID: <29495f1d050621115636bc6f77@mail.gmail.com>
Date: Tue, 21 Jun 2005 11:56:30 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: -mm -> 2.6.13 merge status
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1119369028.19357.28.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
	 <1119369028.19357.28.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2005-06-20 at 23:54 -0700, Andrew Morton wrote:
> > CONFIG_HZ for x86 and ia64: changes default HZ to 250, make HZ
> > Kconfigurable.
> >
> >     Will merge (will switch default to 1000 Hz later if that seems
> > necessary)
> 
> Are you serious?  You're changing the *default* HZ in a stable kernel
> series?!?
> 
> This is a big regression, it degrades the resolution of system calls.

Not that my opinion should sway anybody else, but I really would
prefer more of the in-kernel sleep callers were converted to use
human-time units (and thus were verified to be correct) so that
switching HZ will result in the *same* latencies. How much of moving
to lower HZ values is due to the fact that everything is request 10ms
for 1 jiffy of sleep instead of 1 ms? It's hard to tell if the gain is
there or from the lower frequency of interrupts.

I've sent out a lot of patches in this direction (using msleep() and
msleep_interruptible() and my soft-timer rework on top of John
Stultz's timeofday rework converts the entire soft-timer subsystem to
use human-time instead of jiffies as it's unit of expiration), but
there is still *a lot* of work left to do :( I will keep sending
patches, but am being pulled in other directions currently.

Just my $.02.

Thanks,
Nish
