Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbTBJWmn>; Mon, 10 Feb 2003 17:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbTBJWmn>; Mon, 10 Feb 2003 17:42:43 -0500
Received: from ns.suse.de ([213.95.15.193]:52230 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265506AbTBJWmm>;
	Mon, 10 Feb 2003 17:42:42 -0500
To: "Luck, Tony" <tony.luck@intel.com>
Cc: laforge@gnumonks.org, linux-kernel@vger.kernel.org
Subject: Re: [FWD: NAT counting]
References: <DD755978BA8283409FB0087C39132BD1A07CC8@fmsmsx404.fm.intel.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 10 Feb 2003 23:52:26 +0100
In-Reply-To: "Luck, Tony"'s message of "10 Feb 2003 23:43:23 +0100"
Message-ID: <p73d6lzbvf9.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> writes:

> The fact that someone can deduce how many hosts are hidden behind
> a NAT gateway may, or may not, be a bug ... depending on whether you
> think that the NAT is supposed to keep this number a secret.  But there
> is a real bug here too.  Suppose you have two hosts behind your NAT
> that both have connections to the same host out in internet-land. And
> further suppose that both those hosts have the same value for their
> incrementing counter that they use for IPID.  And finally suppose that
> they both send a fragmented packet to the same port on the same host.

It's fighting an already lost battle. 16bit ipid space is far too small
to do any rewriting tricks. You just don't have enough space to 
space them out enough, especially when there is latency in the network.
> 
> If your NAT router isn't re-writing the IPID, can't the target host get
> confused when it sees two fragments that have a source address from your
> NAT machine, that have the same IPID ... but really don't belong together?

Just do it without NAT on Gigabit with small packets. The ipids wrap
so fast you get data corruption very quickly.  Most of it is catched
by the UDP checksum, but not everything. You can work around it by 
setting the ip defragment timeout very short, but that makes it unusable
for a WAN.

Using IP fragmentation these days is in general a bug.  I regard it at
the same level as using UDP without checksums.  Use path MTU discovery
or a stronger protocol like SCTP.  Alternatively Ipv6 with 32bit
fragment ids, but even that is too small for multi gigabit speeds.

-Andi
