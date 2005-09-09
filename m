Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbVIILPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbVIILPi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbVIILPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:15:38 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:6888 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030242AbVIILPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:15:37 -0400
Date: Fri, 9 Sep 2005 14:15:23 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 2/25] NTFS: Allow highmem kmalloc() in	ntfs_malloc_nofs()
 and add _nofail() version.
In-Reply-To: <1126263740.24291.16.camel@imp.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.58.0509091407220.27527@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk> 
 <Pine.LNX.4.60.0509091019290.26845@hermes-1.csi.cam.ac.uk> 
 <84144f0205090903366454da6@mail.gmail.com> <1126263740.24291.16.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005, Anton Altaparmakov wrote:
> Also note I only use the ntfs_malloc_nofs() wrapper if I have to.  If I
> know how much I am allocating or at least know that the maximum is quite
> small, I use kmalloc() directly.  It is pretty much only for the runlist
> allocations that I use the wrapper as the runlist is typically small but
> for fragmented files it can grow huge.  I have seen runlists consuming
> over 256kiB of ram, without vmalloc that would be a real problem...

So things like

	rl = ntfs_malloc_nofs(rlsize = PAGE_SIZE);

should be changed to kmalloc(), right?

			Pekka
