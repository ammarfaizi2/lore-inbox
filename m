Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269188AbUIHWxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269188AbUIHWxm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 18:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269191AbUIHWxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 18:53:42 -0400
Received: from waste.org ([209.173.204.2]:42119 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S269188AbUIHWxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 18:53:40 -0400
Date: Wed, 8 Sep 2004 17:53:35 -0500
From: Matt Mackall <mpm@selenic.com>
To: Duncan Sands <baldrick@free.fr>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netpoll endian fixes
Message-ID: <20040908225334.GN31237@waste.org>
References: <200409080124.43530.baldrick@free.fr> <20040907235702.GC31237@waste.org> <200409081201.28261.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409081201.28261.baldrick@free.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 12:01:28PM +0200, Duncan Sands wrote:
> > It looks like it ought to be 0x45 everywhere, meaning it's currently
> > broken everywhere. But no one's complained. Unfortunately at the
> > present moment I've got one machine short of a test rig unpacked, so
> > I'm loathe to push another fix until I get some other test reports.
> 
> Hi Matt, I agree that it should be 0x45 everywhere.  After thinking a bit
> I concluded that the
> 
> #if defined(__LITTLE_ENDIAN_BITFIELD)
>         __u8    ihl:4,
>                 version:4;
> #elif defined (__BIG_ENDIAN_BITFIELD)
>         __u8    version:4,
>                 ihl:4;
> 
> in the definition of struct iphdr is to make sure that compiler uses the
> first four bits of the byte to refer to version, rather than the last four;
> and this only matters when you are accessing the nibbles via the ihl
> or version structure fields.  Thus it makes sure that if you write 0x45
> to the byte, then version will return 4 and ihl will return 5.  Presumably
> the C standard specifies how bitfield expressions should be laid out
> in the byte, and ihl:4, version:4; gives opposite results on little-endian
> and big-endian machines...
> 
> Ciao,
> 
> Duncan.

Ok, could you send an updated patch with a Signed-off-by, please?

-- 
Mathematics is the supreme nostalgia of our time.
