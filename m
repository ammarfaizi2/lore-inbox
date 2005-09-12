Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbVILJIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVILJIY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVILJIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:08:24 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:45256 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751254AbVILJIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:08:23 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 12 Sep 2005 10:08:18 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [2.6-GIT] NTFS: Release 2.1.24. 
In-Reply-To: <200509120213.j8C2DVTK014972@inti.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.60.0509121006450.25285@hermes-1.csi.cam.ac.uk>
References: <200509120213.j8C2DVTK014972@inti.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sep 2005, Horst von Brand wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > On Sat, 10 Sep 2005, Giuseppe Bilotta wrote:
> [...]
> > > BTW Anton, while looking for the best permission masks to be used when
> > > mounting my NTFS paritions, I spotted what I think is a bug, or at
> > > least an inconsistency between the way all fs drivers I use handle
> > > umasks & friends, and the way NTFS does it. Basically, all the other
> > > fs drivers take an octal representation of the masks. NTFS, instead,
> > > seems to use _decimal_
> 
> > NTFS takes any.  It is happy with octal, decimal, and hex.  The ntfs 
> > driver uses linux/lib/vsprintf.c::simple_strtoul() with a zero base which 
> > autodetects which base to use so if you use umask=0222 it will take this 
> > as octal and if you use umask=222 it will take this as decimal and if you 
> > use 0x222 it will take this as decimal.
> 
> > I do not see what is wrong with that.  It behaves exactly like I would 
> > expect it to.  Maybe I have strange expectations?  (-;
> 
> At least chmod(1) takes /only/ octal, so 666 isn't the number of the beast,
> but plain rw for everybody ;-)

Ah, oops.  I don't think I ever noticed that.  I always have given it 
0xyz, i.e. "proper" octal.

> I think this should be consistent with that.

Yes, I fully agree.  It should be consistent.  I will patch ntfs and send 
it to Linus for 2.6.14.

Thanks to both of you for pointing this out.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
