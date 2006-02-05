Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWBEVHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWBEVHt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 16:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWBEVHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 16:07:49 -0500
Received: from dust.daper.net ([83.16.99.170]:2489 "EHLO daper.net")
	by vger.kernel.org with ESMTP id S1750721AbWBEVHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 16:07:48 -0500
Date: Sun, 5 Feb 2006 22:07:46 +0100
From: Damian Pietras <daper@daper.net>
To: Peter Osterlund <petero2@telia.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Problems with eject and pktcdvd
Message-ID: <20060205210746.GA16023@daper.net>
References: <20060115123546.GA21609@daper.net> <43CA8C15.8010402@cfl.rr.com> <20060115185025.GA15782@daper.net> <43CA9FC7.9000802@cfl.rr.com> <m3ek39z09f.fsf@telia.com> <20060115210443.GA6096@daper.net> <m33bixaaav.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33bixaaav.fsf@telia.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2006 at 08:13:28PM +0100, Peter Osterlund wrote:
> Damian Pietras <daper@daper.net> writes:
> 
> > On Sun, Jan 15, 2006 at 09:47:40PM +0100, Peter Osterlund wrote:
> > > 
> > > The irq timeout problem might be broken hardware/firmware, but there
> > > is a problem with drive locking and the pktcdvd driver.
> > > 
> > > If you do
> > > 
> > > 	pktsetup 0 /dev/hdc
> > > 	mount /dev/hdc /mnt/tmp
> > > 	umount /mnt/tmp
> > > 
> > > the door will be left in a locked state. (It gets unlocked when you
> > > run "pktsetup -d 0" though.) However, if you do:
> > > 
> > > 	pktsetup 0 /dev/hdc
> > > 	mount /dev/pktcdvd/0 /mnt/tmp
> > > 	umount /mnt/tmp
> > 
> > Thanks!
> > 
> > It works this way without any irq timeout. Unfortunately I can't use it
> > as a workaround, because CD-R media must be mounted with '-o ro' or I
> > get 'pktcdvd: Wrong disc profile (9)', so I can't just put it in fstab
> > and use 'mount /media/cdrom' for both CD-R and RW discs.
> 
> Please try this patch.

Now I can mount CD-R, CD-RW, DVD+RW using pktcdvd.

Something strange happend when I copied files to DVD+RW und used eject.
After some time eject exitet, but the disc was stil in the burner, I was
allowed to open it by pressing the eject button, but then:

hda: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hda: media error (bad sector): error=0x34 { AbortedCommand LastFailedSense=0x03
}
ide: failed opcode was: unknown
end_request: I/O error, dev hda, sector 4546112
end_request: I/O error, dev hda, sector 4546116
end_request: I/O error, dev hda, sector 4546124
end_request: I/O error, dev hda, sector 4546132
end_request: I/O error, dev hda, sector 4546140
end_request: I/O error, dev hda, sector 4546148
end_request: I/O error, dev hda, sector 4546156
end_request: I/O error, dev hda, sector 4546164
end_request: I/O error, dev hda, sector 4546172
Buffer I/O error on device pktcdvd0, logical block 1136528
lost page write due to I/O error on pktcdvd0

And also many messages like this:
pktcdvd: Unknown ioctl for pktcdvd0 (5326)

I have no more free time to test if the disc is OK, but I think it is,
since it's new and was written only few times.
Writing to CD-RW and umounting it gave no errors.


When inserting CD-R I get:
pktcdvd: Wrong disc profile (9)
pktcdvd: pktcdvd0 failed probe

but everything works OK.

-- 
Damian Pietras
