Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVAPWgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVAPWgv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 17:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVAPWgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 17:36:51 -0500
Received: from ns.suse.de ([195.135.220.2]:18834 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262628AbVAPWgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 17:36:38 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: Andi Kleen <ak@muc.de>
Subject: Re: [RFC] Ext3 nanosecond timestamps in big inodes
Date: Sat, 15 Jan 2005 15:41:14 +0100
User-Agent: KMail/1.7.1
Cc: Alex Tomas <alex@clusterfs.com>, Andrew Tridgell <tridge@samba.org>,
       linux-kernel@vger.kernel.org
References: <200501142216.12726.agruen@suse.de> <m1acravvjl.fsf@muc.de>
In-Reply-To: <m1acravvjl.fsf@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501151541.14337.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 January 2005 05:37, Andi Kleen wrote:
> Andreas Gruenbacher <agruen@suse.de> writes:
> > this is a spin-off of an old patch by Alex Tomas <alex@clusterfs.com>:
> > Alex originally had nanosecond timestamps in his original patch; here is
> > a rejuvenated version. Please tell me what you think. Alex also added a
> > create timestamp in his original patch. Do we actually need that?
> >
> > Nanoseconds consume 30 bits in the 32-bit fields. The remaining two bits
> > currently are zeroed out implicitly. We could later use them remaining
> > two bits for years beyond 2038.
>
> Looks good. Just two suggestions:
>
> - Provide an mount option to turn it off because there may be
> performance regressions in some workload because inodes will be
> flushed more often.
> [I actually considered doing this generally at the VFS level
> when doing the s_time_gran patch, but it needed some more changes
> that I didn't want to do at that time. Doing it in the FS as
> interim solution would be fine too]

I think I agree, also with doing it at the VFS layer. We must make sure that 
eventually the most recent timestamp makes it to disk (unless the machine 
crashes, in which case slightly out-of-date timestamps probably can be 
tolerated).

> - Use the 2 bits for additionals years right now on 64bit
> hosts. No need to keep the y2038 issue around longer than necessary.

Yes. Actually zeroing out the upper two bits is wrong for timestamps before 
the epoch if we use plain two's complement representation. The two bits give 
us an extended range of about [1697 .. 2242] instead of [1901 .. 2038].

-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
