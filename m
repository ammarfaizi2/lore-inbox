Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSGILEQ>; Tue, 9 Jul 2002 07:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313743AbSGILEP>; Tue, 9 Jul 2002 07:04:15 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:32787 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313571AbSGILEO>; Tue, 9 Jul 2002 07:04:14 -0400
Date: Tue, 9 Jul 2002 13:06:16 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Module removal 
In-Reply-To: <Pine.LNX.4.44.0207090352090.25461-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0207091252360.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 9 Jul 2002, Kai Germaschewski wrote:

> I tend to see this differently: cleanup_module() cannot fail, but it can
> sleep. So it's perfectly fine to deregister, wait until all references are
> gone, clean up and return. So a kind of two-stage unregister is already
> happening.

That's a possibility, if you can live with a noninterruptable rmmod
process sleeping for a very long time...

> It's different in that it does use explicit refcounting, but
> when the right interfaces are provided, the driver author doesn't need to
> care - the author should just call pci_unregister/netdev_unregister/..,
> that'll sleep until all references are gone (which also means no one will
> use callbacks into the module anymore) and be done.

The unregister function can't prevent someone from start using the device
again (at least not with reasonable effort), but it can detect this. The
author should just check the return value, like he already (hopefully)
does during initialization.

bye, Roman

