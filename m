Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286136AbRLJBJr>; Sun, 9 Dec 2001 20:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286133AbRLJBIt>; Sun, 9 Dec 2001 20:08:49 -0500
Received: from holomorphy.com ([216.36.33.161]:60803 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S286131AbRLJBIi>;
	Sun, 9 Dec 2001 20:08:38 -0500
Date: Sun, 9 Dec 2001 17:08:29 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: discontig-devel@lists.sourceforge.net
Subject: Re: [CFT] tree-based bootmem
Message-ID: <20011209170829.C939@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, discontig-devel@lists.sourceforge.net
In-Reply-To: <20011208154021.B939@holomorphy.com> <1007940570.1235.13.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <1007940570.1235.13.camel@phantasy>; from rml@tech9.net on Sun, Dec 09, 2001 at 06:29:26PM -0500
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2001 at 06:29:26PM -0500, Robert Love wrote:
> Patch successfully tested on (3) i386 machines, an SH4 machine, and a
> sparc32 machine.  And on the low memory SH4 machine, the
> finer-granularity of addressing is welcome.

Excellent!

On Sun, Dec 09, 2001 at 06:29:26PM -0500, Robert Love wrote:
> Now, when do we see some interface changes to bootmem that take
> advantage of your patch? :-)

Every bootmem caller, that is, setup_arch() for every architecture,
would need to be adjusted. The changes are not particularly difficult
to make, but they require the consent and/or assistance of various arch
maintainers, and I have only a limited selection of target architectures
to test and develop things on.

The interface changes I am interested in making are those that make
bootmem easier to use and eliminate duplicated code across various
architectures. For instance, to set up the bootmem allocator, one must
now build up an extent-based representation of memory fragments, and
then initialize separate bootmem state structures for each fragment in
order to accommodate the direct-mapped table representation now in use.
An alternative interface would be to pass in an initial tree node pool
for early reservations, finalizing the memory map to notify bootmem that
allocations may now be done, and afterward performing page stealing
when the node pool is exhausted by fragmentation from dynamic allocations.
(Personally, I'd very much like to get rid of NR_SEGMENTS in my code.)

I'd like to see the mechanism integrated before trying to bring in
the interface changes, and I'd also like to bring in some of the
other people involved in discontiguous memory support essentially
for having consensus around what the interface should be and to
integrate the patch with existing ones, e.g. discontig support for SN1.
Another important aspect of it is making sure they like this, too.
The discontig support for SN1 does not revolve around bootmem, but
requires some bootmem changes. I'm quite unaware of how discontiguous
memory is dealt with for Wildfire, so if someone could point me to
what's going on there, I'd be much obliged.

Another cause for my extreme conservatism with respect to testing
and "release schedule" is that the architectures requiring extreme
measures for discontiguous memory support already have something in
place just to work at all, and thus far, I've heard very little back
from those who maintain them, aside from some early comments from
discontig-devel members mentioning that the mechanism was elegant, and
that it would be good to bring a large change to common code to lkml
for review and testing. As these are the people the patch is intended
to benefit most, their feedback has much importance.


For the moment, I'll cc: this to discontig-devel and see what feedback
comes from there.

For those to whom this mail comes out of context, my current patches
may be found at

	ftp://ftp.kernel.org/pub/linux/kernel/people/wli/bootmem/

The bootmem-2.4.15 patch will also require the overflow-2.4.15 patch
for an important bug fix involving integer overflows.

Admittedly, little has changed in several weeks. I chose to leave
things largely as they are for the sake of additional testing as
opposed to adding in more features immediately.


Thanks,
Bill
