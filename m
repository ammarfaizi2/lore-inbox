Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318342AbSHPMdN>; Fri, 16 Aug 2002 08:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318344AbSHPMdN>; Fri, 16 Aug 2002 08:33:13 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:6923 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318342AbSHPMdM>; Fri, 16 Aug 2002 08:33:12 -0400
Date: Fri, 16 Aug 2002 13:36:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Christoph Hellwig <hch@lst.de>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>
Subject: Re: [PATCH] simplify b_inode usage
Message-ID: <20020816133654.A17193@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@zip.com.au>, Christoph Hellwig <hch@lst.de>,
	marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Joe Thornber <joe@fib011235813.fsnet.co.uk>
References: <20020813171024.A4365@lst.de> <3D5975B2.66B4B215@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D5975B2.66B4B215@zip.com.au>; from akpm@zip.com.au on Tue, Aug 13, 2002 at 02:10:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 02:10:10PM -0700, Andrew Morton wrote:
> Current ext3 CVS (ie: 2.4.20 candidate code) is using b_inode
> as an inode *.   Stephen has acked a proposal to stop doing that,
> but let's double check with him first.

On IRC he ACKed makeing it a bool.

> Also, Joe Thornber needs to add another pointer to struct buffer_head
> for LVM2 reasons.  If we collapse b_inode into a b_flags bit then
> Joe gets his pointer for free (bh stays at 48 bytes on ia32).

We also need to make b_size an 32 bit quantity, otherwise 64k buffers
on architectures like ia64 will get us horrible overflows.  And yes,
people use that big pages - Nathan just added an ugly workaround to XFS,
for splitting 64k pages into multiple bh, because of that exactly that
limitation.

> 
> So I'd suggest you just go ahead and do it that way.  (I had a patch
> for that but seem to have misplaced it).

As the patch is already large enough I'd be happy if Marcelo applies the
current patch, once it's in I'll move the indicator to b_flags, okay?

