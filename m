Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318376AbSHPOIV>; Fri, 16 Aug 2002 10:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318383AbSHPOIV>; Fri, 16 Aug 2002 10:08:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37644 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318376AbSHPOIU>;
	Fri, 16 Aug 2002 10:08:20 -0400
Message-ID: <3D5D0AB8.1A343AE@zip.com.au>
Date: Fri, 16 Aug 2002 07:22:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Christoph Hellwig <hch@lst.de>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>
Subject: Re: [PATCH] simplify b_inode usage
References: <20020813171024.A4365@lst.de> <3D5975B2.66B4B215@zip.com.au> <20020816133654.A17193@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> ...
> > Also, Joe Thornber needs to add another pointer to struct buffer_head
> > for LVM2 reasons.  If we collapse b_inode into a b_flags bit then
> > Joe gets his pointer for free (bh stays at 48 bytes on ia32).
> 
> We also need to make b_size an 32 bit quantity, otherwise 64k buffers
> on architectures like ia64 will get us horrible overflows.  And yes,
> people use that big pages - Nathan just added an ugly workaround to XFS,
> for splitting 64k pages into multiple bh, because of that exactly that
> limitation.

OK.  We'd need to prevent that from taking bh beyond the current 96 bytes.
The hashed wakeups, perhaps.

> >
> > So I'd suggest you just go ahead and do it that way.  (I had a patch
> > for that but seem to have misplaced it).
> 
> As the patch is already large enough I'd be happy if Marcelo applies the
> current patch, once it's in I'll move the indicator to b_flags, okay?

Yup.
