Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318856AbSHRFtv>; Sun, 18 Aug 2002 01:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318858AbSHRFtv>; Sun, 18 Aug 2002 01:49:51 -0400
Received: from waste.org ([209.173.204.2]:20454 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318856AbSHRFtu>;
	Sun, 18 Aug 2002 01:49:50 -0400
Date: Sun, 18 Aug 2002 00:53:48 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818055348.GN21643@waste.org>
References: <20020818021522.GA21643@waste.org> <Pine.LNX.4.44.0208171923330.1310-100000@home.transmeta.com> <20020818025913.GF21643@waste.org> <20020818052808.GS9642@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020818052808.GS9642@clusterfs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 11:28:08PM -0600, Andreas Dilger wrote:
>
> Even so, I would agree with Linus in the thought that being "too
> paranoid" makes it basically useless.  If you have people sniffing
> your network right next to the WAN side of your IPSec firewall with
> GHz network analyzers and crafting packets to corrupt your entropy
> pool, then chances are they could just as easily sniff the LAN side
> of your network and get the unencrypted data directly.  The same
> holds true for keystroke logging (or spy camera) to capture your pass
> phrase instead of trying an incredibly difficult strategy to "influence"
> the generation of this huge key in advance.

Actually, my attack model here assumes a hostile LAN. GHz WAN is
fairly uncommon.

This design comes from an entropy pool I made from scratch for another
system and fixed what I thought the deficits are in the Linux
model. Current Linux a) overestimates entropy b) can't incorporate
untrusted data c) doesn't sample from the network at all.

I think if I'd broken this up this way:

piece 1a: mix in untrusted data without accounting it
piece 1b: start sampling the network as untrusted data
piece 2a: clean up bogosity in entropy accounting
 
..no one would have objected.

> In the end, if you make it so hard to extract your secrets in a stealthy
> manner, they will just start with a few big guys and a rubber hose...

Oddly enough, I came home today from running errands to discover that
someone had tried brute-forcing my front door with a crowbar.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
