Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271236AbTG2FSS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 01:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271245AbTG2FSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 01:18:18 -0400
Received: from mgr2.xmission.com ([198.60.22.202]:33687 "EHLO
	mgr2.xmission.com") by vger.kernel.org with ESMTP id S271236AbTG2FSR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 01:18:17 -0400
Date: Mon, 28 Jul 2003 23:18:12 -0600
From: "S. Anderson" <sa@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "S. Anderson" <sa@xmission.com>, pavel@xal.co.uk,
       linux-kernel@vger.kernel.org, adaplas@pol.net
Subject: Re: OOPS 2.6.0-test2, modprobe i810fb
Message-ID: <20030728231812.A20738@xmission.xmission.com>
References: <20030728171806.GA1860@xal.co.uk> <20030728201954.A16103@xmission.xmission.com> <20030728202600.18338fa9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728202600.18338fa9.akpm@osdl.org>; from akpm@osdl.org on Mon, Jul 28, 2003 at 08:26:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 08:26:00PM -0700, Andrew Morton wrote:
> "S. Anderson" <sa@xmission.com> wrote:
> >
> > On Mon, Jul 28, 2003 at 06:18:07PM +0100, Pavel Rabel wrote:
> > > Got this OOPS when trying "modprobe i810fb",
> > > kernel 2.6.0-test2
> > > 
> > 
> > I am also getting this oops, or somthing very simmillar.
> 
> yay!  I finally fixed a bug! (sheesh, bad day).
> 
> The device table is not null-terminated so we run off the end during
> matching and go oops.
> 

Thanks, that fixes the oops Pavel reported!

But I now realize the oops I am getting is different...

It happens only if any of these "i810fb, i810_audio or intel-agp"
are compiled in the kernel or insterted as modules.

i810fb, i810_audio or intel-agp load up fine and seem to all work
properly. I only get the oops when I put a card into my cardbus slot.

this is what i think happens, when I put the card in, it sets off some
functions that will try to get a driver for the card I just inserted.
when it gets to the pci_bus_match function, my cards vendor and device 
numbers are tested against a drivers id_table. when that driver is 
"i810fb, i810_audio or intel-agp" (and i810fb, i810_audio or intel-agp
is allready loaded) the id_table is at an address that cant be handled, 
thus cauing the oops. I am having trouble figuring out why 
pci_drv->id_table isnt valid in this case.

Any ideas?

Thanks,
Shawn Anderson
