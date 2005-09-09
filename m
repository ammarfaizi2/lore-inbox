Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbVIILiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbVIILiI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbVIILiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:38:08 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:19947 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030256AbVIILiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:38:07 -0400
Date: Fri, 9 Sep 2005 14:38:03 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 2/25] NTFS: Allow highmem kmalloc()	in	ntfs_malloc_nofs()
 and add _nofail() version.
In-Reply-To: <1126265138.24291.21.camel@imp.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.58.0509091426510.28121@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk> 
 <Pine.LNX.4.60.0509091019290.26845@hermes-1.csi.cam.ac.uk> 
 <84144f0205090903366454da6@mail.gmail.com>  <1126263740.24291.16.camel@imp.csi.cam.ac.uk>
  <Pine.LNX.4.58.0509091407220.27527@sbz-30.cs.Helsinki.FI>
 <1126265138.24291.21.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005, Anton Altaparmakov wrote:
> They could be but I would rather not.  What if one day I decide to
> change how ntfs_malloc_nofs() works?  Then it would be needed to
> carefully go through the whole driver looking for places where kmalloc
> is used and change those, too.
> 
> From a software design point of view you should never mix interfaces
> when accessing an object if you want clean and maintainable code.  And
> using kmalloc() sometimes and ntfs_malloc_nofs() at other times for the
> same object would violate that.
> 
> The wrapper is a static inline so I would assume gcc can optimize away
> everything when a constant size is passed in like in the example you
> point out above.

Hey, I am not worried about performance. It's just that filesystems (or 
any other subsystem for that matter) should not invent their own memory 
allocators. Perhaps should provide a generic __vmalloc_fast() if this is 
really required?

				Pekka
