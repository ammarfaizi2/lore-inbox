Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131823AbQLVUV5>; Fri, 22 Dec 2000 15:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131614AbQLVUVr>; Fri, 22 Dec 2000 15:21:47 -0500
Received: from nathan.polyware.nl ([193.67.144.241]:15631 "EHLO
	nathan.polyware.nl") by vger.kernel.org with ESMTP
	id <S131823AbQLVUVd>; Fri, 22 Dec 2000 15:21:33 -0500
Date: Fri, 22 Dec 2000 20:51:03 +0100
From: Pauline Middelink <middelink@polyware.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: bigphysarea support in 2.2.19 and 2.4.0 kernels
Message-ID: <20001222205103.A9441@polyware.nl>
Mail-Followup-To: Pauline Middelink <middelin@polyware.nl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001221144247.A10273@vger.timpanogas.org> <E149DKS-0003cX-00@the-village.bc.nu> <20001221154446.A10579@vger.timpanogas.org> <20001221155339.A10676@vger.timpanogas.org> <20001222093928.A30636@polyware.nl> <20001222111105.B14232@vger.timpanogas.org> <20001222113530.A14479@vger.timpanogas.org> <20001222202137.A27844@gruyere.muc.suse.de> <20001222132541.A1555@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001222132541.A1555@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Fri, Dec 22, 2000 at 01:25:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2000 around 13:25:41 -0700, Jeff V. Merkey wrote:
> On Fri, Dec 22, 2000 at 08:21:37PM +0100, Andi Kleen wrote:
> > On Fri, Dec 22, 2000 at 11:35:30AM -0700, Jeff V. Merkey wrote:
> > > The real question is how to guarantee that these pages will be contiguous
> > > in memory.  The slab allocator may also work, but I think there are size
> > > constraints on how much I can get in one pass.
> > 
> > You cannot guarantee it after the system has left bootup stage. That's the
> > whole reason why bigphysarea exists.
> > 
> > -Andi
> 
> I am wondering why the drivers need such a big contiguous chunk of memory.
> For message passing operatings, they should not.  Some of 
> the user space libraries appear to need this support.  I am going through 
> this code today attempting to determine if there's a way to reduce this 
> requirement or map the memory differently.   I am not using these cards
> for a ccNUMA implementation, although they have versions of these 
> adapters that can provide this capability, but for message passing with 
> small windows of coherence between machines with push/pull DMA-style
> behavior for high speed data transfers.  99.9% of the clustering 
> stuff on Linux uses this model, so this requirement perhaps can be
> restructured to be a better fit for Linux.

Well, to be frank, I'm only aware of my zoran driver (and the buz?)
needing it. The only reason is that the ZR36120 framegrabber wants
to load a complete field from a single DMA-base address. Needless
to say TV frames are large in RGB24 mode, and going fast at that.
So its just a deficiancy of the chip which made me use bigphys.

And yes, I tried a version (which is in the kernel) which must be compiled
in, so it can find a large enough area to work with. The only problem is
when the driver has a problem, one can not easily reload the module
(but who am i telling, right? :) )

> Just having the patch in the kernel for bigphysarea support would solve
> this issue if it could be structured into a form Alan finds acceptable.
> Absent this, we need a workaround that's more tailored for the 
> requirments for Linux apps.

Is there a solution than? As long as the hardware which needs it is
not common good, Linus will oppose it (at least that's what I figured
from his messages back in the old days.) Oh well, maybe his opinion
has changed, one may hope :)

    Met vriendelijke groet,
        Pauline Middelink
-- 
GPG Key fingerprint = 2D5B 87A7 DDA6 0378 5DEA  BD3B 9A50 B416 E2D0 C3C2
For more details look at my website http://www.polyware.nl/~middelink
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
