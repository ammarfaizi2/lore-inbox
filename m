Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130272AbQLVRqO>; Fri, 22 Dec 2000 12:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130386AbQLVRqE>; Fri, 22 Dec 2000 12:46:04 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:35341 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130272AbQLVRpy>; Fri, 22 Dec 2000 12:45:54 -0500
Date: Fri, 22 Dec 2000 11:11:05 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Pauline Middelink <middelin@polyware.nl>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Cc: jmerkey@timpanogas.org
Subject: Re: bigphysarea support in 2.2.19 and 2.4.0 kernels
Message-ID: <20001222111105.B14232@vger.timpanogas.org>
In-Reply-To: <20001221144247.A10273@vger.timpanogas.org> <E149DKS-0003cX-00@the-village.bc.nu> <20001221154446.A10579@vger.timpanogas.org> <20001221155339.A10676@vger.timpanogas.org> <20001222093928.A30636@polyware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001222093928.A30636@polyware.nl>; from middelink@polyware.nl on Fri, Dec 22, 2000 at 09:39:28AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 09:39:28AM +0100, Pauline Middelink wrote:
> On Thu, 21 Dec 2000 around 15:53:39 -0700, Jeff V. Merkey wrote:
> > 
> > Alan,
> > 
> > I am looking over the 2.4 bigphysarea patch, and I think I agree 
> > there needs to be a better approach.  It's a messy hack -- I agree.
> 
> Please explain further.
> Just leaving it at that is not nice. What is messy?
> The implementation? The API?
> 
> If you have a better solutions for allocating big chunks of
> physical continious memory at different stages during the
> runtime of the kernel, i would be very interesseted.
> 
> (Alan: bootmem allocation just won't do. I need that memory
> in modules which get potentially loaded/unloaded, hence a
> wrapper interface for allowing access to a bootmem allocated
> piece of memory)
> 
> And the API? That API was set a long time ago, luckely not by me :)
> Though I dont see the real problem. It allows allocation and
> freeing of chunks of memory. Period. Its all its suppose to do.
> Or do you want it rolled in kmalloc? So GFP_DMA with size>128K
> would take memory from this? That would mean a much more intrusive
> patch in very sensitive and rapidly changing parts of the kernel
> (2.2->2.4 speaking)...
> 
>     Met vriendelijke groet,
>         Pauline Middelink

Pauline,

Can we put together a patch that meets Alan's requirements and get it into 
the kernel proper.  We have taken on a project from Dolphin to merge the
high speed Dolphin SCI interconnect drivers into the kernel proper, and 
obviously, it's not possible to do so if the drivers are dependent on 
this patch.  I can send you the driver sources for the SCI cards, at 
least the portions that depend on this patch, and would appreciate
any guidance you could provide on a better way to allocate memory.

SCI allows machines to create windows of shared memory across a cluster
of nodes, and at 1 Gigabyte-per-second (Gigabyte not gigabit).  I am
putting a sockets interface into the drivers so Apache, LVS, and 
Pirahna can use these very high speed adapters for a clustered web 
server.  Our M2FS clustered file system also is being architected 
to use these cards.  

I will post the source code for the SCI cards at vger.timpanogas.org 
and if you have time, please download this code and take a look at 
how we are using the bigphysarea APIs to create these windows accros
machines.  The current NUMA support in Linux is somewhat slim, and 
I would like to use established APIs to do this if possible.

:-)

Jeff
 


> -- 
> GPG Key fingerprint = 2D5B 87A7 DDA6 0378 5DEA  BD3B 9A50 B416 E2D0 C3C2
> For more details look at my website http://www.polyware.nl/~middelink
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
