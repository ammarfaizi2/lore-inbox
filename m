Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVAPU0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVAPU0c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 15:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbVAPU0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 15:26:31 -0500
Received: from cathy.bmts.com ([216.183.128.202]:64741 "EHLO cathy.bmts.com")
	by vger.kernel.org with ESMTP id S262593AbVAPUZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 15:25:47 -0500
Date: Sun, 16 Jan 2005 15:25:21 -0500
From: Mike Houston <mikeserv@bmts.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: jonsmirl@gmail.com, airlied@gmail.com, covici@ccs.covici.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Message-Id: <20050116152521.31ae7846.mikeserv@bmts.com>
In-Reply-To: <20050116121823.GA7734@hh.idb.hist.no>
References: <41E64DAB.1010808@hist.no>
	<16870.21720.866418.326325@ccs.covici.com>
	<21d7e997050113130659da39c9@mail.gmail.com>
	<20050115185712.GA17372@hh.idb.hist.no>
	<21d7e997050116020859687c4a@mail.gmail.com>
	<20050116105011.GA5882@hh.idb.hist.no>
	<9e4733910501160304642f7882@mail.gmail.com>
	<20050116121823.GA7734@hh.idb.hist.no>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jan 2005 13:18:23 +0100
Helge Hafting <helgehaf@aitel.hist.no> wrote:

> On Sun, Jan 16, 2005 at 06:04:32AM -0500, Jon Smirl wrote:
> > you need to check the output from "modprobe drm debug=1" "modprobe
> > radeon" and see if drm is misidentifying the board as AGP. We
> > don't want to fix something if it isn't broken.
> > 
> Stupid question - how do I get a modular drm?
> I usually make everything compiled-in with no module support.
> But now I made a kernel with module support and selected "M"
> for the agp stuff and for the radeon and matrox DRM support.
> But DRM itself will only accept Yes or No, Module is not an
> option there with "make menuconfig".  So I can load
> and unload the radeon module now, but there is no DRM module.
> loading/unloading radeon gives me messages from DRM about this
> happening, but DRM itself is compiled in so I can't modprobe it
> with that debug parameter.
> 
> Is there perhaps something in some other menu that needs to be (M)
> before (M) becomes an option for DRM?
> 
> Helge Hafting

Hello,

I can help shed a bit of light on this particular discrepancy. It's
only very recently that "drm" itself has been selectable as a
separate module. In plain 2.6.10 it hasn't happened yet. (I noticed it
when doing 2.6.11-rc1)

In 2.6.10 the "direct rendering manager" choice just enables the other
DRM choices below it, and the DRM code was
built into your video card specific module.

Now, the "direct rendering manager" choice is now individually
selectable and when you modprobe your card specific module, it
loads "drm" as a dependent module.

e.g. from lsmod on my system with 2.6.11-rc1:

Module                  Size  Used by
radeon                 51584  1 
drm                      37012  2 radeon
intel_agp              11676  1 
agpgart                15272  2 drm,intel_agp

Where before there was no module "drm" and it was a fatter 90 kb
radeon module.

I hope you get your problem solved,
Mike
