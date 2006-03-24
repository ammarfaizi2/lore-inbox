Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWCXAeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWCXAeE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 19:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWCXAeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 19:34:04 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:34458 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751428AbWCXAeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 19:34:01 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] swsusp: separate swap-writing/reading code
Date: Fri, 24 Mar 2006 01:32:35 +0100
User-Agent: KMail/1.9.1
Cc: ncunningham@cyclades.com, linux-kernel@vger.kernel.org, pavel@suse.cz
References: <200603231702.k2NH2OSC006774@hera.kernel.org> <200603232253.01025.rjw@sisk.pl> <20060323155850.23f69591.akpm@osdl.org>
In-Reply-To: <20060323155850.23f69591.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603240132.35662.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 00:58, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > > I guess I missed this one somehow. Using a bitmap for allocated swap is really 
> > > inefficient because the values are usually not fragmented much. Extents would 
> > > have been a far better choice.
> > 
> > I agree it probably may be improved.  Still it seems to be good enough.  Further,
> > it's more efficient than the previous solution, so I consider it as an improvement.
> > Also this code has been tested for quite some time in -mm and appears to
> > behave properly, at least we haven't got any bug reports related to it so far.
> 
> I think that temporarily allocating 1/32768th of total memory here is
> reasonable, especially as it's not all allocated in a contiguous hunk.
> 
> > Currently I'm not working on any better solution.  If you can provide any
> > patches to implement one, please submit them, but I think they'll have to be
> > tested for as long as this code, in -mm.
> 
> I was a little saddened by the open-coded approach.  I'd expect that both
> radix-trees and idr-trees could be used in this application.  Probably the
> former.  (Radix-trees should have been designed from day one to store
> `unsigned long's, not void*'s, so unless we change that, this application
> will need to use typecasts when converting between void*'s and the stored
> BITS_PER_LONG bitmaps).

Perhaps we can use radix-trees here.  Frankly, I haven't investigated this
possibility yet, because this part is not very high on my priority list for
improvements. :-)

First, I'd like to get the userland suspend out so people can benefit from the
userland interface.  Second, I think we can save much more memory if we
use bitmaps for the image metadata, but that will require a lot of work.
Then, there's the problem of the system responsiveness after resume,
and the "USB storage not available after resume" problem that I wouldn't
like to drop on the floor.  Not to mention device driver problems.

Greetings,
Rafael
