Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268564AbTGOPxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268567AbTGOPv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:51:29 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:21947 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S268789AbTGOPvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:51:02 -0400
Date: Tue, 15 Jul 2003 18:05:58 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Josh Litherland <josh@emperorlinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Partitioned loop device..
Message-ID: <20030715160558.GA22548@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Josh Litherland <josh@emperorlinux.com>,
	linux-kernel@vger.kernel.org
References: <200307151001.44218.kevcorry@us.ibm.com> <20030715155317.317B461FDE@sade.emperorlinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030715155317.317B461FDE@sade.emperorlinux.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 11:53:17AM -0400, Josh Litherland wrote:
> In article <200307151001.44218.kevcorry@us.ibm.com> you wrote:
> 
> > so there's not much of a reason to add partitioning support to the loop 
> > driver itself.
> 
> Working with sector images of hard drives?  I use Linux for data
> recovery jobs and it would be very helpful to me to be able to look at
> DOS partitions inside a loopback device.  As it is I must chunk it up
> into seperate files by hand.

you could also setup more than one loopback
device with different offsets into the partitions ...

for my purposes, I use the folowing script (part)

YMMV,
Herbert

---------------------

losetup /dev/loop/0 $file
sfdisk --dump /dev/loop/0 | gawk '
	/^\/dev\/loop/ 	{ 
			  if ($6+0 > 0) {
				part=substr($1,13)+0;
				dev=sprintf("/dev/loop/%d", part);
				printf "losetup %s -o %d /dev/loop/0\n", dev, $4*512; 
				printf "fsck -p -f %s\n", dev; 
				printf "mkdir -p /mnt/disk/part%d\n", part; 
				printf "mount %s /mnt/disk/part%d\n", dev, part; 
			  }
			}
	' | sh




> 
> -- 
> Josh Litherland (josh@emperorlinux.com)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
