Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261263AbSJGQdC>; Mon, 7 Oct 2002 12:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261277AbSJGQdB>; Mon, 7 Oct 2002 12:33:01 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:34179
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S261263AbSJGQdB>; Mon, 7 Oct 2002 12:33:01 -0400
Date: Mon, 7 Oct 2002 12:38:23 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: "David S. Miller" <davem@redhat.com>
cc: Russell King <rmk@arm.linux.org.uk>, <simon@baydel.com>,
       <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: The end of embedded Linux?
In-Reply-To: <20021007.090233.107701780.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0210071227550.913-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, David S. Miller wrote:

>    From: Nicolas Pitre <nico@cam.org>
>    Date: Mon, 7 Oct 2002 12:05:16 -0400 (EDT)
> 
>    2) Not inlining inb() and friend reduce the bloat but then you further 
>       impact performances on CPUs which are generally many order of magnitude 
>       slower than current desktop machines.
>    
> I don't buy this one.  You are saying that the overhead of a procedure
> call is larger than the overhead of going out over the I/O bus to
> touch a device?

Of course it is!  Not only the procedure call prevents code optimisations
like immediate constants for opcode arguments and pushes more registers to
the stack, but you're then wasting many CPU cycles that would have been much
useful to fetch data from the peripheral's fifo.

Remember we are talking about "embedded" platforms which the majority are
using small CPUs where the IO bus is often on a clock which is tightly 
coupled to the CPU core clock.  Extra CPU cycles wasted on function call 
prologs is often enough to affect throughput significantly.


Nicolas

