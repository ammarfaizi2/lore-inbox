Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318746AbSICKGL>; Tue, 3 Sep 2002 06:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318741AbSICKGL>; Tue, 3 Sep 2002 06:06:11 -0400
Received: from ns.suse.de ([213.95.15.193]:64517 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318739AbSICKGK>;
	Tue, 3 Sep 2002 06:06:10 -0400
Date: Tue, 3 Sep 2002 12:10:41 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, kuznet@ms2.inr.ac.ru, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       haveblue@us.ibm.com, Manand@us.ibm.com, christopher.leech@intel.com
Subject: Re: TCP Segmentation Offloading (TSO)
Message-ID: <20020903121041.A20066@wotan.suse.de>
References: <20020903.164243.21934772.taka@valinux.co.jp.suse.lists.linux.kernel> <20020903.005119.50342945.davem@redhat.com.suse.lists.linux.kernel> <p73y9ajqw85.fsf@oldwotan.suse.de> <20020903.030025.07037175.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020903.030025.07037175.davem@redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 03:00:25AM -0700, David S. Miller wrote:
>    From: Andi Kleen <ak@suse.de>
>    Date: 03 Sep 2002 11:05:30 +0200
> 
>    x86-64 handles it (also in csum-copy). I think at least Alpha does it 
>    too (that is where I stole the C csum-partial base from) But it's ugly.
>    See the odd hack. 
> 
> Ok I think we really need to fix this then in the arches
> where broken.  Let's do an audit. :-)

Yes, it's needed because users can pass unaligned addresses in from
userspace to sendmsg

> 
> I question if x86 is broken at all.  It checks odd lengths
> and x86 handles odd memory accesses transparently.  Please,
> some x86 guru make some comments here :-)

x86 is just slower for this case because all accesses will eat the 
unaligned penalty, but should work.

I could have done it this way on x86-64 too, but chose to handle it.

> It looks like sparc64 is the only platform where oddly aligned buffer
> can truly cause problems and I can fix that easily enough.

It could allow everybody to generate packets with bogus addresses on 
the network.

I suspect on sparc64 it will just be all handled by the unalignment handler
in the kernel ? If yes it will be incredibly slow, but should work.

-Andi
