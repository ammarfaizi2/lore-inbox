Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbUJXKGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUJXKGa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 06:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUJXKGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 06:06:30 -0400
Received: from zeus.kernel.org ([204.152.189.113]:6358 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261414AbUJXKGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 06:06:04 -0400
Date: Sun, 24 Oct 2004 06:05:57 -0400
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, David Hinds <dahinds@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org, prism54-devel@prism54.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.9-mm1: pc_debug multiple definitions
Message-ID: <20041024100557.GC17506@ruslug.rutgers.edu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>,
	David Hinds <dahinds@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com,
	linux-net@vger.kernel.org, prism54-devel@prism54.org,
	netdev@oss.sgi.com
References: <20041022032039.730eb226.akpm@osdl.org> <20041022133929.GA2831@stusta.de> <20041024034152.GB17506@ruslug.rutgers.edu> <20041024093340.GA4216@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041024093340.GA4216@stusta.de>
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 11:33:40AM +0200, Adrian Bunk wrote:
> On Sat, Oct 23, 2004 at 11:41:52PM -0400, Luis R. Rodriguez wrote:
> > On Fri, Oct 22, 2004 at 03:39:29PM +0200, Adrian Bunk wrote:
> > > 
> > > The following compile error comes from Linus' tree:
> > > 
> > > 
> > > <--  snip  -->
> > > 
> > > ...
> > >   LD      drivers/built-in.o
> > > drivers/pcmcia/built-in.o(.bss+0xf20): multiple definition of `pc_debug'
> > > drivers/net/built-in.o(.data+0x24ae0): first defined here
> > > make[1]: *** [drivers/built-in.o] Error 1
> > > 
> > > <--  snip  -->
> > > 
> > > 
> > > The pc_debug in drivers/pcmcia/ds.c was made non-static in Linus' tree,
> > > but the global definition of a global variable with such a generic name 
> > > in drivers/net/wireless/prism54/islpci_mgt.c seems to be equally wrong.
> > 
> > Great, anyone know why this change was done on ds.c ? The pc_debug on
> > prism54 comes from the original Intersil driver. It is used to for
> > debugging but we should move away from our current debugging mechanism
> > to netif_msg.
> >...
> 
> pc_debug is a pretty generic name - it seems too generic in both files.
> 
> In prism54, couldn't it be called prism54_pc_debug?

Sure although that's doing a half ass job. It'll fix your compile
problems for sure but ideally we should move away from the old debug
mechanisms that came with the driver originally. We do this by moving to
to netif_msg.

	Luis

-- 
GnuPG Key fingerprint = 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E
