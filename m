Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVAQRL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVAQRL4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVAQRL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:11:56 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:46341 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261489AbVAQRLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:11:18 -0500
Date: Mon, 17 Jan 2005 18:19:40 +0100
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, covici@ccs.covici.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
Message-ID: <20050117171940.GA14407@hh.idb.hist.no>
References: <41E64DAB.1010808@hist.no> <16870.21720.866418.326325@ccs.covici.com> <21d7e997050113130659da39c9@mail.gmail.com> <20050115185712.GA17372@hh.idb.hist.no> <21d7e997050116020859687c4a@mail.gmail.com> <20050116105011.GA5882@hh.idb.hist.no> <9e4733910501160304642f7882@mail.gmail.com> <20050116121823.GA7734@hh.idb.hist.no> <9e4733910501161408710bbbe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910501161408710bbbe2@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 05:08:12PM -0500, Jon Smirl wrote:
> On Sun, 16 Jan 2005 13:18:23 +0100, Helge Hafting
> <helgehaf@aitel.hist.no> wrote:
> > On Sun, Jan 16, 2005 at 06:04:32AM -0500, Jon Smirl wrote:
> > > you need to check the output from "modprobe drm debug=1" "modprobe
> > > radeon" and see if drm is misidentifying the board as AGP. We don't
> > > want to fix something if it isn't broken.
> > > 
> > Stupid question - how do I get a modular drm?
> 
> For older radeon drivers "modprobe radeon debug=1" should work. I also
> think you can do it for compiled in ones by adding the kernel
> parameter radeon.debug=1
> 
I tried 2.6.11rc1, which has modular drm (and also the crash I'm
struggling with.)

# modprobe drm debug=1
# modprobe radeon
I got this in dmesg (some of it also on the console):
[drm] Initialized drm 1.0.0 20040925
[drm:drm_init] 
[drm:drm_probe] 
[drm:drm_probe] assigning minor 0
PCI: Enabling device 0000:00:08.0 (0000 -> 0003)
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 19 (level, low) -> IRQ 19
[drm:drm_ctxbitmap_next] drm_ctxbitmap_next bit : 0
[drm:drm_ctxbitmap_init] drm_ctxbitmap_init : 0
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc 
RV280 [Radeon 9200 SE]
[drm:drm_probe] new minor assigned 0


I guess it was detected as pci, due to the "PCI: Enabling device..." message.
At least there is no mention of AGP here.

I tried to run X on the radeon after this, and it locked up solid as usual.
I hope this helps.  I can try other kernels, but I hope a binary
search will be a last resort. (I will try that if absolutely necessary, 
but it will take time.  I can't reboot all the time.)

Helge Hafting
