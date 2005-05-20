Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVETUBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVETUBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 16:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVETUBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 16:01:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:63129 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261565AbVETUBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 16:01:33 -0400
Date: Fri, 20 May 2005 13:03:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Richard B. Johnson" <linux-os@analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen regen buffer at 0x00b8000
In-Reply-To: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0505201259560.2206@ppc970.osdl.org>
References: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 May 2005, Richard B. Johnson wrote:
> 
> Why can't I consistantly write to the VGA screen regen buffer
> and have it appear on the screen????

Don't do it.

> It looks like access there is cached??? One needs to change
> VT consoles to make it appear!!

No. 

> The screen-regen buffer at this address is hardware, in the
> chip! It should not be cached!

It's not cached, and it's hardware, and you don't know your VGA well 
enough.

0x00b8000 may be the beginning of video memory (in certain text
configurations) but it is _not_ where the screen is. That is offset by the
text offset register (I forget what index that is), and what you're seeing
is almost certainly due to the fact that the kernel VGA console driver
scrolls by just changing that offset, instead of moving lots of slow PCI
memory around.

Switching consoles works for you, because it ends up resetting the offset.

Anyway, you really _really_ shouldn't do anything like this in the first 
place.

		Linus
