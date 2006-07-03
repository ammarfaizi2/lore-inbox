Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWGCGtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWGCGtf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 02:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWGCGtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 02:49:35 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:48793 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1750732AbWGCGte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 02:49:34 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E04FFF@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Pantelis Antoniou'" <pantelis.antoniou@gmail.com>,
       Rune Torgersen <runet@innovsys.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] powerpc:Fix rheap alignment problem
Date: Mon, 3 Jul 2006 14:49:26 +0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Buddy allocation is good in general, but doesn't mean it fits best in any condition.  In this case for managing DPRAM/MURAM in Freescale soc, in most case we only put buffer descriptor in DPRAM.  That means the alloc/free only occurs on initialization and unloading of the driver.  So there are not supposed to be a lot of free operations.  Buddy allocation will cause more internal fragment, in my humble opinion.  And a free-list allocation is best fit in this case.


Best Regards,
Leo
> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org] On Behalf Of
> Pantelis Antoniou
> Sent: Sunday, July 02, 2006 1:18 PM
> To: Rune Torgersen
> Cc: linuxppc-dev list; Paul Mackerras; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] powerpc:Fix rheap alignment problem
> 
> On Sunday 02 July 2006 06:54, Rune Torgersen wrote:
> > From: Pantelis Antoniou
> > Sent: Sat 7/1/2006 9:50 AM
> > >Since genalloc is the blessed linux thing it might be best to use that &
> remove
> > >rheap completely. Oh well...
> >
> > Two problems with genalloc that I can see (for CPM programming):
> > 1) (minor) Does not have a way to specify alignment (genalloc does it for
> you)
> > 2) (major problerm, at least for me) Does not have a way to allocate a specified
> address in the pool.
> >
> > 2 is needed esp when programming MCC drivers, since a lot of the datastructures
> must be in DP RAM _and_ be in a specific spot. And if you cannot tell the
> allocator that I am using a specific address, then the allocator might very
> well give somebody else that portion of RAM. The only solution without a fixed
> allocator is to allocate ALL memory in the DP RAM and use your own allocator.
> >
> 
> Yeah, that too.
> 
> Too bad there are no main tree drivers like that, but they do exist.
> 
> One could conceivably hack genalloc to do that, but will end up with
> something complex too.
> 
> BTW, there are other uEngine based architectures with similar alignment
> requirements.
> 
> So in conclusion, for the in-tree drivers genalloc is sufficient as an cpm
> memory allocator.
> For some out of tree drivers, it is not.
> 
> Pantelis
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
