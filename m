Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSGYMmD>; Thu, 25 Jul 2002 08:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSGYMmD>; Thu, 25 Jul 2002 08:42:03 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:47634 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S293680AbSGYMmB>;
	Thu, 25 Jul 2002 08:42:01 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alexander Viro <viro@math.psu.edu>
Date: Thu, 25 Jul 2002 14:43:24 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: RE: 2.5.28 and partitions
CC: Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <1CE69F64FF@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jul 02 at 7:44, Alexander Viro wrote:
> On Wed, 24 Jul 2002, Linus Torvalds wrote:
> 
> > Note that there is one place where 64 bits is simply _too_ expensive, and
> > that's the page cache. In particular, the "index" in "struct page". We
> > want to make "struct page" _smaller_, not larger.
> > 
> > Right now that means that 16TB really is a hard limit for at least some
> > device access on a 32-bit machine with a 4kB page-size (yes, you could
> > make a filesystem that is bigger, but you very fundamentally cannot make
> > individual files larger than 16TB).
> 
> ITYM "8Tb" - indices are signed, IIRC.  OTOH, it's not 2^31 * PAGE_SIZE -
> it's 2^31 * PAGE_CACHE_SIZE, which can be bigger.
> 
> Al, still thinking that anybody who does mkfs.<whatever> on a multi-Tb
> device should seek professional help of the kind they don't give on l-k...

Don't worry. Netware (NW6) uses also 32bit for indices to page cache, 
and 4KB page cache size, but in addition to our implementation they 
(1) do not verify that file you created is smaller than 16TB, and 
(2) they have signedness bug somewhere too. So if you'll create file 
larger than 8TB, data you wrote in are silently discarded, while
file size is preserved.

I was really surprised when I updated ncpfs to access files > 4GB.
Written data were disappearing after server reboot :-(

Just my two cents.
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
