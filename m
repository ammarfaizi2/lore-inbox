Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271621AbRHPTLf>; Thu, 16 Aug 2001 15:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271620AbRHPTLZ>; Thu, 16 Aug 2001 15:11:25 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:3573 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S271621AbRHPTLO>; Thu, 16 Aug 2001 15:11:14 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 16 Aug 2001 13:11:12 -0600
To: Steve Hill <steve@navaho.co.uk>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: /dev/random in 2.4.6
Message-ID: <20010816131112.V31114@turbolinux.com>
In-Reply-To: <200108151713.f7FHDg0n013420@webber.adilger.int> <Pine.LNX.4.21.0108160934340.2107-100000@sorbus.navaho>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0108160934340.2107-100000@sorbus.navaho>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2001 at 09:37:58AM +0100, Steve Hill wrote:
> On Wed, 15 Aug 2001, Andreas Dilger wrote:
> > Yes, it is possible to increase the size of the in-kernel entropy pool
> > by changing the value in linux/drivers/char/random.c.  You will likely
> > also need to fix up the user-space scripts that save and restore the
> > entropy on shutdown/startup (check /proc/sys/kernel/random/poolsize,
> > if available, to see how many bytes to read/write).
> 
> It didn't help - there just isn't enough entropy data being generated
> between boot time and when I extract the random numbers.  This is
> basically a system to install a linux distribution, so it's booted off the
> network with a readonly root NFS, so there is no saved entropy data to
> load, so I'm starting off with an empty entropy pool and having to rely on
> the kernel to generate the data from scratch.  The random numbers are used
> to initialise the ssh and VPN keys.

Hmm, since it IS critical that the ssh and VPN keys of a new system be
very good, you could do something like run "bonnie++" on one of the new
partitions, until you get enough entropy from block I/O completions.

Alternately, you could generate "weak" keys on the client using urandom
just to get ssh working, and then send keys generated on the server (which
presumably has more real entropy) to replace the weak keys.

That said, there are still cases where network traffic _has_ to be enough
for /dev/random, given that some firewalls (e.g. LRP) can run from only
ramdisk, so have no other source of entropy than the network traffic.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

