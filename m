Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269351AbRHGTU7>; Tue, 7 Aug 2001 15:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269353AbRHGTUt>; Tue, 7 Aug 2001 15:20:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:16879 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269351AbRHGTUm>;
	Tue, 7 Aug 2001 15:20:42 -0400
Date: Tue, 7 Aug 2001 15:20:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <200108071909.f77J9Pr07385@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0108071516520.18565-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Aug 2001, Richard Gooch wrote:

> Yes, I use libc5. And I don't care about old pwd being slower. And I

So fix getcwd(3) in libc5. BFD... Or use your ->dentry in devfs_readdir() -
then you can get the consistency you want for existing inodes and that
will allow b0rken getcwd() to work.

It _is_ b0rken - it relies on unique 32-bit number for inodes. That's
not guaranteed on NFS and there's nothing we could do about that.

