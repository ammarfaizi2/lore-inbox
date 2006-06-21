Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWFUVBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWFUVBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWFUVBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:01:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15791 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030297AbWFUVBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:01:34 -0400
Date: Wed, 21 Jun 2006 14:01:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <gregkh@suse.de>
Cc: vgoyal@in.ibm.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64bit resources start end value fix
Message-Id: <20060621140125.c27bc99e.akpm@osdl.org>
In-Reply-To: <20060621204414.GA30766@suse.de>
References: <20060621172903.GC9423@in.ibm.com>
	<20060621132227.ec401f93.akpm@osdl.org>
	<20060621204120.GA14739@in.ibm.com>
	<20060621204414.GA30766@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 13:44:15 -0700
Greg KH <gregkh@suse.de> wrote:

> > > Confused.  This patch won't apply.  It will apply with `patch -R', and if
> > > you do that you'll break iomem_reosurce.end by setting it to
> > > 0x00000000ffffffff.
> > > 
> > > I don't think any additional changes are needed here.
> > 
> > Andrew, you don't have to apply this patch. It is supposed to be picked
> > by Greg.
> > 
> > There seems to be some confusion. Just few days back Greg consolidated
> > and re-organized all the 64bit resources patches and posted on LKML for
> > review.
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=115015916118671&w=2
> > 
> > There were few review comments regarding kconfig options.
> > I reworked the patch and CONFING_RESOURCES_32BIT was changed to
> > CONFIG_RESOURCES_64BIT.
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=115072559700302&w=2
> > 
> > Now Greg's tree and your tree are not exact replica when it comes to 
> > 64bit resource patches. Hence this patch is supposed to be picked by 
> > Greg to make sure things are not broken in his tree.
> 
> It still breaks things as Andrew pointed out.  .end should not be set to
> -1.

No, -1 is OK.

As it turns out,

	unsigned long long x = ~0UL;

sets `x' to 0xffffffffffffffff which was totally not what I expected.

But -1 works, and the patch I have against your tree is OK.

Could someone please fix Andy Isaacson <adi@hexapodia.org>'s bug, btw?
