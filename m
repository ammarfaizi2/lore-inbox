Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277321AbRJEGhN>; Fri, 5 Oct 2001 02:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277322AbRJEGhE>; Fri, 5 Oct 2001 02:37:04 -0400
Received: from femail20.sdc1.sfba.home.com ([24.0.95.129]:45716 "EHLO
	femail20.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S277321AbRJEGg4>; Fri, 5 Oct 2001 02:36:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Whining about NUMA. :)  [Was whining about 2.5...]
Date: Thu, 4 Oct 2001 19:59:00 -0400
X-Mailer: KMail [version 1.2]
Cc: riel@conectiva.com.br (Rik van Riel), linux-kernel@vger.kernel.org
In-Reply-To: <E15pFUQ-00045y-00@the-village.bc.nu>
In-Reply-To: <E15pFUQ-00045y-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01100419590005.02393@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 October 2001 16:53, Alan Cox wrote:
> > Is there really a NUMA machine out there where you can DMA out of another
> > node's 16 bit ISA space?  So far the differences in the zones seem to be
>
> DMA engines are tied to the node the device is tied to not to the processor
> in question in most NUMA systems.

Oh good.  I'd sort of guessed that part, but wasn't quite sure.  (I've seen 
hardware people do some amazingly odd things before.  Luckily not recently, 
though...)

So would a workable (if naieve) attempt to use Andrea's 
memory-zones-grouped-into-classes approach on NUMA just involve making a 
class/zone list for each node?  (Okay, you've got to identify nodes, and 
group together processors, bridges, DMAable devices, etc, but it seems like 
that has to be done anyway, class/zone or not.)  How does what people want to 
do for NUMA improve on that?

Is a major goal of NUMA figuring out how to borrow resources from adjacent 
nodes (and less-adjacent nodes) in a "second choice, third choice, twelfth 
choice" kind of way?  Or is a "this resource set is local to this node, and 
allocating beyond this group is some variant of swapping behavior" approach 
an acceptable first approximation?

If class/zone is so evil for NUMA, what's the alternative that's being 
considered?  (Pointer to paper?)

I'm wondering how the class/zone approach is more evil than the alternative 
of having lots and lots of little zones which have different properties for 
each processor and DMAable device on the system, and then trying to figure 
out what to do from there at allocation time or during each attempt to 
inflict I/O upon buffers.

Rob

P.S.  Rik pointed out in email (replying to my "master of stupid questions" 
signoff) that I am indeed confused about a great many things, but didn't 
elaborate.  Of course I agree with this, but I do try to make it up on volume 
:).
