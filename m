Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbULNTCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbULNTCP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 14:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbULNTCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 14:02:14 -0500
Received: from news.suse.de ([195.135.220.2]:37087 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261617AbULNTA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 14:00:59 -0500
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.10-rc2-mm4
Cc: alan@lxorguk.ukuu.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <41BF2332.mailL911D9Q6T@suse.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 14 Dec 2004 20:00:50 +0100
In-Reply-To: <41BF2332.mailL911D9Q6T@suse.de.suse.lists.linux.kernel>
Message-ID: <p7365341z8d.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andi Kleen" <ak@suse.de> writes:

[again with subject. sorry for the screwup]

Arjan van de Ven <arjan@infradead.org> writes:

[sorry for late answer]

> On Tue, 2004-11-30 at 10:32 -0800, Andrew Morton wrote:
> > "This helps mainly graphic drivers who really need a lot of memory below
> > the 4GB area.
> 
> oh.. it's a hook for the binary nvidia module.... 
> might as well call the patch that then :)

No, that's wrong. It's a new API for any driver that needs it,
which are quite a lot. Please don't assume that all word
rotates about binary drivers.

It would have helped if you had read the description fully
before flaming.

I wouldn't have done it only for some binary only driver.

Nvidia can use it and it will probably be useful for themw, but the
free DRI ATI drivers have exactly the same problems (ATI hardware has
the same problem). I plan to change them to use this new
interface. From what I gathered from various people the problem exists
in a lot more hardware. I suspect it will be used e.g. by video frame
grabber drivers and sound devices and some others.

It also has nothing directly to do with Intel chipsets and lack of
IOMMUs. The problem happens even on AMD because the IOMMU area there
is too small (often only 64-128MB because it is shared with the AGP
aperture). Together with 16MB GFP_DMA you get 96MB, which is very tiny
for today's standards.

And 96MB is just not enough for various people and requiring the users
to change obscure command line options or the BIOS to enlarge the buffer is
just not a nice interface.

The main problem we have is that windows seems to make it very
easy to allocate memory below a specific range, so a lot of hardware
assumes this works :(

There were actually plans in the beginning of the x86-64 port 
for such an additional zone, but back then we were worried
about the impact on the fragile 2.4 VM of the additional zone.
That doesn't seem to be a big issue anymore though and NUMA
has proven that the VM can cope with a lot of zones.

-Andi

P.S.: I'm surprised none of you found the main issue in the current
patch - that it makes GFP_DMA and GFP_DMA incompatible between x86-64
and IA64. I plan to address that. Also there will be followon patches
to convert some drivers and make it used by dma_alloc_coherent()

