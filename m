Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265057AbSKETCn>; Tue, 5 Nov 2002 14:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265083AbSKETCn>; Tue, 5 Nov 2002 14:02:43 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:62984 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S265057AbSKETCm>;
	Tue, 5 Nov 2002 14:02:42 -0500
Date: Tue, 5 Nov 2002 20:08:54 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Jim Paris <jim@jtan.com>, Willy Tarreau <willy@w.ods.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
Message-ID: <20021105190854.GA25877@alpha.home.local>
References: <20021105124234.A5837@neurosis.mit.edu> <Pine.LNX.3.95.1021105134951.410A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1021105134951.410A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 01:57:16PM -0500, Richard B. Johnson wrote:

> No! You will break many machines. You cannot use out_p() when
> writing the latch it __must__ be out(). the "_p" puts a write
> to another port between the two writes. That will screw up
> the internal state-machine of most PITs including AMD-SC520.
 
You make an interesting point. Have you checked if an inb_p() on this hardware
could unlock the latch when reading the first byte ? It may also be one cause
of time jumps if the counter is just about to wrap when it's being read, and
gets unlocked by an out to port 0x80 (the "_p").

>  		count = inb_p(0x40);    /* read the latched count */
>  		count |= inb(0x40) << 8;

Or perhaps it will be time to change port 0x80 to something else, that no
chipset will use. I've seen 0xED in a bios somewhere, but I don't remember
where.

Cheers,
Willy

