Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbTBSQuC>; Wed, 19 Feb 2003 11:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbTBSQuB>; Wed, 19 Feb 2003 11:50:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60686 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261286AbTBSQuB>; Wed, 19 Feb 2003 11:50:01 -0500
Date: Wed, 19 Feb 2003 08:56:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: clean up the IDE iops, add ones for a dead iface
In-Reply-To: <1045647562.12533.1.camel@zion.wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0302190853180.18995-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 19 Feb 2003, Benjamin Herrenschmidt wrote:
> 
> Hrm... I tend to agree with Russell here... 0x7f is the "safe" value
> for IDE. IDE controllers with nothing wired shall have a pull down
> on D7. The reason is simple: busy loops in the IDE code waiting for
> BSY to go down.

But that's a BUG.

We've seen that before: try unplugging a PCMCIA IDE card unexpectedly. 

Guess what? It will start returning 0xff. And the machine dies, because 
the PCMCIA interrupt happened due to the removal event will also be shared 
by the IDE driver, so the IDE driver will react badly even before anybody 
has had a chance to tell it that the hardware no longer exists.

So if you have code that doesn't work with 0xff, then that code is already 
a-priori buggy. And getting it fixed would be a damn good idea.

		Linus

