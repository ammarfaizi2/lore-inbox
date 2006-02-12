Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWBLIHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWBLIHe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 03:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWBLIHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 03:07:34 -0500
Received: from pop-6.dnv.wideopenwest.com ([64.233.207.24]:27111 "EHLO
	pop-6.dnv.wideopenwest.com") by vger.kernel.org with ESMTP
	id S932325AbWBLIHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 03:07:34 -0500
Date: Sun, 12 Feb 2006 03:07:27 -0500
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Packet writing issue on 2.6.15.1
Message-ID: <20060212080727.GE7450@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org,
	Phillip Susi <psusi@cfl.rr.com>
References: <20060211103520.455746f6@silver> <m3r76a875w.fsf@telia.com> <20060211124818.063074cc@silver> <m3bqxd999u.fsf@telia.com> <20060211170813.3fb47a03@silver> <43EE446C.8010402@cfl.rr.com> <20060211211440.3b9a4bf9@silver> <43EE8B20.7000602@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EE8B20.7000602@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com>, on Sat Feb 11, 2006 [08:10:56 PM] said:
> cdrecord is just burning the image in dao/tao/sao mode.  To use pktcdvd 
> to read/write the disc on the fly it must be formatted for packet mode 
> using cdrwtool.  If the disc is formatted in MRW mode, then you don't 
> even need pktcdvd to read/write it, that is supported by the firmware in 
> the drive.  Right now I believe you can use the dvd-rwtools package to 
> format media in MRW mode, and I plan on adding it as an option to 
> cdrwtool at some point.  See http://fy.chalmers.se/~appro/linux/DVD+RW/ 
> for more info.

	Hi;

	This is not technically true; once the pktcdvd mapping is made,
the device can be accessed like a r/w block device. For example, after
I associate the dvd with the pktcdvd device, I then can associate it
with a cryptographic loop device, and mke2fs on that, then mount it
and use it like any other filesystem. Something like:

pktsetup dvd /dev/dvd
losetup -e serpent-256 /dev/loop0 /dev/pktcdvd/dvd
mke2fs -m0 /dev/loop0
mount -o noatime,rw /dev/loop0 /mntpoint

	I realize you are differentiating between burning an iso
type image from what cdrwtool does, but I thought I would mention
my usage;) Obviously this would not be compatible with anything
else, which is intentional.
	What is the difference between using cdrwtool on the cd/vd-rw
to form an initial image, and just doing a mkudffs on a pktcdvd
associated device?

Paul
set@pobox.com
