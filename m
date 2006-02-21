Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932743AbWBUQkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743AbWBUQkl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 11:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbWBUQkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 11:40:41 -0500
Received: from iabervon.org ([66.92.72.58]:43268 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932743AbWBUQkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 11:40:40 -0500
Date: Tue, 21 Feb 2006 11:41:13 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Missing file
In-Reply-To: <Pine.LNX.4.61.0602211001300.4470@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0602211109460.6773@iabervon.org>
References: <Pine.LNX.4.61.0602201201200.4888@chaos.analogic.com>
 <1140456505.2979.66.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0602201333360.5440@chaos.analogic.com>
 <Pine.LNX.4.64.0602201810260.6773@iabervon.org>
 <Pine.LNX.4.61.0602211001300.4470@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2006, linux-os (Dick Johnson) wrote:

> The modules were generally compiled against a compiled kernel that
> has everything we need enabled, including PCI -- and what
> we don't use, disabled. So, the file was available up until
> 2.6.13.4 and disappeared by 2.6.15.4. Also, even the pci.ids
> has now been eliminated. This means that one needs to keep
> /usr/share/hwdata/pci.ids current if that is what we need to
> use now, which implies that one needs a specific Linux
> distribution NotGood(tm).

You could just include the latest pci.ids in your module, which wouldn't 
be any worse than relying on the kernel to have an up-to-date one. For 
that matter, if they're building the latest version of your code against 
an old kernel, the pci.ids in the old kernel is obviously going to be at 
least as old as the kernel, if not older. Most likely, the most current 
files around when someone is building your code will be your code, so, if 
it includes a pci.ids, chances are that it's the best one to use. I 
generally haven't seen the file get installed; most packages seem to just 
include a copy if they need it.

> Most embedded systems do not have any 'init', shells, or
> anything like that. That's what makes them reliable and
> secure. The only thing that could possibly get executed
> is what designers designed and coded for the system. So
> moving something that has been "in the kernel" to "outside"
> has some considerable consequences, especially since there
> isn't an "outside".

I'm actually more used to embedded systems that don't have any way of 
communicating a string to the user. Or having unexpected PCI devices 
plugged into them.

Doing stuff in the kernel instead of userspace doesn't make the system any 
more secure or reliable, either. They'd probably be better off having 
their display code use libpci, so that, if the translation screws up, some 
non-critical userspace program aborts instead of the kernel oopsing or 
panicing. You don't need a shell to use a library.

	-Daniel
*This .sig left intentionally blank*
