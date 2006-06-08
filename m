Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWFHFpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWFHFpI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 01:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWFHFpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 01:45:08 -0400
Received: from cantor2.suse.de ([195.135.220.15]:34521 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932523AbWFHFpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 01:45:05 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] use unlikely() for current_kernel_time() loop
Date: Thu, 8 Jun 2006 07:39:33 +0200
User-Agent: KMail/1.9.3
Cc: adilger@clusterfs.com, linux-kernel@vger.kernel.org
References: <20060607173642.GA6378@schatzie.adilger.int> <p73ejy0tm83.fsf@verdi.suse.de> <20060607220118.f0c64086.akpm@osdl.org>
In-Reply-To: <20060607220118.f0c64086.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606080739.33967.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 07:01, Andrew Morton wrote:
> On 08 Jun 2006 04:28:12 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> > Andreas Dilger <adilger@clusterfs.com> writes:
> > 
> > > Hello,
> > > I just noticed this minor optimization.  current_kernel_time() is called
> > > from current_fs_time() so it is used fairly often but it doesn't use
> > > unlikely(read_seqretry(&xtime_lock, seq)) as other users of xtime_lock do.
> > > Also removes extra whitespace on the empty line above.
> > 
> > It would be better to put the unlikely into the read_seqretry I guess.
> > 
> 
> yup.  But it'd be good to check that this actually causes the compiler to
> do the right thing, rather than simply ignoring it.

If it was put into a macro wrapper it should be safe enough.

> 
> I'm not sure how one would do that though.  I guess compare
> before-and-after assembly code, work out if "after" is better.

Nothing on x86-64 at least - it uses -fno-reorder-blocks by default.

-Andi

