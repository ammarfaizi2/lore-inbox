Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131717AbRACMw3>; Wed, 3 Jan 2001 07:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131878AbRACMwT>; Wed, 3 Jan 2001 07:52:19 -0500
Received: from zeus.kernel.org ([209.10.41.242]:20752 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131717AbRACMwP>;
	Wed, 3 Jan 2001 07:52:15 -0500
Date: Wed, 3 Jan 2001 12:16:09 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andreas Dilger <adilger@enel.ucalgary.ca>,
        Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: [RFC] ext2_new_block() behaviour
Message-ID: <20010103121609.C1290@redhat.com>
In-Reply-To: <200101030147.f031lPa21470@webber.adilger.net> <Pine.GSO.4.21.0101022216250.13824-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0101022216250.13824-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Jan 02, 2001 at 10:37:50PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 02, 2001 at 10:37:50PM -0500, Alexander Viro wrote:

> Umm... OK, the last argument is convincing. Thanks...
> 
> BTW, what was the reason behind doing preallocation for directories on
> ext2_bread() level? We both buy ourselves an oddity in directory structure
> (preallocated blocks become refered from the inode immediately and they
> are beyond i_size) and get more complicated ext2_alloc_block(). What do
> we win here?

Having preallocated blocks allocated immediately is deliberate:
directories grow slowly and remain closed most of the time, so the
normal preallocation regime of only preallocating open files and
discarding preallocation on close just doesn't work.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
