Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131823AbRAITaq>; Tue, 9 Jan 2001 14:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131822AbRAITad>; Tue, 9 Jan 2001 14:30:33 -0500
Received: from cr949225-b.rchrd1.on.wave.home.com ([24.112.58.97]:24326 "HELO
	enfusion-group.com") by vger.kernel.org with SMTP
	id <S131777AbRAITaR>; Tue, 9 Jan 2001 14:30:17 -0500
Date: Tue, 9 Jan 2001 14:30:16 -0500
From: Adrian Chung <adrian@enfusion-group.com>
To: Felix Maibaum <f.maibaum@tu-bs.de>
Cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 bug in SHM an via-rhine or is it my fault?
Message-ID: <20010109143016.A15225@rogue.enfusion-group.com>
In-Reply-To: <3A5B170E.F48872A@tu-bs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5B170E.F48872A@tu-bs.de>; from f.maibaum@tu-bs.de on Tue, Jan 09, 2001 at 02:50:06PM +0100
Organization: enfusion-group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 02:50:06PM +0100, Felix Maibaum wrote:
> I'm using a via-rhine chip (DFE-530TX) on a 10 Mbit network, I use 2.4.0
> final, Athlon (classic) 1Gig, Abit-KA7 mobo (via KX133), Debian woody.
> whenever I try to get a file on my local network, meaning I get close to
> the 10Mbit barrier the network card hangs up. Traffic just stops.
> One ifdown/ifup and everything works fine again. (for about 10 seconds)
> this problem has persisted for some time now, I thought it would be
> fixed in the final, but, alas, it hasn't. It only happens during high
> traffic, too, at about 400k, no problem!

I just put a DFE-530TX in an AMD Duron/256MB system yesterday, which
had been working fine with a DE-530 (de4x5.o) on a 10/100 MB switched
network.  I booted up the system with the new card, and noticed
similar weirdness:

NFS from the client system (Duron - 2.4.0-ac4), hangs almost
immediately when trying to contact a 2.2.18 NFS server.  I get "nfs
can't get task slot" errors, and "NFS server xxx.xxx.xxx.xxx not
responding", especially after doing a "dd if=/dev/zero
of=/home/user/nfstest bs=16k count=4096".  After checking, the file
/home/user/nfstest is 8192 bytes big.  The client mount is a default
NFS mount, with no rsize/wsize parameters.

I then replaced the DE-530 and tried the exact same scenario as above,
and it works fine.

The other strangeness is that while the client complains about the NFS
server having disappeared, I can ping it from the same client,
transfer files using scp, and still get to the internet fine.  So the
card is still working, but never receives a response to any NFS
traffic until a reboot.  Other machines on the network can NFS mount
from the server without problems as well.

Anyone have any ideas?

--
Adrian Chung
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
