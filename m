Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279790AbRJ0HUn>; Sat, 27 Oct 2001 03:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279789AbRJ0HUd>; Sat, 27 Oct 2001 03:20:33 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:22261 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S279788AbRJ0HUZ>; Sat, 27 Oct 2001 03:20:25 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Sat, 27 Oct 2001 01:20:16 -0600
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Non-standard MODULE_LICENSEs in 2.4.13-ac2
Message-ID: <20011027012016.F23590@turbolinux.com>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <13064.1004153516@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13064.1004153516@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 27, 2001  13:31 +1000, Keith Owens wrote:
> These are the non-standard MODULE_LICENSEs in 2.4.13-ac2, compiling
> these as modules will result in a tainted kernel.  "BSD without
> advertising clause" is not quite good enough for the kernel, that
> licence allows for binary only modules.  Kernel debuggers insist on
> general source availability.
> 
> Since the source is already in the kernel which is distributed as a GPL
> work, these sources are effectively dual BSD/GPL.  Could the owners
> please convert them to "Dual BSD/GPL"?

Ah, so Keith has become (self) nominated license God for the kernel?
Being included in the kernel source isn't "general source availability"?

I can see that you want to make this whole tainted-kernel mess work,
but I think you are confusing intent with implementation.  The intent
(AFAICS) is to mark the kernel tainted ONLY if a closed-source module
is loaded, rather than to be a "license police" mechanism, especially
for sources that have been included in the kernel for a long time.

Rather than make the MODULE_LICENSE() a string that people just fill in
(which as your example shows also has problems with spelling and such)
you could have a few pre-defined values to make things easier:

#define LICENSE_STRING_GPL          "GPL"
#define LICENSE_STRING_DUAL_BSD_GPL "Dual BSD/GPL"
#define LICENSE_STRING_DUAL_MPL_GPL "Dual MPL/GPL"
#define LICENSE_STRING_BSD_KERNEL   "BSD without advertising clause, kernel source"

This not only means we avoid problems with spelling (which will mark a 
kernel as tainted, even if it says "GNU GPL" or similar, and makes keeping
the values consistent between user-space and kernel space easier.  A
NON-TAINTING license string needs to be added for BSD sources that are
part of the kernel.

I totally disagree with the assertion that a module has to be "GPL" in
order to be "OSS free" especially for sources already in the kernel,
so lets not go on a witch hunt for non-GPL licenses in the kernel just
to make this tainted stuff work without adding a new license.  There is
enough animosity between the Linux and GPL camps without more fire for
the "GPL is viral, BSD is free" flamewars.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

