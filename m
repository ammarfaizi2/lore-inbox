Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267516AbUJNV1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUJNV1h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267556AbUJNUyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:54:21 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:54277 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S266912AbUJNUbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 16:31:09 -0400
Date: Thu, 14 Oct 2004 13:30:51 -0700
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Message-ID: <20041014203051.GB17855@nietzsche.lynx.com>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <1097779972.30253.947.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097779972.30253.947.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 11:52:52AM -0700, Daniel Walker wrote:
> When I was reviewing this it seemed like it would be possible to keep
> RCU anonymous by moving the callback processing out of the tasklet . The
> reason it was moved into a tasklet was to reduce latency. But if you
> serialize it like you have, aren't you removing all the benefits of the
> RCU type lock in those section that are converted to the new API ?
 
What Ingo is doing now is mostly like a temporary fix for dealing with
this issue. Simple backing with a normal mutex should be sufficient for
protecting that access. RCU is still an open problem.

> Why not have a per cpu mutex instead of a per variable per cpu mutex?
> I'm not sure what the trade off are, except size.

It's a read-mostly read/write lock. N number of real processors can
do N number of read locks. That structure needs to be emulated somehow
and a per CPU mutex is probably the correct method of getting it.
It's just a matter of how. I did suggest something in my project
announcement.

I don't know if it's crack smoking or not. :)

bill

