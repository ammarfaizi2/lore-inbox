Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265879AbUGTOEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUGTOEj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 10:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265883AbUGTOEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 10:04:39 -0400
Received: from [138.15.108.3] ([138.15.108.3]:32485 "EHLO mailer.nec-labs.com")
	by vger.kernel.org with ESMTP id S265879AbUGTOEg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 10:04:36 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: Re: encrypt ramdisk
Date: Tue, 20 Jul 2004 10:04:26 -0400
Message-ID: <951A499AA688EF47A898B45F25BD8EE80126D4CF@mailer.nec-labs.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: encrypt ramdisk
Thread-Index: AcRuYndnP4O0KrFoTbCpjQRo2g8y7A==
From: "Lei Yang" <leiyang@nec-labs.com>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I've asked questions about executable on ramdisk on this mailing list and got a lot of useful information here. Most say that since code is already in RAM (as it is in ramdisk), it will be mapped to process address space (text segment) and run in place. This seems very reasonable to me -- kernel will optimize the ram usage and should prevent duplicate copy of code in ram. 

Now I am very confused about loopback device and block device and ...., could anyone please tell me what I should read or where I should refer to so that I can get a better understanding as how this all works inside? I've been searching around and it seems that all the documents are about how to use a loopback device, none of them (as far as I can see) include a good description as how it actually works and what the kernel does to make it work.

Thanks very much! Really appreciate any help.
Lei

-----Original Message-----
From: Jan Hudec [mailto:bulb@vagabond.light.src]On Behalf Of Jan Hudec
Sent: Monday, July 19, 2004 7:23 PM
To: Lei Yang
Cc: kernelnewbies@nl.linux.org
Subject: Re: encrypt ramdisk


On Mon, Jul 19, 2004 at 11:51:43 -0400, Lei Yang wrote:
> Hello,
> 
> Can I set up a ramdisk and use loopback encryption to encrypt it?
> As far as I understand, the OS will keep data encrypted on the hard 
> disk at all times and decrypts it in RAM only as it's read. So an encrypted 
> executable on physical hard disk will be decrypted page by page upon
> reading to RAM. But what happens to an executable sitting in ramdisk?
> Can I also encrypt it? Since the code is in RAM, it should be running in place,
> how do kernel deal with encrypted code and run? 

A code on ramdisk will NOT be running inplace. A code on tmpfs will --
and you can't mount that over loopback.

There are two layers -- a block device and a filesystem. The block
device reads and writes blocks -- and from filesystem's point of view,
it does not matter where they are stored in the end.

A ramdisk is a block device. The filesystem talks to it as if it was
a real disk.

The loopback is a virtual block device implemented in terms of something
able to read and write -- which might be another block device or a file.
Even if ramdisk was optimized to not copy the data (I really don't know
whether it is), it wouldn't affect it's behaviour. The loopback reads
the data, filters them and passes them on to the filesystem, copying
them in the process.

On the other hand tmpfs is a filesystem that does not use block device.
It keeps the data in cache. So they are executed and mmapped in place,
but there is no place to put a crypto loop in.

> Any comments?
> 
> Thanks in advance!
> Lei
> 
> --
> Kernelnewbies: Help each other learn about the Linux kernel.
> Archive:       http://mail.nl.linux.org/kernelnewbies/
> FAQ:           http://kernelnewbies.org/faq/
> 
-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

