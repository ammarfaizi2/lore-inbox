Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316431AbSEWPPn>; Thu, 23 May 2002 11:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316756AbSEWPPm>; Thu, 23 May 2002 11:15:42 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:49395 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S316431AbSEWPPk>; Thu, 23 May 2002 11:15:40 -0400
Date: Thu, 23 May 2002 08:16:26 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: What to do with all of the USB UHCI drivers
 in the kernel?
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-usb-users@lists.sourceforge.net
Message-id: <3CED07CA.2020901@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
In-Reply-To: <20020520223132.GC25541@kroah.com>
 <008b01c2012d$69db21c0$0601a8c0@CHERLYN> <20020522192101.GG4802@kroah.com>
 <3CEBF314.3090209@bonin.ca> <20020522201546.GB5168@kroah.com>
 <3CEC8D6B.9060500@evision-ventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you please just do me a small favour and drop something
> in to linux/Documentation. Becouse I'm right now already confused
> about which driver to use and which alias to put in /etc/modules.conf
> so kudzu stops hollering about not knowing what to do
> if I out of a sudden reboot in to 2.5.xx kernel.

I don't think that belongs in Linux/Documentation since it's
specific to RedHat.  Apart from the "which UHCI" confusion,
you could use the /etc/rc.d/init.d/hotplug script to start
up USB. (That's not part of RedHat though; they use kudzu to
promote what seems like more of a static config model.)

I have an RH 7.3 system that has this ... though I had to
tweak it by hand since their setup stored multiple entries
for some drivers, and didn't put EHCI first (so devices on
USB 2.0 adapters would start out with one driver, disconnect,
then reconnect using the "right" host controller):

	alias usb-controller  ehci-hcd
	alias usb-controller1 ohci-hcd
	alias usb-controller2 uhci-hcd
	alias usb-controller3 usb-ohci
	alias usb-controller4 usb-uhci

Note that the "uhci-hcd" would be "usb-uhci-hcd" if you're trying
to experiment with that version on the 2.5 kernel, if you're not
doing manual rmmod/modprobe (which I usually end up doing).

That causes silly boot messages for the hardware or drivers you
may not have, but works reliably/correctly for all current kernels.

- Dave



