Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262913AbSKTWzV>; Wed, 20 Nov 2002 17:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbSKTWzV>; Wed, 20 Nov 2002 17:55:21 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:50338 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262908AbSKTWzQ>; Wed, 20 Nov 2002 17:55:16 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Anton Altaparmakov <aia21@cantab.net>
Date: Thu, 21 Nov 2002 10:02:07 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15836.5231.38079.474147@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
In-Reply-To: message from Anton Altaparmakov on Wednesday November 20
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
	<Pine.SOL.3.96.1021120095120.2764A-100000@libra.cus.cam.ac.uk>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 20, aia21@cantab.net wrote:
> Hi,
> 
> On Wed, 20 Nov 2002, Neil Brown wrote:
> > I (and others) would like to define a new (version 1) format that
> > resolves the problems in the current (0.90.0) format.
> > 
> > The code in 2.5.lastest has all the superblock handling factored out so
> > that defining a new format is very straight forward.
> > 
> > I would like to propose a new layout, and to receive comment on it..
> 
> If you are making a new layout anyway, I would suggest to actually add the
> complete information about each disk which is in the array into the raid
> superblock of each disk in the array. In that way if a disk blows up, you
> can just replace the disk use some to be written (?) utility to write the
> correct superblock to the new disk and add it to the array which then
> reconstructs the disk. Preferably all of this happens without ever
> rebooting given a hotplug ide/scsi controller. (-;

What sort of 'complete information about each disk' are you thinking
of?

Hot-spares already work.
Auto-detecting a new drive that has just been physically plugged in
and adding it to a raid array is as issue that requires configuration
well beyond the scope of the superblock I believe.  
But if you could be more concrete, I might be convinced.

> 
> >From a quick read of the layout it doesn't seem to be possible to do the
> above trivially (or certainly not without help of /etc/raidtab), but
> perhaps I missed something...
> 
> Also, autoassembly would be greatly helped if the superblock contained the
> uuid for each of the devices contained in the array. It is then trivial to
> unplug all raid devices and move them around on the controller and it
> would still just work. Again I may be missing something and that is
> already possible to do trivially.

Well... it depends on whether you want a 'name' or an 'address' in the
superblock.
A 'name' is something you can use to recognise the device when you see
it, an 'address' is some way to go and find the device if you don't
have it.

Each superblock already has the 'name' of every other device
implicitly, as a devices 'name' is the set_uuid plus a device number.

I think storing addresses in the superblock is a bad idea as they are
in-general not stable, and if you did try to store some sort of
stable address, you would need to allocate quite a lot of space which
I don't think is justified.

Just storing a name is enough for auto-assembly providing you can
enumerate all devices.  I think at this stage we have to assume that
userspace can enumerate all devices and so can find the device for
each name.  i.e. find all devices with the correct set_uuid.

Does that make sense?

Thankyou for your feedback.

NeilBrown
