Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbVFVTr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbVFVTr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 15:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVFVTr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 15:47:29 -0400
Received: from alog0519.analogic.com ([208.224.223.56]:14532 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261949AbVFVTqY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 15:46:24 -0400
Date: Wed, 22 Jun 2005 15:45:28 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: George Kasica <georgek@netwrx1.com>
cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem compiling 2.6.12
In-Reply-To: <Pine.LNX.4.62.0506221413560.25918@eagle.netwrx1.com>
Message-ID: <Pine.LNX.4.61.0506221530040.11457@chaos.analogic.com>
References: <Pine.LNX.4.62.0506221026130.4837@eagle.netwrx1.com>
 <9a874849050622085975b67c06@mail.gmail.com> <Pine.LNX.4.62.0506221413560.25918@eagle.netwrx1.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005, George Kasica wrote:

> Tried that here and got not much farther...here's the error:
>

So how does a kernel compile end up accessing:

> In file included from /usr/include/linux/errno.h:4,
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In /usr/src there used to be a simlink called /usr/src/linux. It
was a link to /usr/src/linux-`uname -r`. This was also sim-linked
to /usr/include/linux.  There is a possibility that if you
renamed your new /usr/src-linux-2.6.12 to /usr/src/linux, it
overwrote the headers that your 'C' library was compiled with.

After that, all bets are off. To fix, remove the link, /usr/include/linux
and link it to where it used to be as:

 	ln -sf /usr/src/linux-2.4.31/include/linux /usr/include/linux
 	ln -sf /usr/src/linux-2.4.31/include/asm   /usr/include/asm

That should permanently isolate your old 'C' runtime library
include files from new kernel headers.

Then don't use anything called /usr/src/linux. Use the complete
name like /usr/src/linux-2.6.12. That way, these things don't
happen.



> [root@eagle linux]# make bzImage
>   CHK     include/linux/version.h
>   SPLIT   include/linux/autoconf.h -> include/config/*
>   HOSTCC  scripts/mod/sumversion.o
> In file included from /usr/include/linux/errno.h:4,
>                  from /usr/local/include/bits/errno.h:25,
>                  from /usr/local/include/errno.h:36,
>                  from scripts/mod/sumversion.c:8:
> /usr/include/asm/errno.h:4: asm-generic/errno.h: No such file or directory
> make[2]: *** [scripts/mod/sumversion.o] Error 1
> make[1]: *** [scripts/mod] Error 2
> make: *** [scripts] Error 2
>
>
> On Wed, 22 Jun 2005, Jesper Juhl wrote:
>
>> On 6/22/05, George Kasica <georgek@netwrx1.com> wrote:
>>> Hello:
>>>
>>> Trying to compile 2.6.12 here and am getting the following error. I am
>>> currently running 2.4.31 and have upgraded the needed bits per the Change
>>> document before trying the build:
>>>
>>> [root@eagle src]# cd linux
>>> [root@eagle linux]# make mrproper
>>>    CLEAN   .config
>>> [root@eagle linux]# cp ../config-2.4.31 .config
>>> [root@eagle linux]# make oldconfig
>>
>> Don't use a 2.4.x config as the basis for a 2.6.x kernel .
>> Build your first 2.6.x kernel config using "make menuconfig", "make
>> config", make xconfig" or similar, /then/ you can use that config in
>> the future as a base for other 2.6.x kernels with "make oldconfig".
>>
>> --
>> Jesper Juhl <jesper.juhl@gmail.com>
>> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
>> Plain text mails only, please      http://www.expita.com/nomime.html
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
