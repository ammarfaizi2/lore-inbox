Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWGCMTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWGCMTL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 08:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWGCMTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 08:19:11 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:41136 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751078AbWGCMTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 08:19:10 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E05000@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>,
       Pantelis Antoniou <pantelis.antoniou@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] powerpc:Fix rheap alignment problem
Date: Mon, 3 Jul 2006 20:19:05 +0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Two problems with genalloc that I can see (for CPM programming):
> > > 1) (minor) Does not have a way to specify alignment (genalloc does it for
> you)
> > > 2) (major problerm, at least for me) Does not have a way to allocate a
> specified address in the pool.
> > >
> > > 2 is needed esp when programming MCC drivers, since a lot of the
> datastructures must be in DP RAM _and_ be in a specific spot. And if you cannot
> tell the allocator that I am using a specific address, then the allocator might
> very well give somebody else that portion of RAM. The only solution without
> a fixed allocator is to allocate ALL memory in the DP RAM and use your own
> allocator.
> > >
> >
> > Yeah, that too.
> >
> > Too bad there are no main tree drivers like that, but they do exist.
> >
> > One could conceivably hack genalloc to do that, but will end up with
> > something complex too.
> >
> > BTW, there are other uEngine based architectures with similar alignment
> > requirements.
> >
> > So in conclusion, for the in-tree drivers genalloc is sufficient as an cpm
> memory allocator.
> > For some out of tree drivers, it is not.
> 
> Sounds like a good enough justification to keep rheap for now then.

As the reason I stated in the last mail, rheap should continue being used not only for this fix-address situation but also for CPM/QE buffer descriptor management.  Rheap and genalloc are two different implementations of dynamic memory allocator, which have different suitable cases.  Both of them should be kept for different applications.
> 
> Ben.

