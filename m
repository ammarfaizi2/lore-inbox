Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbTDNIkT (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 04:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbTDNIkT (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 04:40:19 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:15817 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id S262866AbTDNIkR (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 04:40:17 -0400
Subject: Re: [Linux-fbdev-devel] Re: [FBDEV BK] Updates and fixes.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@digeo.com>
Cc: James Simmons <jsimmons@infradead.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <20030414005814.6719915f.akpm@digeo.com>
References: <Pine.LNX.4.44.0304140545010.10446-100000@phoenix.infradead.org>
	 <20030414005814.6719915f.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050310411.5574.44.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Apr 2003 10:53:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> When I enable framebuffer with your latest patch on this machine the display
> screws up - it alternates between blackness and a strange flicker of
> horizontal and vertical grey lines.  No text is visible.
> 
> This machine has:
> 
> ATI Technologies Inc Rage Mobility M3 AGP 2x (rev 02)

This is a r128 based chip, which lacks some of the proper support for
LCD stuff (especially automatic retreival of the EDID from BIOS) that
we have in radeonfb. If you feed the driver with a suitable mode, it
should work

> A second desktop machine has:
> 
> VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX440] (rev a3)
> 
> When fbcon is enabled here the screen is full of random uninitialised gunk
> and no text is readable.

I haven't yet checked which codebase is in there for rivafb, I have
started collecting various patches around & doing my own fixes, I have
a version here that works on PPC with GeForce2 & 4, though I still
have problems with accel on the GeForce4. It's a 2.4 code base right
now, I haven't had time to clean that up and release a patch though.

If 2.5 still has the old codebase, then GeForce4 isn't properly
supported yet.

Note that if you have a flat panel, then the problem of properly
retreiving the EDID to get a suitable default mode is also present
there, unless James added some support for it.

> 	ATI Technologies Inc Radeon VE QY
> 
> it seems to work OK as well.  The penguins started out on a black background.
> I didn't test dual-head mode.

Ok, I've seen that James added various fixes to 2.5 radeonfb, I still
have to port some of my 2.4 ones to 2.5, I except those chips to be
properly supported with fbdev.

Ben.

