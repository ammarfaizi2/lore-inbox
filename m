Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262911AbTCKQRR>; Tue, 11 Mar 2003 11:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262912AbTCKQRR>; Tue, 11 Mar 2003 11:17:17 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:3032 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262911AbTCKQRQ>; Tue, 11 Mar 2003 11:17:16 -0500
Date: Tue, 11 Mar 2003 17:27:34 +0100
From: Andi Kleen <ak@muc.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dcache hash distrubition patches
Message-ID: <20030311162734.GA5640@averell>
References: <10280000.1047318333@[10.10.2.4]> <20030310175221.GA20060@averell> <26350000.1047368465@[10.10.2.4]> <20030311152322.GA2358@averell> <31840000.1047396682@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31840000.1047396682@[10.10.2.4]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 04:31:23PM +0100, Martin J. Bligh wrote:
> I can try 1Mb or something I suppose ... what's the purpose here,
> to keep the cachelines of the bucket heads warm? Not sure it's worth
> the tradeoff, as we have to touch another line for each element we
> walk?

Use less cache for the hash table overall.

Use less lowmem.

Ideally there would be no tradeoff if you can still get reasonable 
hash chain length with smaller tables (= overall win)

> 
> I take it you're happy enough with the current hash function distribution?

At least I don't know how to improve it.



> > Also same for inode hash (but I don't have statistics for that right now)
> 
> I could hack something up ... but 1 machine ain't going to cut it. I
> suspect I'd have a much smaller inode hash, as I tend to have masses
> of kernel trees, mostly hardlinked to each other.

I doubt inode cache is very critical, except perhaps in NFS server loads
(but even the nfs server has an own frontend cache)
Normally the dcache should bear most of the load.

-Andi
