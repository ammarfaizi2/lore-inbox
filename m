Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274556AbRITQQS>; Thu, 20 Sep 2001 12:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274555AbRITQQI>; Thu, 20 Sep 2001 12:16:08 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:54012 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274556AbRITQPu>; Thu, 20 Sep 2001 12:15:50 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 20 Sep 2001 10:15:44 -0600
To: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems, kupdated bugfixes
Message-ID: <20010920101544.A14526@turbolinux.com>
Mail-Followup-To: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
	Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
In-Reply-To: <391950000.1000988162@tiny> <Pine.LNX.4.30.0109202305350.19677-100000@gamma.student.ljbc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0109202305350.19677-100000@gamma.student.ljbc>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 20, 2001  23:20 +0800, Beau Kuiper wrote:
> Patch 3 doesn't improve performace much (even in theory the number of
> dirty buffers being wrongly flushed is pretty low)

Actually, it _may_ even make performance worse (hard to say).  Consider
the case where the "young" dirty buffers are in the same area of the
disk as the "old" dirty buffers.  Once you are forced to write the "old"
buffers, you pretty much get to write the new buffers for free (low seek
overhead).  They _could_ be merged in the elevator code.

Sadly, it is hard to tell whether this is possible or not, because the
code to do these things live in different places.  Maybe we could have
an "optimistic" elevator merge, which only added "young" buffers if
they merged with other old buffers.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

