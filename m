Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276367AbRI1XSK>; Fri, 28 Sep 2001 19:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276373AbRI1XSA>; Fri, 28 Sep 2001 19:18:00 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:29431 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S276367AbRI1XRw>; Fri, 28 Sep 2001 19:17:52 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 28 Sep 2001 17:17:41 -0600
To: Brad Bozarth <prettygood@cs.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Big-endian reading/writing cramfs (vs 2.4.10)
Message-ID: <20010928171741.E930@turbolinux.com>
Mail-Followup-To: Brad Bozarth <prettygood@cs.stanford.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010928163313.C930@turbolinux.com> <Pine.LNX.4.33.0109281539220.11173-100000@earth.ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109281539220.11173-100000@earth.ayrnetworks.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 28, 2001  15:54 -0700, Brad Bozarth wrote:
> > On Sep 28, 2001  14:58 -0700, Brad wrote:
> > > +#define CRAM_SWAB_16(x)	( ( (0x0000FF00 & (x)) >> 8   ) | \
> > > +			  ( (0x000000FF & (x)) << 8 ) )
> >
> > Why not just use the well-defined le16_to_cpu() and le32_to_cpu() macros?
> 
> I did, originally... And it worked in inode.c, but I couldn't get mkcramfs
> to compile using those macros.  It's outside of __KERNEL__ so I tried
> using __cpu_to_le32.  The following error occurred:

I didn't realize that the header was also used in user-space.  I would
still use the le32_to_cpu() style macros in the code, but only define
macros of your own if the kernel ones were not defined, using either
#ifndef __KERNEL__ or #ifndef le32_to_cpu, or both.

This way, you get the benefit of the fast asm-based instructions in
the kernel, and you only use the slow ones in user-space (mkcramfs)
where you don't really care.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

