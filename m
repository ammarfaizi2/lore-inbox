Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWBMVXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWBMVXL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 16:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWBMVXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 16:23:11 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:48611 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030188AbWBMVXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 16:23:10 -0500
Date: Mon, 13 Feb 2006 22:22:57 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] hrtimer: remove data field
In-Reply-To: <20060213135456.GC12923@elte.hu>
Message-ID: <Pine.LNX.4.61.0602132213270.30994@scrub.home>
References: <Pine.LNX.4.61.0602130211060.23839@scrub.home> <20060213135456.GC12923@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Feb 2006, Ingo Molnar wrote:

> > The nanosleep cleanup allows to remove the data field of hrtimer. The 
> > callback function can use container_of() to get it's own data. Since 
> > the hrtimer structure is usually embedded in other structures, the 
> > code also becomes a bit simpler.
> 
> i addressed this when you first raised this issue (back in the ktimers 
> flamewars), and generally the feeling of people i asked was that doing 
> the container_of() approach is less readable than an explicit 'data' 
> field. It also deviates from struct timer_list, which we wanted to stay 
> close to. Furthermore, for standalone hrtimers this creates the need to 
> generate a wrapper structure. So i dont really like this change - but no 
> strong feelings either way.

With the complete size reduction struct hrtimer becomes 32 bytes on 32 
bits archs and so we can fit the basic hrtimer into one or two cache 
lines.
container_of() is becoming more and more common in the kernel, so I don't 
know who asked, it's not that difficult to use. I agree it makes simple 
test modules a bit more difficult, but so far the more common case is that 
this structure is embedded in other structures and container_of() creates 
simpler code. Additionally you get type checking for free, which you don't 
get with a void pointer.

bye, Roman
