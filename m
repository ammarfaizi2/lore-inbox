Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262196AbTCHUVU>; Sat, 8 Mar 2003 15:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262194AbTCHUVR>; Sat, 8 Mar 2003 15:21:17 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:43020 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262187AbTCHUVM>; Sat, 8 Mar 2003 15:21:12 -0500
Date: Sat, 8 Mar 2003 20:31:46 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: akpm@digeo.com, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308203146.A32002@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, akpm@digeo.com, alan@lxorguk.ukuu.org.uk,
	greg@kroah.com, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <UTC200303082026.h28KQFN04439.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200303082026.h28KQFN04439.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Sat, Mar 08, 2003 at 09:26:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 09:26:15PM +0100, Andries.Brouwer@cwi.nl wrote:
> There is no need to do all of that. Going to 32-bit dev_t
> is trivial, not a major restructuring.

Doing it _right_ does require major restructuring. 

> However, it can be crashed from userspace, so before we do
> the three minutes editing the audit is needed.
> Look at the patch for raw.c I posted a few hours ago.
> One trivial test.

And probably one of them in at least half of the character drivers.  We need
to get rid of the artifical major/minor split completly instead of just
increasing it, leaving silly assumptions in and increasing the space consumed
by all those arrays by magnitudes.

> > If people really think they need a 32bit dev_t
> > we should just introduce it and use it only for block devices
> > and stay with the old 8+8 split for character devices.
> 
> Of course discussing the future and how the cake should
> be divided once we have it may be of interest

No, the point is that the character devices aren't ready yet for moving
away from the old 8+8 split.

