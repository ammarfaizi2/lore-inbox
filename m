Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275270AbRJaXOB>; Wed, 31 Oct 2001 18:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275278AbRJaXNv>; Wed, 31 Oct 2001 18:13:51 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:12061 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S275270AbRJaXNg>; Wed, 31 Oct 2001 18:13:36 -0500
Posted-Date: Wed, 31 Oct 2001 23:13:22 GMT
Date: Wed, 31 Oct 2001 23:13:22 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Ville Herva <vherva@niksula.hut.fi>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Need blocking /dev/null
In-Reply-To: <20011031112303.A26218@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.21.0110312256030.28028-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ville.

>>> PS Are /dev/null and /dev/zero also redundant?

>> I regularly use both...
>> 
>>  1. Find a download that doesn't appear where one expected it...
>> 
>> 	find / -name "wanted-but-lost-download" 2> /dev/null
>> 
>>  2. Create a loop-mounted partition to populate as a CD image before
>>     burning the CD in question.
>> 
>> 	dd if=/dev/zero bs=1048576 count=750 of=/tmp/cd.img
>> 	mke2fs /tmp/cd.img
>> 	mount -o loop /tmp/cd.img /img/cd
>> 
>>  3. Create a loop-mounted partition to populate as a floppy image.
>> 
>> 	dd if=/dev/zero bs=1024 count=1440 of=/tmp/floppy.img
>> 	mke2fs /tmp/floppy.img
>> 	mount -o loop /tmp/floppy.img /img/floppy
>> 
>> Neither has alternatives that make sense as far as I can see.

> Certainly have in the sense that you could theoretically do that in
> user space.

Are you sure?

> find / -name "wanted-but-lost-download" | eat

Doesn't work - you're piping the stdin there, not stderr as per my
example above. AFAIK, there's no way to pipe stderr without also piping
stdout, hence this sort of solution just doesn't work.

AFAICS, there is no sane alternative to /dev/null in userspace.

> zerofill | head -c 1440k > /tmp/floppy.img

How does zerofill know when to stop writing zeros out? After all, if it
doesn't write enough out for the head call, then it's no longer an
equivalent to /dev/zero, and it could easily be called with just about
ANY positive number of bytes, including an infinite number, as in...

	zerofill | tr '\0' '@' > /dev/ttyS1

...which sends an infinite stream of 0x40 bytes to the serial port.

However...

	zerofill 750M  > /tmp/img.cd
	zerofill 1440k > /tmp/img.floppy

...would be a reasonable userspace equivalent to examples (2) and (3)
respectively, so that certainly could be done in userspace.

> ssh foo@bar | block

Which of my examples is this an equivalent to? I don't recognise it.

> (Implementation of eat, block and zerofill is left as an
> exercise...)

I'll leave that to somebody with more unwanted time than I have...

Best wishes from Riley.

