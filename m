Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271814AbRICU5Z>; Mon, 3 Sep 2001 16:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271817AbRICU5P>; Mon, 3 Sep 2001 16:57:15 -0400
Received: from hera.cwi.nl ([192.16.191.8]:7585 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S271814AbRICU5M>;
	Mon, 3 Sep 2001 16:57:12 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 3 Sep 2001 20:57:29 GMT
Message-Id: <200109032057.UAA36797@vlet.cwi.nl>
To: bcrl@redhat.com, torvalds@transmeta.com
Subject: Re: [resend PATCH] reserve BLKGETSIZE64 ioctl
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Ben LaHaise <bcrl@redhat.com>

    Is there any problem with the patch below for reserving a 64 bit get block
    device size ioctl?

    +#define BLKBSZGET  _IOR(0x12,110,sizeof(u64))
     #define BLKBSZGET  _IOR(0x12,112,sizeof(int))

Yes.

(1) As you can see you'll only get redefinition complaints.
In other words, there is a B too much in the ioctl name.

(2) We just concluded that 108-111 have been used for various
private purposes. If we avoid 108-111 in all official kernels
then nobody will be surprised if he ever uses some system
utility that uses one of these.
Thus, it is a very bad idea to want to use these again.

(3) Soon we'll all need a BLKGETSIZE64 ioctl, that gives
the size of a block device in bytes. Your proposed ioctl
gave the size in blocks if I recall correctly.
So, if you have to change the name and the number,
you might as well change the definition.

Andries


[We might reserve an area for private use - some ioctl numbers
that are guaranteed never to become part of an official kernel.]


