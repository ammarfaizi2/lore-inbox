Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310424AbSCGR3y>; Thu, 7 Mar 2002 12:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310425AbSCGR3p>; Thu, 7 Mar 2002 12:29:45 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:49657
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310424AbSCGR31>; Thu, 7 Mar 2002 12:29:27 -0500
Date: Thu, 7 Mar 2002 09:30:21 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Steve Lord <lord@sgi.com>
Cc: Etienne Lorrain <etienne_lorrain@yahoo.fr>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] delayed disk block allocation
Message-ID: <20020307173021.GB28141@matchmail.com>
Mail-Followup-To: Steve Lord <lord@sgi.com>,
	Etienne Lorrain <etienne_lorrain@yahoo.fr>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020307120609.85742.qmail@web11804.mail.yahoo.com> <1015512444.1293.14.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1015512444.1293.14.camel@jen.americas.sgi.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 08:47:24AM -0600, Steve Lord wrote:
> On Thu, 2002-03-07 at 06:06, Etienne Lorrain wrote:
> > > With "allocate on flush", (aka delayed allocation), file data is
> > > assigned a disk mapping when the data is being written out, rather than
> > > at write(2) time.  This has the following advantages:
> > 
> >   I do agree that this is a better solution than current one,
> >  but (even if I did not had time to test the patch), I have
> >  a question: How about bootloaders?
> > 
> >  IHMO all current bootloaders need to write to disk a "chain" of sector
> >  to load for their own initialisation, i.e. loading the remainning
> >  part of code stored on a file in one filesystem from the 512 bytes
> >  bootcode. This "chain" of sector can only be known once the file
> >  has been allocated to disk - and it has to be written on the same file,
> >  at its allocated space.
> > 
> >   So can you upgrade LILO or GRUB with your patch installed?
> >   It is not a so big problem (the solution being to install the
> >  bootloader on an unmounted filesystem with tools like e2fsprogs),
> >  but it seems incompatible with the current executables.
> 
> The interface used by lilo to read the kernel location needs to flush
> data out to disk before returning results. It's not too hard to do.
> 

Also, GRUB shouldn't have this problem since it reads the filesystems
directly on boot.
