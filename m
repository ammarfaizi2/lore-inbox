Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129944AbQLVUB1>; Fri, 22 Dec 2000 15:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132237AbQLVUBR>; Fri, 22 Dec 2000 15:01:17 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:64004 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129944AbQLVUBA>; Fri, 22 Dec 2000 15:01:00 -0500
Date: Fri, 22 Dec 2000 13:25:41 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Andi Kleen <ak@suse.de>
Cc: Pauline Middelink <middelin@polyware.nl>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: bigphysarea support in 2.2.19 and 2.4.0 kernels
Message-ID: <20001222132541.A1555@vger.timpanogas.org>
In-Reply-To: <20001221144247.A10273@vger.timpanogas.org> <E149DKS-0003cX-00@the-village.bc.nu> <20001221154446.A10579@vger.timpanogas.org> <20001221155339.A10676@vger.timpanogas.org> <20001222093928.A30636@polyware.nl> <20001222111105.B14232@vger.timpanogas.org> <20001222113530.A14479@vger.timpanogas.org> <20001222202137.A27844@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001222202137.A27844@gruyere.muc.suse.de>; from ak@suse.de on Fri, Dec 22, 2000 at 08:21:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 08:21:37PM +0100, Andi Kleen wrote:
> On Fri, Dec 22, 2000 at 11:35:30AM -0700, Jeff V. Merkey wrote:
> > The real question is how to guarantee that these pages will be contiguous
> > in memory.  The slab allocator may also work, but I think there are size
> > constraints on how much I can get in one pass.
> 
> You cannot guarantee it after the system has left bootup stage. That's the
> whole reason why bigphysarea exists.
> 
> -Andi

I am wondering why the drivers need such a big contiguous chunk of memory.
For message passing operatings, they should not.  Some of 
the user space libraries appear to need this support.  I am going through 
this code today attempting to determine if there's a way to reduce this 
requirement or map the memory differently.   I am not using these cards
for a ccNUMA implementation, although they have versions of these 
adapters that can provide this capability, but for message passing with 
small windows of coherence between machines with push/pull DMA-style
behavior for high speed data transfers.  99.9% of the clustering 
stuff on Linux uses this model, so this requirement perhaps can be
restructured to be a better fit for Linux.

Just having the patch in the kernel for bigphysarea support would solve
this issue if it could be structured into a form Alan finds acceptable.
Absent this, we need a workaround that's more tailored for the 
requirments for Linux apps.

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
