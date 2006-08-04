Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161580AbWHDXfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161580AbWHDXfn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161581AbWHDXfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:35:43 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:55765
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161580AbWHDXfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:35:42 -0400
Date: Fri, 04 Aug 2006 16:35:49 -0700 (PDT)
Message-Id: <20060804.163549.106287275.davem@davemloft.net>
To: alan@lxorguk.ukuu.org.uk
Cc: esandeen@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix sun partition overflow over 1T
From: David Miller <davem@davemloft.net>
In-Reply-To: <1154710590.23655.248.camel@localhost.localdomain>
References: <44D37440.9080100@redhat.com>
	<1154710590.23655.248.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 04 Aug 2006 17:56:30 +0100

> Ar Gwe, 2006-08-04 am 11:22 -0500, ysgrifennodd Eric Sandeen:
> > Although sun partition labels aren't supposed to support > 1T, apparently
> > linux partition editors will allow up to 2T.  This can cause problems
> > in the kernel when these larger partitions are read, due to a signed
> > int container.
> > 
> > num_sectors in the sun_disklabel struct is marked as __u32 in 2.4, and 
> > as __be32 in 2.6.  However, this is assigned to a signed int in
> > sun_partition():
> > 
> >                 int num_sectors;
> > 
> >                 st_sector = be32_to_cpu(p->start_cylinder) * spc;
> >                 num_sectors = be32_to_cpu(p->num_sectors);
> > 
> > Changing num_sectors to an unsigned int avoids this problem.
> > 
> 
> > Signed-off-by: Eric Sandeen <esandeen@redhat.com>
> 
> Acked-by: Alan Cox <alan@redhat.com>

Applied, thanks a lot.
