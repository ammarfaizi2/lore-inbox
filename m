Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbUCWERF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 23:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbUCWERF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 23:17:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:64491 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261966AbUCWERB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 23:17:01 -0500
Subject: Re: Issues with /proc/bus/pci
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040322194759.7a38ffe9.davem@redhat.com>
References: <1080007613.22212.61.camel@gaston>
	 <20040322183126.16fe76cc.davem@redhat.com>
	 <1080009609.23717.81.camel@gaston>
	 <20040322194759.7a38ffe9.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1080014534.23717.92.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Mar 2004 15:02:16 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-23 at 14:47, David S. Miller wrote:
> On Tue, 23 Mar 2004 13:40:11 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > What do you think ?
> 
> Ok, it does sound like we need something else.
> 
> Another idea is to always at least provide a "virtual" host
> bridge on these weird platforms you mention.  You control
> the PCI config space etc. operations, so you could handle
> the virtual host bridge correctly right?

Yes. Though I'm not sure i like the idea.

Note that I don't have a platform affected by this problem at hand
(except the G5 for which I can tweak to make the HT host show up).
I have to double check some of the weirdest embedded PPC setups though,
those "hiding" the host bridge should have all been converted to just
hide it's BARs by now hopefully. But the theorical problem persists.

And it's still not convenient for userland things that need to access
one video card knowing it's PCI ID to have to iterate around to find
the host bridge, but I can live with that ;) Actually, for my specific
need for this softboot thing, it is powermac specific, so I can just
hack the ppc port to always acccept a mapping of the low 0x400 of IO
space from any PCI device... (provided those are actually in the host
bridge resources).

I'll see what I can do on our side

Ben.


