Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129322AbRBAMVt>; Thu, 1 Feb 2001 07:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbRBAMVi>; Thu, 1 Feb 2001 07:21:38 -0500
Received: from zeus.kernel.org ([209.10.41.242]:45791 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129322AbRBAMVZ>;
	Thu, 1 Feb 2001 07:21:25 -0500
Date: Thu, 1 Feb 2001 12:19:07 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: bsuparna@in.ibm.com
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010201121907.M11607@redhat.com>
In-Reply-To: <CA2569E6.001B9D72.00@d73mta03.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <CA2569E6.001B9D72.00@d73mta03.au.ibm.com>; from bsuparna@in.ibm.com on Thu, Feb 01, 2001 at 10:25:22AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 01, 2001 at 10:25:22AM +0530, bsuparna@in.ibm.com wrote:
> 
> >We _do_ need the ability to stack completion events, but as far as the
> >kiobuf work goes, my current thoughts are to do that by stacking
> >lightweight "clone" kiobufs.
> 
> Would that work with stackable filesystems ?

Only if the filesystems were using VFS interfaces which used kiobufs.
Right now, the only filesystem using kiobufs is XFS, and it only
passes them down to the block device layer, not to other filesystems.

> Being able to track the children of a kiobuf would help with I/O
> cancellation (e.g. to pull sub-ios off their request queues if I/O
> cancellation for the parent kiobuf was issued). Not essential, I guess, in
> general, but useful in some situations.

What exactly is the justification for IO cancellation?  It really
upsets the normal flow of control through the IO stack to have
voluntary cancellation semantics.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
