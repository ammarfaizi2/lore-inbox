Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVFGDqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVFGDqX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 23:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVFGDqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 23:46:23 -0400
Received: from peabody.ximian.com ([130.57.169.10]:23469 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261807AbVFGDqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 23:46:21 -0400
Subject: Re: [PATCH] fix tulip suspend/resume
From: Adam Belay <abelay@novell.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       Karsten Keil <kkeil@suse.de>
In-Reply-To: <1118115123.6850.43.camel@gaston>
References: <20050606224645.GA23989@pingi3.kke.suse.de>
	 <1118110545.6850.31.camel@gaston>  <20050607025710.GD3289@neo.rr.com>
	 <1118115123.6850.43.camel@gaston>
Content-Type: text/plain
Date: Mon, 06 Jun 2005 23:42:31 -0400
Message-Id: <1118115751.3245.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 13:32 +1000, Benjamin Herrenschmidt wrote:
> > > It should probably test for message state, it's not worth doing
> > > pci_set_power_state(D3) if PMSG_FREEZE is passed... (just slows down
> > > suspend to disk)
> > 
> > Yeah, I added pci_choose_state in my last email.  This will at least help
> > avoid powering off.  Still, I agree this needs to be handled specifically.
> > Currently, I don't think many drivers support PMSG_FREEZE.
> 
> Nope, but I've been improving swsusp support on macs lately and have
> already a bunch of driver fixes waiting.
> 
> Now I need to get Pavel, Patrick and I to agree about the PM toplevel
> core changes before I can send all that stuff to Andrew :)
> 
> Ben.

What PM toplevel core changes are you referring to?  I've look over the
changes to pm_ops and they seem to make sense.  Still I almost wonder if
we should make the entire thing arch specific code, and then have this
code call things like device_suspend().  If mac hardware required that
many new hooks, then other platforms might require even more.

Thanks,
Adam


