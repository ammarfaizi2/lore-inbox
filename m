Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUBXSeS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUBXScp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:32:45 -0500
Received: from ns.suse.de ([195.135.220.2]:37091 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262395AbUBXSb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:31:59 -0500
Date: Fri, 27 Feb 2004 02:28:49 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: IOMMUs was Re: Intel vs AMD x86-64
Message-Id: <20040227022849.6d9f88ef.ak@suse.de>
In-Reply-To: <20040224101340.47341f28.davem@redhat.com>
References: <Pine.LNX.4.44.0402231625220.9708-100000@chimarrao.boston.redhat.com.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0402231335430.3005@ppc970.osdl.org.suse.lists.linux.kernel>
	<20040223134853.5947a414.davem@redhat.com.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0402231359280.3005@ppc970.osdl.org.suse.lists.linux.kernel>
	<p73r7wk607c.fsf_-_@verdi.suse.de>
	<20040224101340.47341f28.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004 10:13:40 -0800
"David S. Miller" <davem@redhat.com> wrote:

> On 24 Feb 2004 15:06:47 +0100
> Andi Kleen <ak@suse.de> wrote:
> 
> > One side effect of this is that the IOMMU TLB flush strategy is a bit
> > dumb, because it has to do config space accesses for it.
> 
> This can be costly, but if you flush the IOMMU like sparc64 does (basically
> it's similar to how KMAPs are flushed on x86), the cost gets real low because
> then you only flush the whole iommu once every time you walk the whole mapping
> table of the iommu.
> 
> I'm sure you've probably thought of this already, just mentioning it in case
> you haven't.

Arjan suggested it some time ago already. In fact I implemented it, it's in the current code.
But it caused data corruption with a few devices, in particular 3ware, so I had 
to disable it again. I didn't find a bug in the code. It worked fine with others. My theory 
was that it triggered some hardware bug that was normally masked by the frequent flushes, but 
I wasn't able to track it down without heavy equipment.

Currently it is in there, but disabled by default. Can be enabled with iommu=nofullflush.

Also the other part of the dumbness is that the flush is global, not per mapping. I guess
you don't have that problem on Sparc64.

Anyways, even with these restrictions having the GART as IOMMU is much better than
doing software bouncing.

-Andi
