Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129824AbRBUWBQ>; Wed, 21 Feb 2001 17:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129785AbRBUWBG>; Wed, 21 Feb 2001 17:01:06 -0500
Received: from curtis.curtisfong.org ([206.111.86.96]:2309 "EHLO
	curtis.curtisfong.org") by vger.kernel.org with ESMTP
	id <S130047AbRBUWAr>; Wed, 21 Feb 2001 17:00:47 -0500
Date: Wed, 21 Feb 2001 14:00:55 -0800
From: Nye Liu <nyet@curtis.curtisfong.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very high bandwith packet based interface and performance problems
Message-ID: <20010221140055.A8113@curtis.curtisfong.org>
In-Reply-To: <20010220181955.A1994@hobag.internal.zumanetworks.com> <E14VXub-0001vv-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.11i
In-Reply-To: <E14VXub-0001vv-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 21, 2001 at 11:58:23AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2001 at 11:58:23AM +0000, Alan Cox wrote:
> Dropping packets under load will make tcp do the right thing. You don't need
> complex mathematical models since dropping frames under load is just another
> form of congestion and tcp handles it pretty sanely

Alan: thanks for your response...

This is exactly what I would expect to see, but we are seeing something
else..

Under HEAVY load we are seeing approximately 20Mbit of TCP throughput. If
we "shape" (i use the term loosely, we dont actually have a real shaper,
just loading the cpu who is trasmitting) the presented load, we can
get 60-70Mbit. I'm not quite sure why this is.  My first guess was
that because the kernel was getting 99% of the cpu, the application was
getting very little, and thus the read wasn't happening fast enough, and
the socket was blocking. In this case, you would expect the system to get
to a nice equilibrium, where if the app stopped reading, the kernel would
stop acking, and the transmitter would back off, eventually to a point
where the app could start reading again because the kernel load dropped.

This is NOT what I'm seeing at all.. the kernel load appears to be
pegged at 100% (or very close to it), the user space app is getting
enough cpu time to read out about 10-20Mbit, and FURTHERMORE the kernel
appears to be ACKING ALL the traffic, which I don't understand at all
(e.g. the transmitter is simply blasting 300MBit of tcp unrestricted)

With udp, we can get the full 300MBit throughput, but only if we shape
the load to 300Mbit. If we increase the load past 300 MBit, the received
frames (at the user space udp app) drops to 10-20MBit, again due to
user-space application scheduling problems.

-nye
