Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbUEJTzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUEJTzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 15:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUEJTzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 15:55:04 -0400
Received: from colin2.muc.de ([193.149.48.15]:32005 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261425AbUEJTym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 15:54:42 -0400
Date: 10 May 2004 21:54:39 +0200
Date: Mon, 10 May 2004 21:54:39 +0200
From: Andi Kleen <ak@muc.de>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       lhns-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] [PATCH] Node Hotplug Support
Message-ID: <20040510195439.GA99051@colin2.muc.de>
References: <1TfLX-4M4-9@gated-at.bofh.it> <m34qqshx31.fsf@averell.firstfloor.org> <20040510111722.29524459.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510111722.29524459.tokunaga.keiich@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 11:17:22AM +0900, Keiichiro Tokunaga wrote:
> As you mentioned, there can be many more things.  However,
> the examples you showed should be handled by individual hotplug.
> For instance, the processes bound to a certain CPU should be
> handled by CPU hotplug when node hotplug invokes CPU hotplug.
> Also, the device drivers bound to slots should be detached by
> IO hotplug.  Node hotplug is supposed to take care of a container
> device and just invoke individual hotplugs for other devices.
> Node hotplug doesn't break any policy of each hotplug (CPU,
> memory, IO, etc).

To coordinate all them you need user space infrastructure anyways
that knows about all the elements of a node.  I don't see why you want a 
kernel level container too; userspace can do this job already
and would be much more flexible.

> > This has the advantage that if there is some reason to 
> > add CPUs without memory (or memory without CPUs or PCI slots 
> > without anything) it will just work too. It is not clear
> > that your "lump everything mechanism into one" can handle all
> > that. Most likely you would need to add lots of special
> > cases to it to handle all this. Separate mechanisms can
> > do this cleaner.
> 
> Yes. The cases (combination of hardware) would increase.
> However, I don't think there would be that many today.

I am mainly thinking about virtualization here for which hotplug
of everything makes definitely sense. But the requirements could
be very different from what a big iron machine wants.

> Are you saying here that platform-independent and dependent
> codes should be separated so that the independent part could
> be implemented by any other platform (firmware) in their own
> style?  If so, I agree and some discussion are necessary :)

Yep.

-Andi
