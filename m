Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269456AbRHCQUu>; Fri, 3 Aug 2001 12:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269465AbRHCQUa>; Fri, 3 Aug 2001 12:20:30 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:28080 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S269464AbRHCQU0>; Fri, 3 Aug 2001 12:20:26 -0400
Date: Fri, 3 Aug 2001 12:20:34 -0400
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Message-ID: <20010803122034.C25450@cs.cmu.edu>
Mail-Followup-To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200108022218.f72MIm8v028137@webber.adilger.int> <20010802204710.B18742@emma1.emma.line.org> <200108022218.f72MIm8v028137@webber.adilger.int> <5.1.0.14.2.20010803002501.00ada0e0@pop.cus.cam.ac.uk> <20010803021406.A9845@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010803021406.A9845@emma1.emma.line.org>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 02:14:06AM +0200, Matthias Andree wrote:
> On Fri, 03 Aug 2001, Anton Altaparmakov wrote:
> > filedescriptor to be synced to disk, the ONLY possible way to do this it to 
> > sync the parent directory in order to commit the file name to disk. On some 
> 
> Do I really need to sync the WHOLE parent directory? Not just the
> relevant part? My directories hardly have only 1 disk block.

Only dirty blocks are written back to disk, i.e. the parts of the
directory that were modified by adding/removing names. It should be
pretty efficient.

> > to explicitly sync the directory filedescriptor afterwards.
> 
> Which is non-portable and will not be done by many application
> programmers which just use chattr +S instead (makes things S)afe and
> S)low) - and spoil performance that way since it makes not only
> directory writes synchronous, but file (data) writes as well.

"chattr +S" is about as portable as adding fsync(parent), or even worse
as it only works on an ext2 file system. So I'm assuming that this is
just a nice exercise in annoying people.

Jan

