Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266123AbRGDSei>; Wed, 4 Jul 2001 14:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266126AbRGDSe2>; Wed, 4 Jul 2001 14:34:28 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:4740 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266123AbRGDSeL>; Wed, 4 Jul 2001 14:34:11 -0400
Date: Wed, 4 Jul 2001 19:34:02 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Miquel van Smoorenburg <miquels@cistron-office.nl>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: O_DIRECT! or O_DIRECT?
Message-ID: <20010704193402.A6403@redhat.com>
In-Reply-To: <E15HWsV-0000lM-00@f12.port.ru> <20010704185230.F28793@redhat.com> <9hvn61$rkb$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9hvn61$rkb$1@ncc1701.cistron.net>; from miquels@cistron-office.nl on Wed, Jul 04, 2001 at 06:27:13PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 04, 2001 at 06:27:13PM +0000, Miquel van Smoorenburg wrote:
> In article <20010704185230.F28793@redhat.com>,
> Stephen C. Tweedie <sct@redhat.com> wrote:
> >For these reasons, buffered IO is often faster than O_DIRECT for pure
> >sequential access.  The downside it its greater CPU cost and the fact
> >that it pollutes the cache (which, in turn, causes even _more_ CPU
> >overhead when the VM is forced to start reclaiming old cache data to
> >make room for new blocks.)
> 
> Any chance of something like O_SEQUENTIAL (like madvise(MADV_SEQUENTIAL))

What for?  The kernel already optimises readahead and writebehind for
sequential files.

If you want to provide specific extra hints to the kernel, then things
like O_UNCACHE might be more appropriate to instruct the kernel to
explicitly remove the cached page after IO completes (to avoid the VM
overhead of maintaining useless cache).  That would provide a definite
improvement over normal IO for large multimedia-style files or for
huge copies.  But what part of the normal handling of sequential files
would O_SEQUENTIAL change?  Good handling of sequential files should
be the default, not an explicitly-requested feature.

Cheers, 
 Stephen
