Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289592AbSAOTmA>; Tue, 15 Jan 2002 14:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289608AbSAOTlv>; Tue, 15 Jan 2002 14:41:51 -0500
Received: from air-1.osdl.org ([65.201.151.5]:18057 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S289592AbSAOTlp>;
	Tue, 15 Jan 2002 14:41:45 -0500
Date: Tue, 15 Jan 2002 11:43:18 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Dave Jones <davej@suse.de>
cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Defining new section for bus driver init
In-Reply-To: <20020115190731.F32088@suse.de>
Message-ID: <Pine.LNX.4.33.0201151135080.9053-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Jan 2002, Dave Jones wrote:

> On Tue, Jan 15, 2002 at 09:53:27AM -0800, Patrick Mochel wrote:
>  > > I like it.  Are you going to want to move the other busses to this
>  > > (sbus, mca, ecard, zorro, etc.)?
>  > Yes, though I don't have a way to test them...
>
>  Not a problem, I'm sure you'll find an army of testers on l-k.

Ok, as I'm converting the drivers, I find that some have the option of
modular compilation, like isapnp and irda. In theory, it seems that each
of the bus drivers could be compiled modular. But, how do you define it in
the section?

I was thinking something like this:

#ifdef MODULE
#define __devsubsys_init(fn) \
	module_init(fn);
#else
#define __devsubsys_init(fn) \
	static initcall_t __devsubsys_##fn __devsubsys_call = fn;
#endif

Thoughts?

	-pat

