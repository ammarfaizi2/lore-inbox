Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317340AbSGII5L>; Tue, 9 Jul 2002 04:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317341AbSGII5K>; Tue, 9 Jul 2002 04:57:10 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:56995 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317340AbSGII5J>; Tue, 9 Jul 2002 04:57:09 -0400
Date: Tue, 9 Jul 2002 03:59:40 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Roman Zippel <zippel@linux-m68k.org>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Module removal 
In-Reply-To: <Pine.LNX.4.44.0207090744180.8911-100000@serv>
Message-ID: <Pine.LNX.4.44.0207090352090.25461-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2002, Roman Zippel wrote:

> Who is changing the use count? How do you ensure that someone doesn't
> cache a reference past that magic sync point?
> IMO the real problem is that cleanup_module() can't fail. If modules
> already do proper data acounting, it's not too difficult to detect if
> there still exists a reference. In the driverfs example the problem is
> that remove_driver() returns void instead of int, so it can't fail.

I tend to see this differently: cleanup_module() cannot fail, but it can 
sleep. So it's perfectly fine to deregister, wait until all references are 
gone, clean up and return. So a kind of two-stage unregister is already 
happening. 

It's different in that it does use explicit refcounting, but 
when the right interfaces are provided, the driver author doesn't need to 
care - the author should just call pci_unregister/netdev_unregister/.., 
that'll sleep until all references are gone (which also means no one will 
use callbacks into the module anymore) and be done.

--Kai


