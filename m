Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbUANDAD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 22:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265965AbUANDAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 22:00:03 -0500
Received: from mail1.cluenet.de ([195.20.121.7]:59010 "EHLO mail1.cluenet.de")
	by vger.kernel.org with ESMTP id S264374AbUANDAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 22:00:01 -0500
Date: Wed, 14 Jan 2004 04:00:00 +0100
From: Daniel Roesen <dr@cluenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
Message-ID: <20040114040000.A27701@homebase.cluenet.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040108214240.GD467@openzaurus.ucw.cz> <Pine.LNX.4.44.0401130012100.12912-100000@poirot.grange> <20040113003908.GB4752@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040113003908.GB4752@elf.ucw.cz>; from pavel@suse.cz on Tue, Jan 13, 2004 at 01:39:08AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 01:39:08AM +0100, Pavel Machek wrote:
> > Hm, as long as we are already on this - can you give me a hint / pointer
> > how does TCP _detect_ a congestion? Does it adjust packet sizes, some
> > other parameters? Just for the curiousity sake.
> 
> If TCP sees packets are lost, it says "oh, congestion", and starts
> sending packets   more   slowly   ie       introduces          delays
> between          packets.     When    they   no longer  get lost, it
> speeds up to full speed.

You missed the important part... TCP measures latency and adjusts to
that. TCP overreacts on sudden unexpected packetloss by shrinking window
down.

This is why traffic "policing" sucks for TCP, and "shaping" (queuing)
works much better (as latency rises when limit is reached, and TCP
sender adapts by sending slower, thus preventing packet loss).


Regards,
Daniel
