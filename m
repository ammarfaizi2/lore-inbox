Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267050AbUBMPWi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 10:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267052AbUBMPWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 10:22:38 -0500
Received: from mail2-116.ewetel.de ([212.6.122.116]:33155 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S267050AbUBMPWf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 10:22:35 -0500
To: "Andrey Borzenkov" <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initrd Question
In-Reply-To: <1oMkR-1Zk-21@gated-at.bofh.it>
References: <1oMkR-1Zk-21@gated-at.bofh.it>
Date: Fri, 13 Feb 2004 16:23:46 +0100
Message-Id: <E1ArfAQ-00007f-7Z@localhost>
From: der.eremit@email.de
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004 15:20:13 +0100, you wrote in linux.kernel:
>>> echo 0x0100 > /proc/sys/kernel/real-root-dev
>> This makes no sense as you're using pivot_root. 
> this makes all sort of sense. Please check sources. It is required so
> that kernel will not attempt to mount root passed to it by loader.
> You are welcome to clean up the code :)

I'm not doing that and it works as expected. Note that the initrd code
in question never exits. It execs init. So when would the kernel do
this attempted mount of the root filesystem passed in by the bootloader?
My understanding is that the old, non-pivot_root method works by
exiting the initrd script - and *then* the kernel attempts to mount
real-root-dev.

In any case, if that wasn't clear, I expect the bootloader to pass
in root=/dev/ram0 anyway. ;)

>>> mount -n -o ro /dev/sda2 /new_root
>>
>> This doesn't even match with the 0x0100 above, now does it?
>
> so what? kernel happily ignores real-root-dev, it is possible that
> some user-level tools may be confused but I have not seen any so far.

Now you're saying the kernel ignores real-root-dev, while a moment
before you state that it is important to set real-root-dev because
otherwise the kernel does something. Which is it?

>>> pivot_root /new_root /new_root/initrd
>> You should cd into /new_root before running pivot_root,
> Huh? Why?
>
> SYNOPSIS
>        pivot_root new_root put_old

And just a couple of lines further down:

       Note that, depending on the implementation of pivot_root, root and  cwd
       of  the  caller  may or may not change. The following is a sequence for
       invoking pivot_root that works in either case, assuming that pivot_root
       and chroot are in the current PATH:
                            
       cd new_root
       pivot_root . put_old
       exec chroot . command

The pivot_root(2) manpage states the same, by the way.
                                                 
-- 
Ciao,
Pascal
