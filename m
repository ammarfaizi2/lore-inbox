Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135901AbRDZTfq>; Thu, 26 Apr 2001 15:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135899AbRDZTff>; Thu, 26 Apr 2001 15:35:35 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:5294 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135902AbRDZTfW>;
	Thu, 26 Apr 2001 15:35:22 -0400
Date: Thu, 26 Apr 2001 15:34:00 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <20010426211557.Z819@athlon.random>
Message-ID: <Pine.GSO.4.21.0104261530370.15385-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2001, Andrea Arcangeli wrote:

> > the wait-on-buffer is not strictly necessary: it's probably there to make
> 
> maybe not but I need to check some more bit to be sure.

Same scenario, but with read-in-progress started before we do getblk(). BTW,
old writeback is harmless - we will overwrite anyway. And _that_ can happen
without direct access to device - truncate() doesn't terminate writeout of
the indirect blocks it frees (IMO it should, but that's another story).

