Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130373AbRAVXBF>; Mon, 22 Jan 2001 18:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130794AbRAVXAp>; Mon, 22 Jan 2001 18:00:45 -0500
Received: from pat.uio.no ([129.240.130.16]:3498 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S130373AbRAVXAg>;
	Mon, 22 Jan 2001 18:00:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14956.48013.908491.509166@charged.uio.no>
Date: Tue, 23 Jan 2001 00:00:29 +0100 (CET)
To: "H . J . Lu" <hjl@valinux.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [NFS] [CFT] Improved RPC congestion handling for 2.4.0 (and 2.2.18)
In-Reply-To: <20010122143740.A31589@valinux.com>
In-Reply-To: <14904.54852.334762.889784@charged.uio.no>
	<20010122143740.A31589@valinux.com>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == H J Lu <hjl@valinux.com> writes:

     > I got a report which indicates it may not be a good idea,
     > especially for UDP. Suppose you have a lousy LAN or NFS UDP
     > server for whatever reason, some NFS/UDP packets may get lost
     > very easily while a ping request may get through. In that case,
     > the rpc ping may slow down the NFS client over UDP
     > significantly.

Hi HJ,

Could you clarify this? Don't forget that we only send the ping after
a major timeout (usually after 3 or more resends).

IOW: If the ping gets through, then it'll have cost us 1 RPC request,
which is hardly a major contribution when talking about timescales of
the order of 5 seconds which is what that major timeout will have cost
(Don't forget that RPC timeout values increase geometrically).

I'm not touting this as a cure for incorrect rsize/wsize settings. I
use it rather to avoid false 'server is not responding' due to server
congestion. On the current RPC code, the latter can occur sometimes
even with a loopback NFS mount when, say, kflushd is busy hogging the
disk...

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
