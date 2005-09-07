Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVIGWBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVIGWBT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 18:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbVIGWBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 18:01:19 -0400
Received: from main.gmane.org ([80.91.229.2]:29655 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932089AbVIGWBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 18:01:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Wed, 07 Sep 2005 17:57:00 -0400
Message-ID: <dfnnn3$8vm$1@sea.gmane.org>
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com> <431F2760.5060904@tmr.com> <58d0dbf10509071054175e82ff@mail.gmail.com> <200509071552.27543.phillips@istop.com> <58d0dbf105090713283aa455e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: lmcgw.cs.sunysb.edu
User-Agent: KNode/0.9.90
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kiszka wrote:

> Ndiswrapper is already slower than native drivers are, also due to
> horribly implemented Windows drivers btw (the ndis model itself isn't
> that bad, though).

Do you have any evidence to back your claims? What tests did you do to say
that ndiswrapper is slower than native driver? Under X86-64 there is some
overhead due to reshuffling of arguments, but it is so little that I doubt
if it can be measured.

I agree that some drivers, especially old drivers, are nasty from
ndiswrapper's point of view (e.g., a driver uses exception handling
mechanism through "fs" register, which won't work in Linux kernel space,
and another driver allocates huge chunk of memory in atomic context etc.),
but they are valid under Windows.

I have seen some FUD about ndiswrapper - either on madwifi or acx100 project
sites sometime back there was a list of reasons why one shouldn't use
ndiswrapper, one of them is the overhead due to binary emulation. And that
was from a WINE developer! If someone has
ideological/moral/ethical/operational etc issues against using ndiswrapper,
that is perfectly valid. But if you accept that NDIS isn't bad, I don't see
why ndiswrapper would suck (the idea I mean). I myself have gripes with
NDIS for wireless devices though - no support for monitor mode, quality
level etc.

Before someone jumps, let me clarify that although I toil with development
of ndiswrapper, I encourage people to use open source drivers when there is
a choice (e.g., prism54, hostap drivers). But, as pointed out by others,
there is lot of wireless networking hardware with no specifications and
drivers. ndiswrapper is just for such and should a vendor provide
documentation, I am sure someone will write open source driver for it. In
my experience, however, vendors don't seem to be interested much with Linux
support. I have requested quite a few of them to send me sample cards (the
ones for which no native drivers exist) so ndiswrpaper can support them.
Except for US Robotics, not a single vendor cared. A D-Link tech support
guy even laughed at the idea!

In short, if you are buying hardware to run Linux, check first if there are
open source drivers for it. However, if you have a wireless card that
doesn't have native drivers, and if you can't/won't change hardware and you
want to use it under Linux, then ndiswrapper may get the job done.

Not all of the contents in this article is in response to the quoted
article, but I just wanted to clear some misconceptions about goals/use of
ndiswrapper that I have noticed.

Thanks
Giri


