Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271676AbRICK5Q>; Mon, 3 Sep 2001 06:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271677AbRICK5F>; Mon, 3 Sep 2001 06:57:05 -0400
Received: from smtp8.xs4all.nl ([194.109.127.134]:14784 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S271676AbRICK4y>;
	Mon, 3 Sep 2001 06:56:54 -0400
From: thunder7@xs4all.nl
Date: Mon, 3 Sep 2001 12:52:18 +0200
To: Matthew Wilcox <willy@debian.org>
Cc: parisc-linux@lists.parisc-linux.org, linux-kernel@vger.kernel.org
Subject: Re: documented Oops running big-endian reiserfs on parisc architecture
Message-ID: <20010903125218.A3192@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <20010902105538.A15344@middle.of.nowhere> <20010902150023.U5126@parcelfarce.linux.theplanet.co.uk> <20010902.160441.92583890.davem@redhat.com> <20010903002514.X5126@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010903002514.X5126@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 12:25:14AM +0100, Matthew Wilcox wrote:
> On Sun, Sep 02, 2001 at 04:04:41PM -0700, David S. Miller wrote:
> >    From: Matthew Wilcox <willy@debian.org>
> >    Date: Sun, 2 Sep 2001 15:00:23 +0100
> > 
> >    On Sun, Sep 02, 2001 at 10:55:38AM +0200, thunder7@xs4all.nl wrote:
> >    > ReiserFS version 3.6.25
> >    > bonnie[163]: Unaligned data reference 28
> >    
> >    As it says, an unaligned data reference.
> >    
> > BTW, you should not be OOPSing on this as unaligned references are
> > defined as completely normal, especially in the networking.
> > 
> > Is it impossible to handle unaligned access traps properly on
> > parisc?  If so, well you have some problems...
> 
> No, we just haven't bothered to implement it yet.  Not many people
> use IPX these days.
> 
OK, well this seems to have opened quite a can of worms. Programming the
handling of unaligned access traps on parisc is quite above my
possibilities.

I did notice that mark_de_without_sd() in reiserfs_fs.h just calls the
ext2_{set|clear|test}_bit routines. If the host architecture should
handle that with unaligned addresses, obviously the exception for s390
should also go. The current source would make reiserfs slow on sparc as
well, if I understand correctly.

To solve this for parisc, I see two possibilities:

- rewrite asm/parisc/bitops.h to have the ext2_* routines handle
  unaligned addresses. This would possibly be slowing down all aligned
  access. Not so nice.

- rewrite reiserfs_fs.h to use it's own test/set/clear bit routines.
  This would lose all the optimizations all specific architectures have
  in their asm/*/bitops.h. Also not nice.

Keeping in mind that I don't know any parisc assembly, is there any way
I can help resolve this in an elegant manner?

Greetings,
Jurriaan
-- 
If all else fails, immortality can always be assured by spectacular error.
        John Kenneth Galbraith
GNU/Linux 2.4.9-ac5 SMP/ReiserFS 2x1402 bogomips load av: 0.45 0.12 0.04
