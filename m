Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbUC2PAl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 10:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbUC2PAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 10:00:41 -0500
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:47275 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262904AbUC2PAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 10:00:38 -0500
Subject: Re: [Linux-NTFS-Dev] Geometry determination
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>,
       ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040329144111.GA26750@apps.cwi.nl>
References: <1080564842.5545.19.camel@imp.csi.cam.ac.uk>
	 <Pine.LNX.4.21.0403291512030.6684-100000@mlf.linux.rulez.org>
	 <20040329144111.GA26750@apps.cwi.nl>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Message-Id: <1080572538.5545.26.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 29 Mar 2004 16:02:19 +0100
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 15:41, Andries Brouwer wrote:
> On Mon, Mar 29, 2004 at 03:48:01PM +0200, Szakacsits Szabolcs wrote:
> > On Mon, 29 Mar 2004, Anton Altaparmakov wrote:
> > > I have been experimenting a little with what Windows / Linux 2.4 / Linux
> > > 2.6 think the geometry of a couple of HDs is and the results are not
> > > very promising.  )-:
> > > 
> > > Using Linux 2.4, HDIO_GETGEO ioctl, I get the same Heads and Sectors per
> > > Track as Windows on both HDs I tried it on.  This is the good news. 
> > > I.e. at least on those two disks mkntfs as it stands now would create
> > > Windows bootable partitions.
> > > 
> > > The bad news is that Linux 2.4, HDIO_GETGEO ioctl returns wrong values
> > 
> > You mean 2.6? That's what I'm saying also for a while. It's a known issue
> > and people are complaining about it because kernel breaks things (e.g.
> > they can't boot anymore and think Linux thrashed their systems).
> > 
> > I don't know who is the kernel maintainer today but apparently nobody.  
> > Old maintainer, Andries Brouwer, only repeates that the geometry doesn't
> > exists even if he was/is proved and pointed out to be wrong many times.
> > 
> > The issue was discussed long, several times on linux-kernel without a
> > satisfying solution.
> 
> Well, to be more precise, my point of view is that roughly speaking
> (I know of some obscure exceptions) "geometry" does not play a role
> for Linux. Something entirely different is the use of other operating
> systems.
> 
> What I also claim is that Linux has no way of knowing what geometry
> other operating systems will assign to a disk. Different operating
> systems invent different translations.
> 
> Moreover, there is the matter of the correspondence of BIOS disk numbers
> and Linux disk names. Especially when both IDE and SCSI disks are present,
> and when more than two disks are present, it may be impossible to get
> this correspondence right. Details depend on the type of BIOS.
> 
> So, I claim, until now the kernel attempted to do something, and it often
> worked, and it often failed.
> 
> However, there is really no good reason why the kernel would try to guess
> at the geometry other systems like to see. For the past years, the main
> thing the kernel did was inferring the desired geometry from the partition
> table. But fdisk or LILO or whatever can do that as well. So, really
> no kernel help is needed.
> 
> I say this every few months and have not ever seen a good reason why
> this code would have to be in the kernel.
> 
> (In other words: please, never use HDIO_GETGEO, the kernel does not
> have an opinion anymore, and HDIO_GETGEO produces random results.
> Do as *fdisk does: get a geometry, if one is needed, from the
> partition table.)

I would rather not have to touch the partition table from within
mkntfs.  But I guess I may have to do that in the end if there is no
other way.  )-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/

