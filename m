Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268163AbUIKPQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268163AbUIKPQy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 11:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268168AbUIKPQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 11:16:53 -0400
Received: from the-village.bc.nu ([81.2.110.252]:18099 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268163AbUIKPQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 11:16:37 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vladimir Dergachev <volodya@mindspring.com>
Cc: Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0409102039380.12529@node2.an-vo.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <Pine.LNX.4.58.0409100209100.32064@skynet>
	 <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <20040910153135.4310c13a.felix@trabant>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0409102039380.12529@node2.an-vo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094912041.21082.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Sep 2004 15:14:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-11 at 01:47, Vladimir Dergachev wrote:
>      One driver per device. I.e. one driver per *physical* device.

This is a religion the kernel doesn't follow. Its a pointless
religion

> Lastly, one point that you appear to have missed: DRM does DMA transfers
> (among everything else). FB sets video modes - i.e. messes with PLL.
> The problem is that there are configurations where messing with PLL while 
> a DMA trasfer is active will lock up PCI (or AGP) bus hard.

Yes its a co-ordination issue. If the IDE disk writes to the bus the
same moment as the IDE CD shit also happens.

> For example, a video decoder can be clocked off pixel clock for video pass 
> through mode. If we trasfer video data to main RAM at the same time and
> FB gets a command instructing it to change resolution there would be a 
> hard lockup.

Gosh, just like if the IDE disk driver changes the bus clocking during
an IDE CD transfer.

You need co-ordination not some horrible glue it all together and pray
hack. Thats always going to be true, and since you can do it without
glueing it all together you might get somewhere by keeping them apart,
otherwise I see no future. Most DRI users don't want FB, most FB users
don't care about DRI or want to control the DRI from the fb side.

Alan

