Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTERVNt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 17:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbTERVNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 17:13:49 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:45319 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262202AbTERVNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 17:13:48 -0400
Subject: Re: [Linux-ia64] Re: [patch] support 64 bit pci_alloc_consistent
From: James Bottomley <James.Bottomley@steeleye.com>
To: Grant Grundler <iod00d@hp.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, "David S. Miller" <davem@redhat.com>,
       Jes Sorensen <jes@wildopensource.com>, torvalds@transmeta.com,
       cngam@sgi.com, jeremy@sgi.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ia64@linuxia64.org,
       wildos@sgi.com
In-Reply-To: <20030518201718.GB13855@cup.hp.com>
References: <16071.1892.811622.257847@trained-monkey.org>
	<1053250142.1300.8.camel@laptop.fenrus.com>
	<20030518.023533.98888328.davem@redhat.com>
	<20030518094341.A1709@devserv.devel.redhat.com>
	<20030518172203.GA13855@cup.hp.com> <1053280195.10810.61.camel@mulgrave> 
	<20030518201718.GB13855@cup.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 May 2003 16:26:22 -0500
Message-Id: <1053293187.10811.70.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-18 at 15:17, Grant Grundler wrote:
> On Sun, May 18, 2003 at 12:49:49PM -0500, James Bottomley wrote:
> > In that case, the platform returns zero to "this much" being less than
> > the full 64 bits implying there's no mask the platform and driver can
> > agree on.
> 
> My point was it's better if the driver always check the return
> value regardless of which interface is ultimately agreed upon.
> (in reference to whether "no one cares a flying fish".)
> 
> If one accepts that requirement, the only improvement in Arjen's proposal
> is the platform DMA support can guess what might be better and make that
> the "effective" mask.  The driver still needs to check the effective mask.
> I happen to agree with davem : redefining this interface in 2.5 for
> a trivial improvement doesn't seem reasonable at this point.

Yes and no.  A full bit u64 mask should never fail, so the *majority* of
drivers will just set the full mask and see what they get back, not
expecting a zero.  Any driver setting less than the full mask would have
to check the return.  That would be better for most drivers (also, the
if 64 bit mask else if 32 bit mask else error would be removed).

I agree its not a 2.5 must have.  However, it is easy enough to thread
into the dma_ interface (and that has currently few enough implementing
platforms and driver users to make such a change small and fairly easy).

Also, knowing the effective mask (and it would have to be set properly
on return) would be extremely useful for drivers that have weird width
modes (like aic with 64 vs 39 vs 32 bit addressing in the
descriptors)...it would allow me to eliminate the memory size checks in
those drivers.

James


