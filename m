Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268259AbUIKR5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268259AbUIKR5F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268240AbUIKR5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:57:04 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:38321 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268273AbUIKRyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:54:35 -0400
Message-ID: <9e473391040911105448c3f089@mail.gmail.com>
Date: Sat, 11 Sep 2004 13:54:34 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <20040911132727.A1783@infradead.org>
	 <9e47339104091109111c46db54@mail.gmail.com>
	 <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004 10:02:57 -0700 (PDT), Linus Torvalds
<torvalds@osdl.org> wrote:
> Jon, you want to get to that "Final step is to integrate the chip specific
> code from DRM and fbdev". Alan doesn't even want to get there. I think
> Alan just wants some simple infrastructure to let everybody play together.

This is the core problem. I want to get to a point where there is a
single, integrated piece of code controlling the complex functions of
the 3D hardware.

I want to get away from the model of "I just got control of the chip,
who knows what the state of it is, I better reset everything". I also
want to get away from "now I want to use this register, i need to
inspect every over driver and piece of user space code to make sure
they don't stomp it". Or "I didn't even know your code existed, sorry
about stomping that critical register and causing 100 bug reports". Or
"why don't we just split the VRAM in half so we don't have to share
memory management".  Or suspend code that restores 2D mode and ignores
3D.

The problem with everyone playing together in separate code bases
assumes that everyone knows what everyone else is doing and that's
never the case. A single card specific code base collects everything
to a single place where it can be monitored.

A good example of this is switching the GPU between 2D and 3D mode on
every process swap.

In general the current X design only has a single 3D client. With a
composited display and pbuffer background drawing we are going to have
one 3D client for every top level window. This is going to require
complicated code to smoothly multitask the 3D drawing streams. The
last thing we need is something in the middle of this switching the
chip in and out of 2D mode.

-- 
Jon Smirl
jonsmirl@gmail.com
