Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268006AbTBRU7E>; Tue, 18 Feb 2003 15:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268010AbTBRU7E>; Tue, 18 Feb 2003 15:59:04 -0500
Received: from palrel10.hp.com ([156.153.255.245]:19328 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id <S268006AbTBRU7D>;
	Tue, 18 Feb 2003 15:59:03 -0500
Date: Tue, 18 Feb 2003 13:09:03 -0800
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
Message-ID: <20030218210903.GA9274@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <Pine.LNX.4.33.0301180439480.10820-100000@champ.qualcomm.com> <Pine.LNX.4.33.0301020341140.2038-100000@champ.qualcomm.com> <Pine.LNX.4.33.0301180439480.10820-100000@champ.qualcomm.com> <5.1.0.14.2.20030218101309.048d4288@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030218101309.048d4288@mail1.qualcomm.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 10:50:49AM -0800, Max Krasnyansky wrote:
> At 07:46 PM 2/17/2003, David S. Miller wrote:
> 
> >After talking to Alexey, I don't like this patch.
> >
> >The new module subsystem was supposed to deal with things
> >like this cleanly, and this patch is merely a hack to cover
> >up for it's shortcomings.
> 
> No it's not. Are you guys saying that module refcounting in net/core/dev.c 
> is a hack too ? Patch that I sent implements exactly the same logic.
> Grab module reference before creating net family socket and release
> module when socket is gone. Where is the hack here ?

	Few facts :
	1) You can't get away without refcounting the module users,
	   unless you implement weak pointers in the kernel
	2) You can do refcounting in the module itself (old way, 2.2, 2.4)
	3) You can do refcounting in the module users (new way)
	4) The module code itself can't do the refcounting, unless it puts
	   itself explicitely between the module and its users and
	   understand the usage semantic of the module APIs

> >To be honest, I'd rather just disallow module unloading or
> >let them stay buggy than put this hack into the tree.
> >Special hacks are for 2.4.x where things like full cleanups are not allowed.
>
> It's not a special hack. If it has problems let's fix them.

	Well, there is still some time before 2.6.X, but not that
much. We understand what the issues are, we now some of the solutions,
now we just need a schedule and implement those. I personally don't
care too much of the details as long s there is a solution.
	When are we supposed to get a preview of the "right" way to do
it ?

> I want to keep Bluetooth socket modules loadable and unloadable. And
> I'm sure Jean and other folks want's the same thing for IrDA and
> other subsystems with sockets.

	IrDA sockets will be unloadable, because IrDA wants to be
modular, and people need to unload it to do CIR. So, for me the issue
is more the probability of crashing the system.

> Thanks
> Max

	Have fun...

	Jean
