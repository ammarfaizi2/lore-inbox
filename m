Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbQKJPIX>; Fri, 10 Nov 2000 10:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131183AbQKJPIN>; Fri, 10 Nov 2000 10:08:13 -0500
Received: from mail.zmailer.org ([194.252.70.162]:61960 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S131158AbQKJPIE>;
	Fri, 10 Nov 2000 10:08:04 -0500
Date: Fri, 10 Nov 2000 17:07:54 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Message-ID: <20001110170754.K13151@mea-ext.zmailer.org>
In-Reply-To: <80256991.007632DE.00@d06mta06.portsmouth.uk.ibm.com> <3A09C725.6CFA0EE2@holly-springs.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A09C725.6CFA0EE2@holly-springs.nc.us>; from rothwell@holly-springs.nc.us on Wed, Nov 08, 2000 at 04:35:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I have been wondering what all of the furor has been about...

	Initially I thought that it is "a way to load in a module which
	defines its own syscalls, etc.." and/or "we want to sell binary
	images which can activate some hooks" but having just read the
	GKHI README, that thing is far away from its intentions.
	(Well, it doesn't preclude those, but neither it mentions them
	 as objectives.  And giving a license stating use of GNU GPL
	 also doesn't quite fit "proprietary binary hook" image..)

On Wed, Nov 08, 2000 at 04:35:33PM -0500, Michael Rothwell wrote:
> Sounds great; unfortunately, the core group has spoken out against a
> modular kernel.

	Really ?

$ /sbin/lsmod 
Module                  Size  Used by
parport_pc             23184   1 (autoclean)
lp                      5072   0 (autoclean) (unused)
parport                30048   1 (autoclean) [parport_pc lp]
8021q                  10032   2
3c59x                  24304   2 (autoclean)
ipv6                  152816  -1 (autoclean)
autofs                 11536   1 (autoclean)
usb-uhci               23408   0 (autoclean) (unused)
usbcore                49504   1 (autoclean) [usb-uhci]
es1371                 29920   0
ac97_codec              7824   0 [es1371]
soundcore               4336   4 [es1371]

> -M
> 
> richardj_moore@uk.ibm.com wrote:
> > 
> > We've just release version 0.6 of Generalised Kernel Hooks Interface (GKHI)
> > see the IBM Linux Technology Centre's web page DProbes link:
> > http://oss.software.ibm.com/developerworks/opensource/linux

... (reordered, cut away..)

> > Here's the abstract for this facility. With this intend to modularise our
> > RAS offerings, in particular DProbes, so that they can be applied
> > dynamically without having to be carried as excess baggage.

	Richard,

	Please educate me, what does "our RAS offerings" mean here ?
	(I didn't find "RAS" at your signature-URL site, but I didn't
	 poke around very much..)

	I do know that when IBM suits speak with phrases like that,
	they are selling me something which costs $$$.

	Which definitely gives proprietary, binary only, hook image...
	But GKHI, and DProbes are neither. Thus I am confused, but can
	understand the furor...

> > Some folks expressed an interest in this type of facility recently in
> > discussions concerning making call-backs from the kernel to kernel modules.

	Indeed,  one such mechanism could be a way to register IOCTL
	call chains, which now (for sockets) are quite ugly.
	Lots and lots of subsystems do ioctl()s via /proc/ objects
	just because other methods are way too messy.

	[ ioctl's go via the protocol family of the control socket to
	  family-specific subset, but then the "fun" begins for things
	  which aren't quite of any specific protocol family -- see
	  DLCI support hooks at  ipv4,  and bridge ioctls at both ipv4
	  and at packet.

	  Grep the kernel source for "_hook", and you see a lot of
	  things..  Mostly varying mouses, and bridging, it seems.
	  Netfilter calls its managed coherent interface "hook", but
	  it is way better. ]

	Also the bridging system is less than desirable looking with
	its pervasive hooks, but that can be solved by making layer2
	devices fully stackable.  (Something for 2.5)



> > Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).
> > http://oss.software.ibm.com/developerworks/opensource/linux
> > Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
> > IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
