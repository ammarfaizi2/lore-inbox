Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314061AbSEAVjj>; Wed, 1 May 2002 17:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314065AbSEAVji>; Wed, 1 May 2002 17:39:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15120 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314061AbSEAVjh>;
	Wed, 1 May 2002 17:39:37 -0400
Message-ID: <3CD0605D.ACC42AA2@zip.com.au>
Date: Wed, 01 May 2002 14:38:37 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Guillaume Boissiere <boissiere@attbi.com>, linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  May 1, 2002
In-Reply-To: <3CCFBB21.9046.7889B0D2@localhost> <20020501201927.GS574@matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> On Wed, May 01, 2002 at 09:53:37AM -0400, Guillaume Boissiere wrote:
> > new framebuffer layer, as well as some more delayed disk block
> > allocation bits.
> 
> Actually Andrews work on address_space based writeback is related somewhat,
> but really it's a rewrite/cleanup of the buffer layer.  Delayed block
> alocation is helped alot by this, and almost depends on it IIRC.
> 
> One vote for a seperate listing in the status for "Address Space based
> Writeback / Buffer layer cleanup".

Well the next major step here is going direct
pagecache<->BIO, bypassing the intermediate submit_bh
for most I/O.

Probably that will make most of the performance benefits
of delayed-allocate go away.

There are other reasons for implementing delalloc
(XFS, improved layout, ...).  So it ain't dead yet.


At 48 bytes, 2.5's buffer_head is now precisely half the
size of 2.4's.  I'm hoping to be able to shed another eight
bytes yet.

With the pagecache<->BIO change, the buffer_head will most
definitely become "per-page metadata which describes the state
of sub-page segments" and not "something which is used for
performing I/O".



-
