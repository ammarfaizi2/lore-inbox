Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263173AbTDBV7k>; Wed, 2 Apr 2003 16:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263174AbTDBV7k>; Wed, 2 Apr 2003 16:59:40 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:56737 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263173AbTDBV7g>; Wed, 2 Apr 2003 16:59:36 -0500
Date: Wed, 2 Apr 2003 23:10:46 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Fendrakyn <fendrakyn@europaguild.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] E7x05 chipset bug in 2.5 kernels' AGPGART driver.
Message-ID: <20030402221046.GA30881@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Fendrakyn <fendrakyn@europaguild.com>, linux-kernel@vger.kernel.org
References: <200304022050.03026.fendrakyn@europaguild.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304022050.03026.fendrakyn@europaguild.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 08:50:03PM +0200, Fendrakyn wrote:

 > There is a mistake in the Makefile of drivers/char/agp, the line concerning 
 > i7x05-agp support does not match the one in the Kconfig, thus e7x05 support 
 > is never compiled, be it as a module or in the kernel.

I'm really amazed. This has been broken for months, and no-one noticed.
The day I fixed it in the agpgart bk tree, I got a half dozen reports,
and now I'm getting one daily. Truly bizarre.

 > The last problem is more important and I have yet to find a solution. It seems 
 > like the driver stores device 0 in his agp_bridge->dev (0x255d for E7205, 
 > 0x2550 for E7505) but it uses registers from device 1 (0x2552) thus the 
 > chipset cannot be configured properly. The fetch_size function fails to 
 > determine aperture size.

Yep, the other issues (compile problems) are fixed up and will be going
to Linus real soon now, this problem though is something that is being
looked at by Matt (i7x05 gart driver author) right now.
Hopefully that'll also get fixed up with the changes being readied for 2.5.67

The reason i7x05 does things differently is that the generic-3.0 code
looks at the devices hanging of the device 0 (in that case, agp gfx cards).
I realised last week that the generic code is broken, as every other
agp chipset has the agp cards as secondaries of the agp bridge, not the
host bridge. Rather than fudge things like this, it looks like a lot
of the generic-3.0 stuff will be ripped out. It doesn't really work
properly, and is of questionable use.

 > Sorry if this is redundant and is already being looked at.

No problem 8-)

		Dave

