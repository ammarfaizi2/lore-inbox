Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262828AbSJ1EKh>; Sun, 27 Oct 2002 23:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262835AbSJ1EKh>; Sun, 27 Oct 2002 23:10:37 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:30622 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S262828AbSJ1EKg>; Sun, 27 Oct 2002 23:10:36 -0500
Date: Sun, 27 Oct 2002 23:06:37 -0500
To: Rob Landley <landley@trommello.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: The return of the return of crunch time (2.5 merge candidate list 1.6)
Message-ID: <20021028040637.GN1557@pimlott.net>
Mail-Followup-To: Rob Landley <landley@trommello.org>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <200210251557.55202.landley@trommello.org.suse.lists.linux.kernel> <20021027080125.A14145@wotan.suse.de> <20021027152038.GA26297@pimlott.net> <200210271157.46153.landley@trommello.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210271157.46153.landley@trommello.org>
User-Agent: Mutt/1.3.28i
From: Andrew Pimlott <andrew@pimlott.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 12:57:46PM -0500, Rob Landley wrote:
> On Sunday 27 October 2002 09:20, Andrew Pimlott wrote:
> 
> > Example problem case (assuming a fs that stores only seconds, and a
> > make that uses nanoseconds):
> >
> > - I run the "save and build" command while editing foo.c at T = 0.1.
> > - foo.o is built at T = 0.2.
> > - I do some read-only operations on foo.c (eg, checkin), such that
> >   foo.o gets flushed but foo.c stays in memory.
> > - I build again.  foo.o is reloaded and has timestamp T = 0, and so
> >   gets spuriously rebuilt.
> 
> If your system, and your disks, are so fast that they can not only finish the 
> build in under a second but can also flush the cache and reload it from disk 
> in under a second

That is not required.  The requirement is that, when the last step
happens (which can be any time in the future), (the inode of) foo.o
has been flushed, and foo.c hasn't.  Step 3 argues that this is
plausible.

> C) How would having ALL times rounded to a second be an improvement?

foo.c and foo.o would both have timestamps of 0.  make considers
the target foo.o newer in this case, so will not rebuild it.

Andrew
