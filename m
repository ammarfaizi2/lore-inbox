Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278492AbRK1R1q>; Wed, 28 Nov 2001 12:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278522AbRK1R1g>; Wed, 28 Nov 2001 12:27:36 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:50931 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S278492AbRK1R10>;
	Wed, 28 Nov 2001 12:27:26 -0500
Date: Wed, 28 Nov 2001 10:27:15 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre2 does not compile
Message-ID: <20011128102715.R730@lynx.no>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200111272209.fARM9tk18991@ns.caldera.de> <Pine.LNX.4.33.0111271628430.1629-100000@penguin.transmeta.com> <20011128135508.A21418@caldera.de> <20011128092600.Q730@lynx.no> <20011128174250.A17582@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011128174250.A17582@caldera.de>; from hch@caldera.de on Wed, Nov 28, 2001 at 05:42:50PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 28, 2001  17:42 +0100, Christoph Hellwig wrote:
> On Wed, Nov 28, 2001 at 09:26:00AM -0700, Andreas Dilger wrote:
> > What would be nice in the case of drivers that don't use the new error
> > handling code is to add something like:
> > 
> > #warning "Uses obsolete SCSI error code, see Documentation/2.5/scsi-error.txt"
> > 
> > for a hint as to the reason why it no longer compiles, and a short guide
> > on how to update the drivers.
> 
> I already thought about that - as the old error handling code is selected
> by setting a member in a struct to '1' I don't see any easy way to do so...

I'm thinking about a compile-time #warning/#error, that at least tells an
interested party where to start looking for how to fix this.  It could be
anywhere in the affected driver source file (preferrably at the top, so it
is hit before the compiler exits because of too many other errors).  It
would just be a matter of cut-n-paste a single line into every file which
previously used the old error-handling code.

I presume that the nature of this change will either cause compile errors
anyways (because of missing struct definitions), or linker errors (because
of missing functions).  I think that having a #warning at compile time will
at least avoid a whole bunch of "this driver doesn't compile, help me"
emails, and may also help someone to actually update the driver rather than
giving up because they have no idea where to begin looking for the fix.

Actually, what would also be nice is to include the kernel version where
this change happened, so that interested parties could also see what changes
where necessary to bring about this fix.  In this case (removing the old
error handling support), it probably doesn't help much, but in Jens' BIO
changes it _would_ be very helpful to know when a major change was made
so potential fixers can "follow along" with the changes rather than having
to reverse-engineer it 50 releases from now (along with the 33 other major
changes that have been made along the way).  Even now, with the BIO +
SCSI error handling changes there are a lot of SCSI drivers with problems
and it won't be "obvious" how to fix them later on.

Cheers, Andreas

PS - are you sure the old error handling code was selected with a '1' and
     not with a '0' for "use_new_eh_code"?
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

