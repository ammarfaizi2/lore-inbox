Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318850AbSHRF0A>; Sun, 18 Aug 2002 01:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318852AbSHRF0A>; Sun, 18 Aug 2002 01:26:00 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:20726 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318850AbSHRFZ7>; Sun, 18 Aug 2002 01:25:59 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sat, 17 Aug 2002 23:28:08 -0600
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818052808.GS9642@clusterfs.com>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20020818021522.GA21643@waste.org> <Pine.LNX.4.44.0208171923330.1310-100000@home.transmeta.com> <20020818025913.GF21643@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020818025913.GF21643@waste.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 17, 2002  21:59 -0500, Oliver Xymoron wrote:
> On Sat, Aug 17, 2002 at 07:30:02PM -0700, Linus Torvalds wrote:
> > Quite frankly, I'd rather have a usable /dev/random than one that runs out
> > so quickly that it's unreasonable to use it for things like generating
> > 4096-bit host keys for sshd etc.
> 
> > In particular, if a machine needs to generate a strong random number, and 
> > /dev/random cannot give that more than once per day because it refuses to 
> > use things like bits from the TSC on network packets, then /dev/random is 
> > no longer practically useful.
> 
> My box has been up for about the time it's taken to write this email
> and it's already got a full entropy pool. A 4096-bit public key has
> significantly less than that many bits of entropy in it (primes thin
> out in approximate proportion to log2(n)). 

It is fairly trivial to change the init scripts to save/restore more than
4096 bits of entropy, and for /dev/random to accumulate more than this.
For people who have _any_ source of "real" entropy, but it is occasionally
in high demand, they could set up a larger pool to accumulate entropy
in between peak demand.  It is basically just a few lines of change in
/etc/init.d/[u]random - all the kernel hooks are there.

Even so, I would agree with Linus in the thought that being "too
paranoid" makes it basically useless.  If you have people sniffing
your network right next to the WAN side of your IPSec firewall with
GHz network analyzers and crafting packets to corrupt your entropy
pool, then chances are they could just as easily sniff the LAN side
of your network and get the unencrypted data directly.  The same
holds true for keystroke logging (or spy camera) to capture your pass
phrase instead of trying an incredibly difficult strategy to "influence"
the generation of this huge key in advance.

In the end, if you make it so hard to extract your secrets in a stealthy
manner, they will just start with a few big guys and a rubber hose...

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

