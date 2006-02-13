Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWBMAcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWBMAcX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 19:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWBMAcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 19:32:23 -0500
Received: from ms-smtp-04-smtplb.tampabay.rr.com ([65.32.5.134]:57481 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751500AbWBMAcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 19:32:23 -0500
Message-ID: <43EFD38F.30600@cfl.rr.com>
Date: Sun, 12 Feb 2006 19:32:15 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Paul <set@pobox.com>, linux-kernel@vger.kernel.org,
       Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Packet writing issue on 2.6.15.1
References: <20060211103520.455746f6@silver> <m3r76a875w.fsf@telia.com> <20060211124818.063074cc@silver> <m3bqxd999u.fsf@telia.com> <20060211170813.3fb47a03@silver> <43EE446C.8010402@cfl.rr.com> <20060211211440.3b9a4bf9@silver> <43EE8B20.7000602@cfl.rr.com> <20060212080727.GE7450@squish.home.loc>
In-Reply-To: <20060212080727.GE7450@squish.home.loc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul wrote:
> 
> 	This is not technically true; once the pktcdvd mapping is made,
> the device can be accessed like a r/w block device. For example, after
> I associate the dvd with the pktcdvd device, I then can associate it
> with a cryptographic loop device, and mke2fs on that, then mount it
> and use it like any other filesystem. Something like:

You must first format the cd-rw in packet mode with cdrwtool before 
pktcdvd can write to it.

> 
> pktsetup dvd /dev/dvd
> losetup -e serpent-256 /dev/loop0 /dev/pktcdvd/dvd
> mke2fs -m0 /dev/loop0
> mount -o noatime,rw /dev/loop0 /mntpoint
> 
> 	I realize you are differentiating between burning an iso
> type image from what cdrwtool does, but I thought I would mention
> my usage;) Obviously this would not be compatible with anything
> else, which is intentional.
> 	What is the difference between using cdrwtool on the cd/vd-rw
> to form an initial image, and just doing a mkudffs on a pktcdvd
> associated device?
> 

You can't mkudffs on pktcdvd unless the media has been formatted for 
packet mode, or in MRW mode, at least until the recent patches were 
applied.  If the media is formatted for MRW mode, then pktcdvd isn't 
required to write to it, but it used to work.  With the new patches 
applied it will refuse to access MRW discs.


