Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWBMXYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWBMXYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWBMXYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:24:23 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:1416 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030277AbWBMXYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:24:23 -0500
Date: Tue, 14 Feb 2006 00:22:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] hrtimer: remove data field
Message-ID: <20060213232237.GA25449@elte.hu>
References: <Pine.LNX.4.61.0602130211060.23839@scrub.home> <20060213135456.GC12923@elte.hu> <Pine.LNX.4.61.0602132213270.30994@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602132213270.30994@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> On Mon, 13 Feb 2006, Ingo Molnar wrote:
> 
> > > The nanosleep cleanup allows to remove the data field of hrtimer. The 
> > > callback function can use container_of() to get it's own data. Since 
> > > the hrtimer structure is usually embedded in other structures, the 
> > > code also becomes a bit simpler.
> > 
> > i addressed this when you first raised this issue (back in the ktimers 
> > flamewars), and generally the feeling of people i asked was that doing 
> > the container_of() approach is less readable than an explicit 'data' 
> > field. It also deviates from struct timer_list, which we wanted to stay 
> > close to. Furthermore, for standalone hrtimers this creates the need to 
> > generate a wrapper structure. So i dont really like this change - but no 
> > strong feelings either way.
> 
> With the complete size reduction struct hrtimer becomes 32 bytes on 32 
> bits archs and so we can fit the basic hrtimer into one or two cache 
> lines. container_of() is becoming more and more common in the kernel, 
> so I don't know who asked, it's not that difficult to use. I agree it 
> makes simple test modules a bit more difficult, but so far the more 
> common case is that this structure is embedded in other structures and 
> container_of() creates simpler code. Additionally you get type 
> checking for free, which you don't get with a void pointer.

yeah, i agreed with you back then too. (in fact i raised doing the same 
for timer_list, which is embedded in other structs quite frequently too, 
but this thought didnt acquire much traction either.)

But clearly this is not a must-have item for 2.6.16.

	Ingo
