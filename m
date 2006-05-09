Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWEITKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWEITKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWEITKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:10:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2750 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751220AbWEITKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:10:35 -0400
Date: Tue, 9 May 2006 12:13:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: pbadari@us.ibm.com, linux-kernel@vger.kernel.org, hch@lst.de,
       bcrl@kvack.org, cel@citi.umich.edu
Subject: Re: [PATCH 1/3] Vectorize aio_read/aio_write methods
Message-Id: <20060509121305.0840e770.akpm@osdl.org>
In-Reply-To: <20060509190310.GA19124@lst.de>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	<1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	<1147198025.28388.0.camel@dyn9047017100.beaverton.ibm.com>
	<20060509120105.7255e265.akpm@osdl.org>
	<20060509190310.GA19124@lst.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, May 09, 2006 at 12:01:05PM -0700, Andrew Morton wrote:
> > Together these three patches shrink the kernel by 113 lines.  I don't know
> > what the effect is on text size, but that's a pretty modest saving, at a
> > pretty high risk level.
> > 
> > What else do we get in return for this risk?
> 
> there's another patch ontop which I didn't bother to redo until this is
> accepted which kills a lot more code.  After that filesystems only have
> to implement one method each for all kinds of read/write calls.  Which
> allows to both make the mm/filemap.c far less complex and actually
> understandable aswell as for any filesystem that uses more complex
> read/write variants than direct filemap.c calls.  In addition to these
> simplification we also get a feature (async vectored I/O) for free.

Fair enough, thanks.  Simplifying filemap.c would be a win.

I'll crunch on these three patches in the normal fashion.  It'll be good if
we can get the followup patch done within the next week or two so we can
get it all tested at the same time.  Although from your description it
doesn't sound like it'll be completely trivial...
