Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262371AbSJPN7N>; Wed, 16 Oct 2002 09:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbSJPN7N>; Wed, 16 Oct 2002 09:59:13 -0400
Received: from mx01-a.netapp.com ([198.95.226.53]:14808 "EHLO
	mx01-a.netapp.com") by vger.kernel.org with ESMTP
	id <S262371AbSJPN7M>; Wed, 16 Oct 2002 09:59:12 -0400
Message-ID: <6440EA1A6AA1D5118C6900902745938E07D54F85@black.eng.netapp.com>
From: "Lever, Charles" <Charles.Lever@netapp.com>
To: neilb@cse.unsw.edu.au
Cc: taka@valinux.co.jp, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, "'David S. Miller'" <davem@redhat.com>
Subject: RE: [NFS] Re: [PATCH] zerocopy NFS for 2.5.36
Date: Wed, 16 Oct 2002 07:04:44 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: David S. Miller [mailto:davem@redhat.com]
> Sent: Wednesday, October 16, 2002 12:31 AM
>
>    From: Neil Brown <neilb@cse.unsw.edu.au>
>    Date: Wed, 16 Oct 2002 13:44:04 +1000
> 
>    Presumably on a sufficiently large SMP machine that this became an
>    issue, there would be multiple NICs.  Maybe it would make sense to
>    have one udp socket for each NIC.  Would that make sense? or work?
>    It feels to me to be cleaner than one for each CPU.
>    
> Doesn't make much sense.
> 
> Usually we are talking via one IP address, and thus over
> one device.  It could be using multiple NICs via BONDING,
> but that would be transparent to anything at the socket
> level.
> 
> Really, I think there is real value to making the socket
> per-cpu even on a 2 or 4 way system.

having a local socket per CPU is very good for SMP scaling.
it multiplies input buffer space, and reduces socket lock
and CPU cache contention.

sorry, i don't have measurements.
