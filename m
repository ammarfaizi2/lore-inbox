Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261698AbREOXYW>; Tue, 15 May 2001 19:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261699AbREOXYM>; Tue, 15 May 2001 19:24:12 -0400
Received: from mailb.telia.com ([194.22.194.6]:28947 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S261698AbREOXYF>;
	Tue, 15 May 2001 19:24:05 -0400
Message-ID: <3B01BA4A.E5108061@canit.se>
Date: Wed, 16 May 2001 01:22:50 +0200
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chip Salzenberg <chip@valinux.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105150204020.1078-100000@penguin.transmeta.com> <E14zb68-0002Fq-00@the-village.bc.nu> <20010515144020.H3098@valinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip Salzenberg wrote:

> According to Alan Cox:
> > Given a file handle 'X' how do I find out what ioctl groups I should
> > apply to it.
>
> Wouldn't it be better just to *try* ioctls and see which ones work and
> which ones don't?

As ioctl's is just numbers that can be valid but mean totally different thing depending on device I don't see how this is going to work. It took me close to a month to figure out why my new 10000rpm scsi disk constantly ended up with a read only filesystem. What I did not know at that time was that the /dev/sg[x] numbering was changed by adding something to the scsi chain and my backup software now sent the eject command to the disk instead of to the tape. This ioctl means spinn down when it is sent to the disk and that in turn produces a fatal error and a remount to ro for the mounted filesystem.

This problem had not existed for me if things had been mapped more static this i why I'am not overly happy hearing that things is going to be even more volatile. But I guess that it's possible to solve most of this issues in userspace.

One way of looking on the problem is to take it to it's logical extrem. This would be a kernel with no persistent storage for devices no major,minor and no name policy. The kernel would simply put any device it finds in /dev/devno/[x] where x is just a number that should be seen as something that changed for every reboot.

Any userspace solution that can create device links that are stable out of this is one that would get my vote. This obviously needs some type if standard why to query the devices or else it's no way it can work.


