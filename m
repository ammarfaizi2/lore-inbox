Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314212AbSDRBuq>; Wed, 17 Apr 2002 21:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314215AbSDRBup>; Wed, 17 Apr 2002 21:50:45 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:50347 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S314212AbSDRBup>; Wed, 17 Apr 2002 21:50:45 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Date: Thu, 18 Apr 2002 11:54:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15550.10053.834276.18723@notabene.cse.unsw.edu.au>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: RAID superblock confusion
In-Reply-To: message from Richard Gooch on Saturday April 13
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday April 13, rgooch@ras.ucalgary.ca wrote:
> Neil Brown writes:
> > On Wednesday April 10, rgooch@ras.ucalgary.ca wrote:
> > > 
> > > The device is set up (i.e. SCSI host driver is loaded) long before I
> > > do raidstart /dev/md/0
> > 
> > raidstart simply does not and cannot work reliably when your device
> > numbers change around.  It takes the first device listed in
> > /etc/raidtab and gives it to the kernel.
> > The kernel reads the superblock, finds some device numbers and tries
> > to attach those devices.  If device number have changed, you loose.
> 
> Sounds to me like the flaw is in the ioctl(2) interface, in that it
> doesn't allow passing all the block devices in the RAID set. If it
> allowed you to pass all the block devices, then it could check if all
> the signatures on each block device match.

Exactly.  The flaw is in the ioctl interface.  2.4 comes with an
improved ioctl interface which allows you to tell the kernel exactly
what you want it to do.  mdadm used this interface.

> 
> I tried the alternative of setting persistent-superblock=0 in
> /etc/raidtab, but the stupid thing complained because it found a
> superblock. Sigh.
> 
> If there was only a "do as I say, regardless" mode, I would be happy.
> This programmer-knows-best attitude smacks of M$.

mdadm will do as you say, reguardless - if you ask it to.  Have you
tried mdadm?
   http://www.cse.unsw.edu.au/~neilb/source/mdadm/

NeilBrown
