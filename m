Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267583AbSLEWxd>; Thu, 5 Dec 2002 17:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267584AbSLEWxc>; Thu, 5 Dec 2002 17:53:32 -0500
Received: from air-2.osdl.org ([65.172.181.6]:50388 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267583AbSLEWxb>;
	Thu, 5 Dec 2002 17:53:31 -0500
Date: Thu, 5 Dec 2002 16:43:38 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@suse.cz>
cc: Jeff Garzik <jgarzik@pobox.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.50, ACPI] link error
In-Reply-To: <20021205224019.GH7396@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0212051632120.974-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Doesn't that imply your fix is broken to begin with?
> 
> ACPI/S4 support needs swsusp. ACPI/S3 needs big part of
> swsusp. Splitting CONFIG_ACPI_SLEEP to S3 and S4 part seems like
> overdesign to me, OTOH if you do the work it is okay with me.

You broke the design. S3 support was developed long before swsusp was in 
the kernel, and completely indpendent of it. It should have remained that 
way. 

S3 support is a subset of what is need for S4 support. 

swsusp is an implementation of S4 support. In theory, there could be 
multiple implementations that all use the same core (saving/restoring 
state). 

There could also be different power management schemes that use swsusp as 
an implementation for suspend-to-disk. But, that's another tangent. 

CONFIG_ACPI_SLEEP should give you S3 support, and the ACPI side of S4 
support. The comment in the config option should tell the user that they 
must choose a suspend implementation (e.g. CONFIG_SUSPEND, which should 
prolly be CONFIG_SWAP_SUSPEND) in order to get complete S4 support. (The 
ACPI side can make an empty call to swsusp if no implementation is 
selected). 


Some time ago, I made a BK repo for suspend support. I axed it, since no 
one ever used it. But, it's back again, and I'll be integrating your 
patches and try to dedicate a few extra cycles to resolving some of the 
issues. I'll send an announcement to the list once I've integrated your 
patches. 

	-pat

