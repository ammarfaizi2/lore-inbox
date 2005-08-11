Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVHKP3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVHKP3u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVHKP3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:29:50 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:10160 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751095AbVHKP3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:29:49 -0400
Date: Thu, 11 Aug 2005 11:29:48 -0400
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Partitioning problems on x86_64 (fwd)
Message-ID: <20050811152948.GH31019@csclub.uwaterloo.ca>
References: <Pine.LNX.4.58.0508110331360.3920@ppg_penguin.kenmoffat.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508110331360.3920@ppg_penguin.kenmoffat.uklinux.net>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 03:32:14AM +0100, Ken Moffat wrote:
>  Apologies if these are known problems, but I don't recall seeing them
> mentioned recently.
> 
>  I'm running an athlon64 with 2.6.12.3, in the middle of rebuilding it
> to run 64-bit.  The main drive used to be in an i686 machine for
> testing, and it got to a point where I wanted to repartition.
> 
>  Under a 64-bit kernel, every time I tried to rewrite the partition
> table in fdisk I got an error 16, device or resource busy, with a
> message that the new partition table would be used at the next boot.
> (Yes, I had umounted everything except '/' on hda5. )  Since making a
> filesystem on my new /dev/hda7 and mounting it showed the size of the
> old hda7 in 'df', I tried rebooting but the failure to rewrite the
> partition table continued.

The kernel won't reread the partition table as long as ANY part of that
disk is mounted.  Reboot (which of course unmounts everything) to reread
the partition table.

>  At one point, I thought I'd try the stronger magic of sfdisk, but that
> just reported some error in the number of bytes read, and decided it
> couldn't read the partition table.
> 
>  In the end I was able to repartition successfully by rebooting to a
> 2.6.12.1 i686 kernel.  This box is destined to become my new home
> server, so running test kernels on it isn't something I'm keen to try,
> but I thought I'd better report this, and the successful workaround of
> using an i686 kernel, which will be a bit of a pain on pure64.

Just any reboot should have worked.  Once you reboot it reads the
updated partition table and THEN you can mkfs the new partitions.  Until
/proc/partitions matches what you see in fdisk, you really don't want to
try access the partitions since it won't match on the next boot anyhow.

Len Sorensen
