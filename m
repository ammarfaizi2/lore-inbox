Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVKKOIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVKKOIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 09:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVKKOIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 09:08:45 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:653 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750777AbVKKOIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 09:08:44 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 11 Nov 2005 14:08:36 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to speed up raid1 resync ?
In-Reply-To: <1131717619.4133.13.camel@rousalka.dyndns.org>
Message-ID: <Pine.LNX.4.64.0511111405040.5962@hermes-1.csi.cam.ac.uk>
References: <1131717619.4133.13.camel@rousalka.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005, Nicolas Mailhot wrote:
> I'm performing various lvm/raid experiments on my system. As a result,
> I've trashed one of the two disks of a raid1 set. So now the raid is
> rebuilding, as soon as it finished I intend to retry experimenting
> (disconnect one drive in the raid set, experiment with the other, if big
> mistake replug the other one and sync with it).
> 
> However mdmadm resync is dog slow (if gracefully backgrounded)

Just echo large numbers into both min and max resync speed proc entries:

/proc/sys/dev/raid/spped_limit_max and speed_limit_min

e.g. as root do:

echo 200000 > /proc/sys/dev/raid/speed_limit_max
echo 200000 > /proc/sys/dev/raid/speed_limit_min

And watch the speed fly up till it maxes out your hardware.  (-:

The above will set both speeds to 200MiB/s which ought to be more than 
your devices can do...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
