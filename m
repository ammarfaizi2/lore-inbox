Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314672AbSEBR4M>; Thu, 2 May 2002 13:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314686AbSEBR4L>; Thu, 2 May 2002 13:56:11 -0400
Received: from [195.63.194.11] ([195.63.194.11]:21263 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314672AbSEBR4K>; Thu, 2 May 2002 13:56:10 -0400
Message-ID: <3CD16F03.9090900@evision-ventures.com>
Date: Thu, 02 May 2002 18:53:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <E173HX6-00041D-00@the-village.bc.nu> <3CD13FF3.5020406@evision-ventures.com> <3CD15996.8EB1699F@redhat.com> <200205021559.g42Fxud19755@vindaloo.ras.ucalgary.ca> <3CD15CFA.1090208@evision-ventures.com> <20020502132552.G8073@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Arjan van de Ven napisa?:

> 
>>It just DOES NOT BELONG in to the kernel-space.
> 
> 
> That's why it's done by modutils.
> 

Last time I checked on Linux:

[root@kozaczek j2me]# ls -l /proc/ksyms
-r--r--r--    1 root     root            0 Mai  2 19:42 /proc/ksyms

Compare this with the following on Solaris:

www01:/kernel/drv# ls sy sy.conf
sy       sy.conf
www01:/kernel/drv# file sy
sy:             ELF 32-bit MSB relocatable SPARC Version 1
www01:/kernel/drv# cat sy.conf
#
# Copyright (c) 1992, by Sun Microsystems, Inc.
#
#ident  "@(#)sy.conf    1.4     93/06/03 SMI"

name="sy" parent="pseudo" instance=0;
www01:/kernel/drv#
www01:/kernel/drv# nm sy
0000000000000014 T _fini
0000000000000028 T _info
0000000000000000 T _init
                  U cdev_ioctl
                  U cdev_poll
                  U cdev_read
                  U cdev_write
  ....
0000000000000278 T syclose
0000000000000488 T syioctl
0000000000000140 T syopen
00000000000005b0 T sypoll
0000000000000280 T syread
0000000000000384 T sywrite
www01:/kernel/drv# strings sy
Indirect driver for tty 'sy'
www01:/kernel/drv#

And then think about the fact that they are able to even *patch*
running kernels. There is no way I can be convinced that the whole
versioning stuff is neccessary or a good design for any purpose.

