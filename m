Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVASLz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVASLz3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 06:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVASLz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 06:55:28 -0500
Received: from unthought.net ([212.97.129.88]:25052 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261697AbVASLzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 06:55:21 -0500
Date: Wed, 19 Jan 2005 12:55:19 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Kiniger <karl.kiniger@med.ge.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: raid 1 - automatic 'repair' possible?
Message-ID: <20050119115519.GY347@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Kiniger <karl.kiniger@med.ge.com>, Lars Marowsky-Bree <lmb@suse.de>,
	linux-kernel@vger.kernel.org
References: <20050118211801.GA28400@wszip-kinigka.euro.med.ge.com> <20050118214605.GY22648@marowsky-bree.de> <20050119104852.GB3087@wszip-kinigka.euro.med.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119104852.GB3087@wszip-kinigka.euro.med.ge.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 11:48:52AM +0100, Kiniger wrote:
...
> some random thoughts:
> 
> nowadays hardware sector sizes are much bigger than 512 bytes

No :)

> and
> the read error may affect some sectors +- the sector which actually
> returned the error.

That's right

> 
> to keep the handling in userspace as much as possible: 
> 
> the real problem is the long resync time. therefore it would
> be sufficient to have a concept of "defective areas" per partition
> and drive (a few of them, perhaps four or so , would be enough) 
> which will be excluded from reads/writes and some means to
> re-synchronize these "defective areas" from the good counterparts
> of the other disk. This would avoid having the whole partition being
> marked as defective.

I wonder if it's really worth it.

The original idea has some merit I think - but what you're suggesting
here is almost "bad block remapping" with transparent recovery and user
space policy agents etc. etc.

If a drive has problems reading the platter, it can usually be corrected
by overwriting the given sector (either the drive can actually overwrite
the sector in place, or it will re-allocate it with severe read
performance penalties following). But there's a reason why that sector
went bad, and you realy want to get the disk replaced.

I think the current policy of marking the disk as failed when it has
failed is sensible.

Just my 0.02 Euro

-- 

 / jakob

