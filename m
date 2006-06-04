Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932240AbWFDUpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWFDUpK (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 16:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWFDUpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 16:45:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:264 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932240AbWFDUpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 16:45:08 -0400
Date: Sun, 4 Jun 2006 21:44:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
        Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
        james.steward@dynamicratings.com, jgarzik@pobox.com,
        mattjreimer@gmail.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug, take 2
Message-ID: <20060604204444.GF4484@flint.arm.linux.org.uk>
Mail-Followup-To: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
	james.steward@dynamicratings.com, jgarzik@pobox.com,
	mattjreimer@gmail.com,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <1149392479501-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149392479501-git-send-email-htejun@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 12:41:19PM +0900, Tejun Heo wrote:
> Russell, can you please verify arm's flush_kernel_dcache_page()?

That should be fine from a theoretical standpoint, but I can't say much
more than that - I have _great_ difficulty in reproducing the problem
with IDE and as such I consider myself out of the game of testing for
this problem:

| Date:   Fri, 13 Jan 2006 22:02:15 +0000
| From:   Russell King <rmk+lkml@arm.linux.org.uk>
| To:     Tejun Heo <htejun@gmail.com>
| Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
|
| On Sat, Jan 14, 2006 at 12:24:16AM +0900, Tejun Heo wrote:
| > Russell, can you please test whether this fixes the bug on arm?  If
| > this fixes the bug and people agree with the approach, I'll follow up
| > with patches for yet unconverted drivers and documentation update.
|
| Unfortunately, as I previously explained, I'm not able to test this.
| The reason is that in order to reproduce the bug, you need a system
| with a VIVT write-back write-allocate cache.
|
| Unfortunately, the few systems I have which have such a cache do not
| have IDE, SCSI nor SATA (not even PCMCIA.)  I suggest contacting the
| folk who reported the bug in the first instance.

You need to approach other members of the ARM community to test these
patches.  Unfortunately I don't have a list of who has found the problem
and who is in a state to be able to reproduce it - since most members
are embedded engineers, they tend to move on to other projects quite
rapidly.

What I suggest is that we just throw _something_ which looks right into
the kernel and see what happens.  I can't see any other possible way to
proceed, _especially_ as we've had 6 months of very little progress on
this issue.

> I tried to implement flush_anon_page() too but didn't know what to do
> with anon_vma object.

I'm not sure what this is about...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
