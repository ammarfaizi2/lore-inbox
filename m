Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTEYUWc (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 16:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTEYUWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 16:22:32 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:32132 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S263737AbTEYUWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 16:22:30 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.69-mm9
Date: Sun, 25 May 2003 21:35:36 +0100
User-Agent: KMail/1.5.9
References: <200305251619.40137.alistair@devzero.co.uk> <20030525131512.45ce0cc2.akpm@digeo.com>
In-Reply-To: <20030525131512.45ce0cc2.akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YkS0+cnbht2PbjX"
Message-Id: <200305252135.37109.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_YkS0+cnbht2PbjX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 25 May 2003 21:15, you wrote:
>
> Changing fstab will not cause / to be mounted by ext2: the kernel makes the
> decision for /.  You may be able to use "rootfstype=" (I don't think I've
> ever tried it).
>
> The proper way to convert to ext2 is:
>
> - boot with init=/bin/sh
>
> - /sbin/tune2fs -O ^has_journal /dev/hda1
>
> - /sbin/e2fsck -fy /dev/hda1
>
> - reboot, edit /etc/fstab for the non-root filesystems.

Thanks for this info. I just removed the journal and now have / mounted 
permanently as ext2. -mm9 got to login without a problem. I deliberately kept 
my /home volume as ext3 but commented it out in /etc/fstab.

I logged in as root and did:

mount -t ext3 /dev/discs/disc0/part3 /home

This also worked fine, I could read all the files on the volume. However, when 
I did:

touch /home/tmp
sync

The kernel barfed out the attached junk and the file was never committed. The 
volume was not corrupted as I was able to reboot with -mm6 and all is fine. 
tmp does not exist on the volume.

Presumably this is of more help to you. Since / is now ext2, I'm unencumbered 
and so will be able to test anything you like.

Cheers,
Alistair.

--Boundary-00=_YkS0+cnbht2PbjX
Content-Type: application/x-gzip;
  name="oopses.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="oopses.gz"

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

--Boundary-00=_YkS0+cnbht2PbjX--
