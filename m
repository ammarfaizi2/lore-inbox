Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTJXR7i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 13:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbTJXR7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 13:59:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:28115 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262422AbTJXR7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 13:59:37 -0400
Date: Fri, 24 Oct 2003 10:59:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Jeff Garzik <jgarzik@pobox.com>, Jon Smirl <jonsmirl@yahoo.com>,
       Eric Anholt <eta@lclark.edu>, <kronos@kronoz.cjb.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-fbdev-devel@lists.sourceforge.net>,
       dri-devel <dri-devel@lists.sourceforge.net>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
In-Reply-To: <20031024165718.GA4972@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0310241051450.8177-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Oct 2003, Petr Vandrovec wrote:
> 
> It would be nice if it works... For matrox hardware I have to map ROM
> over framebuffer (it is solution recommended by datasheet), as there is
> no way to get memory range allocated for ROM unless ROM was left enabled
> all the time.

That's fine - it sounds like Matrox hardware is just buggy, and then you 
will never be able to use the generic "enable ROM" routines. That 
shouldn't detract from other drivers doing it, though. 

On the other hand, we might well be able to work around the matrox
behaviour if we really want to: writing all-ones to the register should
work, and that is the way we figure out the size of the allocation anyway.  

So this is one of those things where having a generic routine and knowing
a bit about some implementation oddities migth well work out. Maybe some
other cards have the same odd behaviour.

But since Matrox has a separate recommended solution in their datasheets,
I suspect the right thing is just to ignore Matrox when talking about the 
generic thing.

		Linus

