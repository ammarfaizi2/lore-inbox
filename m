Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292813AbSCPSrq>; Sat, 16 Mar 2002 13:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291787AbSCPSrg>; Sat, 16 Mar 2002 13:47:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61702 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287596AbSCPSrY>; Sat, 16 Mar 2002 13:47:24 -0500
Date: Sat, 16 Mar 2002 10:45:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <yodaiken@fsmlabs.com>
cc: Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <20020316113536.A19495@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0203161037160.31913-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Mar 2002 yodaiken@fsmlabs.com wrote:

> On Sat, Mar 16, 2002 at 10:06:06AM -0800, Linus Torvalds wrote:
> > We'll end up (probably five years from now) re-doing the thing to allow 
> > four levels (so a tired old x86 would fold _two_ levels instead of just 
> > one, but I bet they'll still be the majority), simply because with three 
> > levels you reasonably reach only about 41 bits of VM space.
> 
> Why so few bits per level? Don't you want bigger pages or page clusters?

Simply because I want to be able to share the software page tables with 
the hardware page tables.

Not sharing the page tables implies that you have to have two copies and 
keep them in sync, which is almost certainly going to make fork/exec just 
suck badly.

Now I agree with you that in the long range all the hardware will just use
a 64k pagesize or we'll have extents or whatever.  I'm not saying that
trees are the only good way to populate a VM, it's just the currently
dominant way, and as long as it's the dominant way I want to have the 
common mapping be the 1:1 mapping.

			Linus

