Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131340AbRAAHzA>; Mon, 1 Jan 2001 02:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131664AbRAAHyv>; Mon, 1 Jan 2001 02:54:51 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:34471 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S131340AbRAAHyn>; Mon, 1 Jan 2001 02:54:43 -0500
Date: Sun, 31 Dec 2000 23:24:16 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, faith@valinux.com
Subject: Re: Patch(?): linux-2.4.0-prerelease/drivers/char/drm/Makefile libdrm symbol versioning fix
Message-ID: <20001231232416.A2549@adam.yggdrasil.com>
In-Reply-To: <20001231215216.A17686@baldur.yggdrasil.com> <6380.978331505@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <6380.978331505@ocs3.ocs-net>; from kaos@ocs.com.au on Mon, Jan 01, 2001 at 05:45:05PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2001 at 05:45:05PM +1100, Keith Owens wrote:
> Having drmlib.o as a helper module will defeat the requirements listed
> in drivers/char/drm/Makefile (below).  You end up with one copy of the
> library being used by all modules.  See my patch earlier today on l-k
> that builds two versions of drmlib.a, for kernel and module.  That
> patch preserves the drm requirements.
> 
> # libs-objs are included in every module so that radical changes to the
> # architecture of the DRM support library can be made at a later time.
> #
> # The downside is that each module is larger, and a system that uses
> # more than one module (i.e., a dual-head system) will use more memory
> # (but a system that uses exactly one module will use the same amount of
> # memory).
> #
> # The upside is that if the DRM support library ever becomes insufficient
> # for new families of cards, a new library can be implemented for those new
> # cards without impacting the drivers for the old cards.  This is significant,
> # because testing architectural changes to old cards may be impossible, and
> # may delay the implementation of a better architecture.  We've traded slight
> # memory waste (in the dual-head case) for greatly improved long-term
> # maintainability.
> 
> BTW, I disagree with this approach but I guess it is up to the drm
> maintainers.

	Like you, I also disagree with this approach, but I think it
is ugly enough and has so little justification that I see, that I
_currently_ hope that those comments from the Makefile will simply
be deleted.

	If radical changes were necessary, the drm maintainers could
always write libdrm2 and modules that needed that would pick it up via
depmod/modprobe.  We have radical changes all the time in kernel
interfaces (for example, the "new style" PCI initilialization) and deal
with the same issues of wanting to support old methods for old hardware
for a while.  Imagine if the rest of the kernel took this approach.

	The issue of supporting old hardware is particularly inapplicable
to drm, because drm, given that the shortcut to the framebuffer that is drm
is for situations where one is willing to go some trouble to get really
fast graphics performance.  Users of those applications will be
disproprortionately likely to keep up with hardware.  This is like
recoding i386 floating point into assembly language: the
performance vs. maintenance trade off is not worth it because 386's
have migrated to tasks where that performance is not valued at all
(otherwise they'd be upgraded to 486's at least).  And, yes, I am
saying that the approach of replicating the .o files is *harder*
to maintain, because it is an unusual build scheme and increases the
resource cost of enabling drm, encouraging small (such as boot-over-network)
systems to drop it.

	Also, from looking in the list of external symbols that the
drm modules resolve, it is also clear to me that replicating these
object files will not result in binary modules that work with many
kernel versions, if that is what they were aiming for.

	Anyhow, it is not my call, and there probably aren't any
more keystrokes for me to generate with respect to this issue, but
if there is not some information that I have missed about this issue,
then I sure hope that the drm maintainers will see the light or, if not,
that Linus overrules the drm maintainers if necessary and integrates a
patch like the one I posted and just deletes those comments from
drivers/char/drm/Makefile.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
