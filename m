Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280968AbRKGU1k>; Wed, 7 Nov 2001 15:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280964AbRKGU1U>; Wed, 7 Nov 2001 15:27:20 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:40699 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280952AbRKGU1O>;
	Wed, 7 Nov 2001 15:27:14 -0500
Date: Wed, 7 Nov 2001 13:25:52 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011107132552.J5922@lynx.no>
Mail-Followup-To: Anton Altaparmakov <aia21@cam.ac.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011107183639.0285a7e0@pop.cus.cam.ac.uk> <E161Y87-00052r-00@the-village.bc.nu> <5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <5.1.0.14.2.20011107193045.02b07f78@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Wed, Nov 07, 2001 at 07:40:27PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 07, 2001  19:40 +0000, Anton Altaparmakov wrote:
> Yes, that makes a lot of sense. After the reset I went into my own kernel 
> with both ext2 and ext3 compiled into it. However, before the reboot, I was 
> still in the RH kernel (99% sure it was so, but my memory might be 
> deceiving me).
> 
> Is there any Right Way(TM) to fix this situation considering I want to have 
> both ext2 and ext3 in my kernels (apart from the obvious of changing the 
> order fs are called during root mount in the kernel)?

If both ext2 and ext3 are compiled into the kernel, then ext3 will try first
to mount the root fs.  If there is no journal on this fs (check this with
tune2fs -l <dev>, and look for "has_journal" feature), then it will be
mounted as ext2.  If you are doing strange things with initrd and modules,
then there is more chance to have problems.

I don't know why you would want to go back to ext2 if you have ext3 in your
kernel, but if so, there is a patch to add a "rootfstype" parameter which
allows you to select the fstype to try and mount your root fs as.  It looks
like it is in Linus' 2.4.13 kernel at least (don't know when it went in).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

