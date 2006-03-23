Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422734AbWCWX4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422734AbWCWX4r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 18:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422735AbWCWX4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 18:56:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61849 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422734AbWCWX4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 18:56:46 -0500
Date: Thu, 23 Mar 2006 15:58:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ncunningham@cyclades.com, linux-kernel@vger.kernel.org, pavel@suse.cz
Subject: Re: [PATCH] swsusp: separate swap-writing/reading code
Message-Id: <20060323155850.23f69591.akpm@osdl.org>
In-Reply-To: <200603232253.01025.rjw@sisk.pl>
References: <200603231702.k2NH2OSC006774@hera.kernel.org>
	<200603240713.41566.ncunningham@cyclades.com>
	<200603232253.01025.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> > I guess I missed this one somehow. Using a bitmap for allocated swap is really 
> > inefficient because the values are usually not fragmented much. Extents would 
> > have been a far better choice.
> 
> I agree it probably may be improved.  Still it seems to be good enough.  Further,
> it's more efficient than the previous solution, so I consider it as an improvement.
> Also this code has been tested for quite some time in -mm and appears to
> behave properly, at least we haven't got any bug reports related to it so far.

I think that temporarily allocating 1/32768th of total memory here is
reasonable, especially as it's not all allocated in a contiguous hunk.

> Currently I'm not working on any better solution.  If you can provide any
> patches to implement one, please submit them, but I think they'll have to be
> tested for as long as this code, in -mm.

I was a little saddened by the open-coded approach.  I'd expect that both
radix-trees and idr-trees could be used in this application.  Probably the
former.  (Radix-trees should have been designed from day one to store
`unsigned long's, not void*'s, so unless we change that, this application
will need to use typecasts when converting between void*'s and the stored
BITS_PER_LONG bitmaps).

