Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbTHZPnG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTHZPnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:43:06 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:7325 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261367AbTHZPnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:43:03 -0400
Subject: Re: vesafb mtrr setup question
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arvind Sankar <arvinds@MIT.EDU>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030825194304.GA14893@m66-080-17.mit.edu>
References: <20030825194304.GA14893@m66-080-17.mit.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061912542.20846.50.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 26 Aug 2003 16:42:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-08-25 at 20:43, Arvind Sankar wrote:
> In the first place, the power of two computation computes the largest
> power of 2 that is _smaller_ than video_size, so it looks like an
> off-by-1 bug.

Not a bug - we don't know what lives above it so we can't extend the
mtrr safely

> >         /* Try and find a power of two to add */
> >         while (temp_size && mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB, 1)==-EINVAL) {
> >                 temp_size >>= 1;
> >         }
> > }
> 
> Secondly, what's the point of requesting a smaller write-combining
> segment that won't cover all the video memory being used?

Generally we don't use all the videoram. Its a heuristic rather than
perfection. You might want to play with improvements

