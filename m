Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVKNAve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVKNAve (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 19:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVKNAve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 19:51:34 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:31380 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1750817AbVKNAve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 19:51:34 -0500
Subject: Re: [PATCH] Allow flatmem to be disabled when only sparsemem is
	implemented
From: Magnus Damm <magnus@valinux.co.jp>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Anton Blanchard <anton@samba.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <4374F3EB.6040103@shadowen.org>
References: <20051111160341.GK14770@krispykreme>
	 <4374DA3D.6050704@shadowen.org>  <4374F3EB.6040103@shadowen.org>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 09:53:06 +0900
Message-Id: <1131929586.8595.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-11 at 19:41 +0000, Andy Whitcroft wrote:
> Andy Whitcroft wrote:
> > Anton Blanchard wrote:
> > 
> >>On architectures that implement sparsemem but not discontigmem we want
> >>to be able to hide the flatmem option in some cases. On ppc64 for
> >>example, when we select NUMA we must not select flatmem.
> > 
> > First reaction is that this is very reasonable.  I can see why you need
> > to do this as you don't have DISCONTIGMEM.  I will just go check the
> > major architectures and make sure they arn't relying on being able to
> > enable SPARSEMEM and getting FLATMEM too behaviour.  I don't think they
> > can be as they all have DISCONTIGMEM and so should be insulated.
> 
> Ok.  I've reviewed the usage of the memory model selectors in the
> architectures in 2.6.14-mm2.  It appears that only i386 is affected by
> this change, the others that use the selector have explicit enablement
> of FLATMEM.  This patch will interact badly with the current code to
> enable SPARSEMEM on non-numa systems.  However, this code is under
> review at this moment, and the proposed replacement (Message-ID:
> <4370BC30.40100@shadowen.org>) is compatible with this change.
> 
> In short as long as they go in together this change looks good.
> 
> Magnus, any feedback on the replacement SPARSEMEM enabler on non-NUMA
> i386 systems??

I tested your patch in QEMU on top of 2.6.15-rc1-git1 and it seems to
work well. Many thanks!

/ magnus

