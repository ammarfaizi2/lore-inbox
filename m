Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265986AbUHFOtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265986AbUHFOtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268074AbUHFOtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:49:16 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:27595 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S265986AbUHFOtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:49:10 -0400
From: Daniel Phillips <phillips@arcor.de>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: block layer sg, bsg
Date: Fri, 6 Aug 2004 03:03:40 -0400
User-Agent: KMail/1.6.2
Cc: yoshfuji@linux-ipv6.org, ak@muc.de, jgarzik@pobox.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
References: <20040804191850.GA19224@havoc.gtf.org> <20040804.165113.06226042.yoshfuji@linux-ipv6.org> <20040804205837.6fda9a50.davem@redhat.com>
In-Reply-To: <20040804205837.6fda9a50.davem@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408060303.40261.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Wednesday 04 August 2004 23:58, David S. Miller wrote:
> On Wed, 04 Aug 2004 16:51:13 -0700 (PDT)
>
> YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:
> > > Well, 32bit ipsec on x86-64/ia64 is a NOP because of that.
> >
> > Hmm, I don't get the point.
> > What part (or which structore) is broken?
>
> On x86-64 and ia64 they have a large issue because the ia32
> emulation layer has to handle the fact that "long long" types
> do not require 8-byte alignment, whereas 64-bit natively
> they do.

I'm making heavy use of struct read/writes in the cluster snapshot block 
device, so I need to get this sorted out.

Somewhere I got the idea that if a structure is declared with attribute 
PACKED, gcc will generate alignment-independent code (e.g., access each field 
byte by byte) on alignment-restricted architectures.  So if what I imagine 
about gcc is true, what issues remain?  These structs have to be declared 
packed anyway and with fixed field sizes, or the layout will vary across 
architectures.

Regards,

Daniel
