Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266293AbRGSX7K>; Thu, 19 Jul 2001 19:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266321AbRGSX67>; Thu, 19 Jul 2001 19:58:59 -0400
Received: from beppo.feral.com ([192.67.166.79]:38923 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S266293AbRGSX6v> convert rfc822-to-8bit;
	Thu, 19 Jul 2001 19:58:51 -0400
Date: Thu, 19 Jul 2001 16:58:36 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: <mjacob@feral.com>
To: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <xfs@ragnark.vestdata.no>
cc: "Christian, Chip" <chip.christian@storageapps.com>,
        <linux-xfs@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Busy inodes after umount
In-Reply-To: <20010720015343.B11236@vestdata.no>
Message-ID: <20010719165758.D50024-100000@wonky.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


I reported this a couple of months back. It's reassuring to know that it's a
consistent problem.

On Fri, 20 Jul 2001, [iso-8859-1] Ragnar Kjørstad wrote:

> On Thu, Jul 19, 2001 at 04:22:07PM -0400, Christian, Chip wrote:
> > I found the same thing happening.  Tracked it down in our case to using fdisk to re-read disk size before mounting.  Replaced it with "blockdev --readpt" and the problem seems to have gone away.  YMMV.
>
> I've now been able to reproduce:
>
> * make a filesystem
> * mount it
> * export it (nfs)
> * mount on remote machine
> * lock file (fcntl)
> * unexport
> * unmount
>
> Then you get the VFS message about self-destruct. Tested with both ext2
> and xfs.
>
> The lock is still present in /proc/locks after the umount.
>
> With ext2 I can remount the filesystem successfully, but with XFS I get
> the message about duplicate UUIDs and the mount failes. I believe this is a totally
> different problem from the one you were experiencing. (and blockdev doesn't help for me)
>
> I suppose this is a generic kernel bug?
>
>
>

