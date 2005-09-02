Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbVIBNdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVIBNdj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 09:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVIBNdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 09:33:38 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:63072 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751300AbVIBNdi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 09:33:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VStg2YinXAUbnU7zB4/HlIbelz85uqQkCj/xlVzF9utGtWMjLDZCgOYDYEnSjFr9KWQEbhmDwLH6G9YNhtnNX65kuNDArB6vrN23XmV+qyot4oZzi+kF1qqpjnoYvarQH6/unsrpShBHZfs9BuwZ6hWx3lYT5lZzXpU9TChRD9c=
Message-ID: <62b0912f05090206331d04afd3@mail.gmail.com>
Date: Fri, 2 Sep 2005 15:33:36 +0200
From: Molle Bestefich <molle.bestefich@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE HPA
Cc: ataraid-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1125666332.30867.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <200508300859.19701.tennert@science-computing.de>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
	 <1125419927.8276.32.camel@localhost.localdomain>
	 <87941b4c050830095111bf484e@mail.gmail.com>
	 <62b0912f0509020027212e6c42@mail.gmail.com>
	 <1125666332.30867.10.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > If the formula is to fix all the userspace apps to take into account a
> > potential HPA, then eg. FDISK + SFDISK + Disk Druid et al should also
> > be fixed.  Because if you create a partition spanning your entire
> > disk, including the HPA area, and your boot files by some coincidence
> > ends up in the HPA part of the disk, the BIOS won't be able to read
> > them, and your system will not boot.  And if you fix those tools now,
> 
> The distribution vendors already put the boot area low down the disk to
> handle a whole variety of problems like this and the 1024 cylinder limit
> on old BIOSes.

Only as an option - it's not always possible.
For example one might have a Windows partition already in place, etc..

> > what about users that use older Linux distributions?  They'll have a
> > parade of problems coming to them with their new HPA-enabled disks
> > because every userspace tool assumes that <BIOS sector count == Linux
> > sector count>.
> 
> I work for a vendor. I get most of our IDE layer bugs. And do you know
> HPA doesn't really feature.

Fair enough.  It took 5 seconds of googling to find a guy whose GRUB
stopped working because of the HPA, so at least *some* people are
already having problems...

> > > It isnt the kernels fault if you compute from of end of disk rather than
> > > from end of non reserved area is it ?
> >
> > I agree that the entire disk should be visible under Linux.  But
> > instead of fixing every userspace app that assumes <BIOS sector count
> > == Linux sector count> (I'm guessing that's a lot), how about simply
> > exporting the HPA as /dev/ide/hostX/busY/targetZ/lunA/hpa, next to the
> > 'disc' device ?
> 
> A lot of applications assume Linux reported size == real disk size.

I can't think of any, but you might be right.

> It also wouldn't solve the case of a file system that spans both inside and
> outside the HPA.

If HPA were exposed as /dev/.../hpa then it wouldn't be possible to
create such a filesystem. I'm guessing it's not possible with Windows
either, or with any BIOS-based OS.

Creating filesystems that include the HPA defeats the entire idea of
the HPA in the first place.
  
If one does not care to use the HPA, one should disable it in the BIOS
entirely, so that everywhere (!) the entire disk is seen.

The inclusion of the HPA in /dev/.../disc should be a special case for
those unfortunate souls with laptops where the HPA cannot be disabled
because their BIOS is crap, IMHO.
