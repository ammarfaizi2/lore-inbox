Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280423AbRJaTIR>; Wed, 31 Oct 2001 14:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280424AbRJaTIH>; Wed, 31 Oct 2001 14:08:07 -0500
Received: from [63.231.122.81] ([63.231.122.81]:44906 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S280423AbRJaTH4>;
	Wed, 31 Oct 2001 14:07:56 -0500
Date: Wed, 31 Oct 2001 12:08:17 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com
Subject: Re: [PATCH] init/main.c/root_dev_names - another one #ifdef
Message-ID: <20011031120817.L16554@lynx.no>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	torvalds@transmeta.com
In-Reply-To: <20011030182810.B800@lynx.no> <200110311728.f9VHSE207521@ns.caldera.de> <20011031112055.D16554@lynx.no> <20011031193148.A12919@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011031193148.A12919@caldera.de>; from hch@caldera.de on Wed, Oct 31, 2001 at 07:31:48PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 31, 2001  19:31 +0100, Christoph Hellwig wrote:
> On Wed, Oct 31, 2001 at 11:20:55AM -0700, Andreas Dilger wrote:
> > This seems kind of ugly - an array holding each device name?  The patch
> > I have rather puts a function to generate the device names when needed
> > (which is probably not very often, unless GFS does something wierd).
> 
> *nod*
> 
> > I take it your patch is only the "bare bones" part which shows what is
> > changed?
> 
> Well, it's a patch that tries to be not intrusive, it just crates the hooks
> the two blockdevice drivers in the OpenGFS tree can use.

Well, given that it's intrusive enough to change the gendisk struct
(which my patch does as well), we may as well go whole hog and remove
all of the partition name cruft from where it should not be.  I suppose
the issue is whether you are expecting GFS to go into the kernel, or if
you want to keep the diff as small as possible if it will be outside
the kernel for a long time.

The LVM code had a global function to fix the naming issue for LVM
devices in /proc/partitions, but Linus (AFAIK) didn't like it because
it didn't fix the real problem, as the posted patch does, of localizing
the partition name generation to the driver itself.  The only wart in
the current system is that we use an external buffer passed into the
driver, and if the driver likes long names (ala LVM) it will overflow.

As I look through the kernel today, there is even more ugliness spread
around with "#ifdef CONFIG_DEVFS" to create strange partition names in
places where it should probably not be.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

