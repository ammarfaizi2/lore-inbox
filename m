Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269035AbTBXAve>; Sun, 23 Feb 2003 19:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269036AbTBXAve>; Sun, 23 Feb 2003 19:51:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40197 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269035AbTBXAvd>; Sun, 23 Feb 2003 19:51:33 -0500
Date: Sun, 23 Feb 2003 16:59:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Scott Murray <scottm@somanetworks.com>, <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Make hot unplugging of PCI buses work
In-Reply-To: <20030223212432.J20405@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0302231654370.1690-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Feb 2003, Russell King wrote:
> 
> However, whether x86 PCs will survive bus renumbering or not remains to
> be seen.  We currently try to leave as much of the configuration intact
> from the BIOS.

Note that I made cardbus bus numbering _ignore_ the BIOS-setup numbering 
even on PC's, exactly because of issues like this - trying to keep the 
original BIOS numbering just won't work if the BIOS sets the wrong numbers 
(I saw a BIOS that had happily assigned the _same_ PCI bus number to both 
cardbus functions, whee).

I think we can (and should) make all hotpluggable PCI bridges use that 
same cardbus logic.

The real problematic case I see is if there are transparent hotplug
bridges, with some devices just magically appear and disappear from a part 
of a bus because of some invisible bridge. I don't know if such things 
exist or even _can_ exist, but the perverse nature of PC hardware makes me 
suspect they do.

			Linus

