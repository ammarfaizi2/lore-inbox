Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135675AbRAVXj2>; Mon, 22 Jan 2001 18:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135605AbRAVXjS>; Mon, 22 Jan 2001 18:39:18 -0500
Received: from zeus.kernel.org ([209.10.41.242]:17126 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135827AbRAVXhj>;
	Mon, 22 Jan 2001 18:37:39 -0500
Date: Mon, 22 Jan 2001 15:36:38 -0800
From: "H . J . Lu" <hjl@valinux.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        NFS maillist <nfs@lists.sourceforge.net>,
        Michael Kriss <kriss@fnal.gov>
Subject: Re: [NFS] [CFT] Improved RPC congestion handling for 2.4.0 (and 2.2.18)
Message-ID: <20010122153638.B32449@valinux.com>
In-Reply-To: <14904.54852.334762.889784@charged.uio.no> <20010122143740.A31589@valinux.com> <14956.48013.908491.509166@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14956.48013.908491.509166@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, Jan 23, 2001 at 12:00:29AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 23, 2001 at 12:00:29AM +0100, Trond Myklebust wrote:
> >>>>> " " == H J Lu <hjl@valinux.com> writes:
> 
>      > I got a report which indicates it may not be a good idea,
>      > especially for UDP. Suppose you have a lousy LAN or NFS UDP
>      > server for whatever reason, some NFS/UDP packets may get lost
>      > very easily while a ping request may get through. In that case,
>      > the rpc ping may slow down the NFS client over UDP
>      > significantly.
> 
> Hi HJ,
> 
> Could you clarify this? Don't forget that we only send the ping after
> a major timeout (usually after 3 or more resends).
> 
> IOW: If the ping gets through, then it'll have cost us 1 RPC request,
> which is hardly a major contribution when talking about timescales of
> the order of 5 seconds which is what that major timeout will have cost
> (Don't forget that RPC timeout values increase geometrically).
> 

Michael Kriss <kriss@fnal.gov> is having this problem. I think this
problem may be very specific to his network setup. I couldn't duplicate
his problem. My guess is for his case, every ping sent is a loss of
a potential working retry packet. He is using Solaris NFS sever with
Linux client. I had an impression that packets from Solaris NFS server
was dropped quite often. I don't know what happened.

-- 
H.J. Lu (hjl@valinux.com)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
