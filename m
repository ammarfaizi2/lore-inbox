Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135810AbRDTFtn>; Fri, 20 Apr 2001 01:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135811AbRDTFtZ>; Fri, 20 Apr 2001 01:49:25 -0400
Received: from cs.columbia.edu ([128.59.16.20]:17865 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S135810AbRDTFtE>;
	Fri, 20 Apr 2001 01:49:04 -0400
Date: Thu, 19 Apr 2001 22:48:55 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Roberto Nibali <ratz@tac.ch>
cc: <linux-kernel@vger.kernel.org>, Donald Becker <becker@scyld.com>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <3ADEE2D7.B17C3BF8@tac.ch>
Message-ID: <Pine.LNX.4.33.0104192241060.4771-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2001, Roberto Nibali wrote:

> A 2.2.x UP-APIC patch would maybe improve things here while under
> heavy load. I'm using such boxes as packetfilters. All quadboards
> get IRQ 11 which is rather nasty considering a possible throughput
> of 40Mbit/s per NIC.

The UP-APIC wouldn't help much since there really aren't other processors 
available to share the load.

On the other hand, this is not as bad as it looks. In fact, it will
function rather well and with relatively little overhead if all configured
interfaces are seeing traffic on a regular basis. The IRQ dispatcher will
simply call all registered interrupt routines, and most of them will end
up doing something useful.

> Would be nice if I could fix the "early initialization ..." problem
> too. I'm still checking the Space.c code:
[snip]

Well.. Space.c is a dinozaur. However, this is the 2.2 series and no more 
surgery will happen on this kernel, at least normally.

Have you tried loading the drivers as modules? You might have more luck 
with that approach. Space.c was designed at a time when having 4 NIC's in 
a PC was "pushing the limits"...

> Why isn't it possible to put the "probed" counter into the Space.c for all
> network drivers? So people would not need to care about and the driver
> code would yet be more generic (at least a little bit).

Because, again, this is legacy code. It works, it does the job, that's it. 
All this crap is gone in 2.4.

> Any pointers, sources are welcome and in hope for some further wisdom,

Like I said, try the modules approach. If that doesn't work, I'll take a
closer look (and maybe borrow a few quads from work so I can actually test
the code...)

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

