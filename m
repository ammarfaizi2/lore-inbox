Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbVDAOAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbVDAOAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 09:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVDAOAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 09:00:48 -0500
Received: from indonesia.procaptura.com ([193.214.130.21]:22681 "EHLO
	indonesia.procaptura.com") by vger.kernel.org with ESMTP
	id S262746AbVDAOAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 09:00:40 -0500
Message-ID: <424D5407.6070003@procaptura.com>
Date: Fri, 01 Apr 2005 16:00:39 +0200
From: Toralf Lund <toralf@procaptura.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel load issues (insmod segfault)
References: <424D467F.3090700@procaptura.com>
In-Reply-To: <424D467F.3090700@procaptura.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toralf Lund wrote:

> Hi.
>
> I thought I might try this one again (with updated code and more 
> compete info):

Right. I think maybe I've made some kind of stupid mistake. Sorry.

I looked, and looked again, and just couldn't find anything wrong with 
the module (so it must be the kernel, right?), but I looked the wrong 
place, of course. It was the build flags, not the source code...

[ ... ]

>
>
> # make itifg8tst.o
> gcc -pipe -Wall -O2  -DLinux -mcpu=i686 -I../../include -fno-common 
> -fno-strict-aliasing -fomit-frame-pointer -nostdinc -I. 
> -I/lib/modules/2.6.11.4-0.EL.toralf/build/include 
> -I/usr/lib/gcc/i386-redhat-linux/3.4.3/include -D__KERNEL__ -DMODULE 
> -I/lib/modules/2.6.11.4-0.EL.toralf/build/include/asm-i386/mach-default 
> -o itifg8tst.o -c itifg8tst.c

It seems like this is not quite right. I've now changed this build flags 
based on the module build setup of the kernel sources, so that I have

gcc    -DLinux -mpreferred-stack-boundary=2 -fno-unit-at-a-time 
-march=i686 -mregparm=3  -I../../include -fno-strict-aliasing 
-fno-common -ffreestanding -fomit-frame-pointer -nostdinc -I. 
-I/lib/modules/2.6.11.4-0.EL.toralf/build/include -isystem 
/usr/lib/gcc/i386-redhat-linux/3.4.3/include -D__KERNEL__ -DMODULE 
-I/lib/modules/2.6.11.4-0.EL.toralf/build/include/asm-i386/mach-default 
-o itifg8.mod.o -c itifg8.mod.c

and the module works!

I'm not sure what exactly did the trick, though. (Although I guess the 
distinction between -march and just -mcpu might be significant.). If 
someone would like to explain more about the different flags, just go 
ahead....

- Toralf

