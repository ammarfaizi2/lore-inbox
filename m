Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUFDXcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUFDXcb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266110AbUFDXbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:31:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:2790 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266067AbUFDX30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:29:26 -0400
Date: Fri, 4 Jun 2004 16:29:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: linux-kernel@vger.kernel.org, perex@suse.cz
Subject: Re: [RFC] ASLA design, depth of code review and lack thereof
In-Reply-To: <20040604230819.GR12308@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0406041622480.7010@ppc970.osdl.org>
References: <20040604230819.GR12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Jun 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> 
>         case SNDRV_PCM_FORMAT_FLOAT_BE:
>         {
>                 union {
>                         float f;
>                         u_int32_t i;
>                 } u;
>                 u.f = 0.0;
> #ifdef SNDRV_LITTLE_ENDIAN
>                 return bswap_32(u.i);
> #else
>                 return u.i;
> #endif

So what I wonder about is why anybody does something like this in the 
first place?

Any IEEE format architecture will make 0.0 be all-zeroes, last I saw. In
fact, any architecture (IEEE or not) where that isn't true will have
serious problems with floating point values in bss (hint: the bss isn't
initialzed to 0.0, it's initialized to the bit pattern 0).

So what the above boils dow to is a very very strange way of writing

	return 0;

and it has absolutely _zero_ to do with "little-endian" or anything else 
for that matter.

		Linus
