Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268305AbRHAVWf>; Wed, 1 Aug 2001 17:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268280AbRHAVWR>; Wed, 1 Aug 2001 17:22:17 -0400
Received: from ns.caldera.de ([212.34.180.1]:7112 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S268305AbRHAVVI>;
	Wed, 1 Aug 2001 17:21:08 -0400
Date: Wed, 1 Aug 2001 23:18:55 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, hch@caldera.de, torvalds@transmeta.com,
        viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vxfs fix
Message-ID: <20010801231855.A16333@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
	torvalds@transmeta.com, viro@math.psu.edu,
	linux-kernel@vger.kernel.org
In-Reply-To: <200108012103.VAA93890@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108012103.VAA93890@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Wed, Aug 01, 2001 at 09:03:20PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2001 at 09:03:20PM +0000, Andries.Brouwer@cwi.nl wrote:
> Dear Linus, Alan, Al, Christoph, all,
> 
> If one mounts without specifying a type, mount will try
> all available types. After having tried vxfs the next type
> will cause
> 	set_blocksize: b_count 1 ...
> since vxfs forgets to free a block.
> The patch below adds the missing brelse().
> (In fact there are more resources that are never freed there -
> maybe the maintainer can have a look some time -
> I only added a comment.)

Yes, I already hit that one time but forgot to fix it.
I'll update vxfs to free all resources somewhen later this week.

Thanks for the catch!

> When mount continues to try all types, it may try V7.
> That always succeeds, there is no test for magic or so,
> and after garbage has been mounted as a V7 filesystem,
> the kernel crashes or hangs or fails in other sad ways.
> Have not tried to debug.

Maybe some sanity checks should be added?

I'd like to propose:

	s_nfree <= V7_NICFREE
	s_ninode <= V7_NICINOD
	s_time != 0

Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
