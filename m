Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbRCBOli>; Fri, 2 Mar 2001 09:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129212AbRCBOl2>; Fri, 2 Mar 2001 09:41:28 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:14611 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129199AbRCBOlL>; Fri, 2 Mar 2001 09:41:11 -0500
Message-ID: <3A9FADAB.F37E5449@eikon.tum.de>
Date: Fri, 02 Mar 2001 15:26:51 +0100
From: Mario Hermann <ario@eikon.tum.de>
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.2-ac8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: report bug: System reboots when accessing a loop-device over a 
 second loop-device with 2.4.2-ac7
In-Reply-To: <3A9E66BB.70FB0C75@eikon.tum.de> <20010301172145.T21518@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Jens Axboe wrote:
> 
> On Thu, Mar 01 2001, Mario Hermann wrote:
> > I tried the following commands with 2.4.2-ac7:
> >
> > losetup /dev/loop0 test.dat
> > losetup /dev/loop1 /dev/loop0
> > mke2fs /dev/loop1
> >
> > My System reboots immediatly. I tried it with 2.4.2-ac4,ac5 too -> same
> > effect.
> >
> > With 2.4.2 it hangs immediatly.
> 
> This should make it work again.

There is another small bug with the loop over loop problem. Now it works
fine for
files but not for Devices:

losetup /dev/loop0 /dev/sr1
losetup /dev/loop1 /dev/loop0
dd if=/dev/loop1 of=test.dat bs=2048 count=1024

Makes dd hang. (BTW: /dev/sr1 is a CD-ROM)

Tried the same on /dev/hda1, /dev/sda1 with 2.4.2-ac7-your_patch and
with 2.4.2-ac8.

BTW: Did extensiv testing with and without the crypto patches. And all
other tests worked fine! :-)

--
Mario Hermann
