Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129456AbRCBURz>; Fri, 2 Mar 2001 15:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129468AbRCBURg>; Fri, 2 Mar 2001 15:17:36 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:16655 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129456AbRCBURY>; Fri, 2 Mar 2001 15:17:24 -0500
Message-ID: <3A9FDD80.FD075386@eikon.tum.de>
Date: Fri, 02 Mar 2001 18:50:56 +0100
From: Mario Hermann <ario@eikon.tum.de>
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: report bug: System reboots when accessing a loop-device over a 
 second loop-device with 2.4.2-ac7
In-Reply-To: <3A9E66BB.70FB0C75@eikon.tum.de> <20010301172145.T21518@suse.de> <3A9FADAB.F37E5449@eikon.tum.de> <20010302162824.H408@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Jens Axboe wrote:
> 
> On Fri, Mar 02 2001, Mario Hermann wrote:
> > There is another small bug with the loop over loop problem. Now it works
> > fine for
> > files but not for Devices:
> >
> > losetup /dev/loop0 /dev/sr1
> > losetup /dev/loop1 /dev/loop0
> > dd if=/dev/loop1 of=test.dat bs=2048 count=1024
> 
> Pending miscount, this should fix it.


Ok, I did some testing again. What I found:

Without crypto: Everything works good!

With crypto:

I used the ciphers: idea,serbent, aes, blowfish(with small patch in
cipher-blowfish send somewhere in the past)

Only 2.4.2-ac8 Material: Everything is ok. 

With  old 2.2-Material:

Encrypted in the way: 

 losetup -e blowfish /dev/loop0 ./test.file
 losetup -e serpent /dev/loop1 /dev/loop0

It works perfect too! :-)

But with old 2.2 - Material stored on DVD-RAM. 

  losetup -e blowfish /dev/loop0 /dev/sr3
  lsoetup -e serpent /dev/loop1 /dev/loop0

it doesn't work.

Just garbage comes out of the loop-device.
Both, the file on the harddisk and the DVD-RAM are made with 2.2.16 an
patch-int-2.2.16.9 and are working
there perfectly. 

I guess that the problem has maybe something to do with the logical
block number.

Well, for me was the HD-File important to work under 2.4 (DB-on it...)

So great thx from me!

Hope my testing will help in some way. (will do some more monday
afternoon)


---
Mario Hermann
