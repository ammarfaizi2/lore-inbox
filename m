Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUJHV5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUJHV5h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 17:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUJHV5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 17:57:37 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:56002 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265805AbUJHV53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 17:57:29 -0400
Date: Fri, 8 Oct 2004 22:57:25 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: [patch 1/1] dm: fix printk warnings about whether %lu/%Lu is
 right for sector_t
In-Reply-To: <200410082245.39119.blaisorblade_personal@yahoo.it>
Message-ID: <Pine.LNX.4.60.0410082221340.26699@hermes-1.csi.cam.ac.uk>
References: <20041008144034.EB891B557@zion.localdomain>
 <20041008121239.464151bd.akpm@osdl.org> <Pine.LNX.4.60.0410082105351.26699@hermes-1.csi.cam.ac.uk>
 <200410082245.39119.blaisorblade_personal@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2004, Paolo Giarrusso wrote:
> On Friday 08 October 2004 22:11, Anton Altaparmakov wrote:
> > On Fri, 8 Oct 2004, Andrew Morton wrote:
> > > blaisorblade_spam@yahoo.it wrote:
> > Actually %Ld is completely wrong.  I know in the kernel it makes no
> > difference but people see it in the kernel and then go off an use it in
> > userspace and it generates junk output on at least some architectures.
> Well, gcc does not complain, and the problem is not "kernel is special" or "on 
> some arch it's different". It's an alias for "ll" for both gcc and glibc; I 
> checked, in fact, the version below of info pages for glibc:

gcc is not the only compiler and glibc is not the only C library.

> This is Edition 0.10, last updated 2001-07-06, of `The GNU C Library
> Reference Manual', for Version 2.3.x of the GNU C Library.
> (I guess the "last update" is botched).
> 
> > This is because %L means "long double (floating point)" not "long long
> > integer" and when you stuff an integer into it it goes wrong (on some
> > architectures)... 
> I think an all ones, or at least on i386.

Yes I know in the kernel and on i386 it makes no difference, I said that 
already.  But on some systems it does make a difference.  I have seen it 
myself and I have had it reported.  Thinking about it when I said 
architectures I possibly meant to say "other Unix flavours", I think one 
of the *BSDs was the one where I saw the difference between %L and %ll 
manifest itself.

> > From the printf(3) man page: 
> Outdated.

Sorry, it is not.  I find it somewhat strange that you choose gcc and 
glibc to say what is correct...  Ever heard of standards?!?

Quoting from C99 standard (ISO/IEC 9899:1999(E)):

[cut here]
ll (ell-ell) Specifies that a following d, i, o, u, x, or X conversion
	     specifier applies to a long long int or unsigned long long
	     int argument; or that a following n conversion specifier
	     applies to a pointer to a long long int argument.
[snip]
L	     Specifies that a following a, A, e, E, f, F, g, or G
	     conversion specifier applies to a long double argument. 

If a length modifier appears with any conversion specifier other than as 
specified above, the behavior is undefined.
[cut here]

So the C99 standard specifies the use of %L with an integer type 
conversion specified is undefined.  So relying on %L being an alias for 
%ll considering there are systems where this is not the case seems stupid 
to me but hey I don't really care.  I just thought I would let people who 
don't know it know.  If you want to carry on using %L because it works in 
the kernel be my guest.

Best regards,

	Anton

PS. Just don't submit patches containing %L for fs/ntfs/* or I will flame 
you to crisp as we share code with userspace libntfs and ntfsprogs and I 
and other NTFS developers care about our code being portable and working 
on as many architectures and OS as possible.  (-;

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
