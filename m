Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290944AbSBFXeS>; Wed, 6 Feb 2002 18:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290945AbSBFXeJ>; Wed, 6 Feb 2002 18:34:09 -0500
Received: from air-2.osdl.org ([65.201.151.6]:34992 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S290944AbSBFXdw>;
	Wed, 6 Feb 2002 18:33:52 -0500
Date: Wed, 6 Feb 2002 15:34:18 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Pavel Machek <pavel@suse.cz>
cc: Andre Hedrick <andre@linuxdiskcert.org>,
        Russell King <rmk@arm.linux.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
In-Reply-To: <20020206122253.GB446@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0202061502290.25114-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> These are easy ones, but what about
> 
> Case 4: 386 with no PCI
> 
> and what's worse
> 
> Case 5: 486 with both PCI and VLB, where ide is on the VLB?
> 
> cases 4 and 5 are IMO hard, because it is difficult to know where it
> really is... and I'm not sure current kernel knows it.

Does the IDE subsystem always know where it sits? I.e. does it know that a 
particular IDE controller is a function of the south bridge, an add-on PCI 
card, or directly on the motherboard?

If it does, there is no problem. It can properly add itself in the correct 
hierarchial position. 

If it doesn't, it's still not much of a problem (at least not at first 
glance).

If the IDE controller doesn't know it's parent, create an 'ide' bus as a 
child of the root and put ide devices under it. If there are multiple 
controllers or channels, represent them accordingly. 

	-pat

