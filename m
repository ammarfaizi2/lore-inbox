Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270667AbUJUKu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270667AbUJUKu7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 06:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270484AbUJUKsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 06:48:54 -0400
Received: from [195.23.16.24] ([195.23.16.24]:28061 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S270635AbUJUKoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 06:44:10 -0400
Message-ID: <417792F0.20008@grupopie.com>
Date: Thu, 21 Oct 2004 11:44:00 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mildred Frisco <mildred.frisco@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: making a linux kernel with no root filesystem
References: <e7b30b2404102102466dc71118@mail.gmail.com> <e7b30b24041021030535925d1d@mail.gmail.com>
In-Reply-To: <e7b30b24041021030535925d1d@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.3; VDF: 6.28.0.26; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mildred Frisco wrote:
> Hi,
> I would like to ask help in compiling a minimal linux kernel.
> Basically, it would only contain the kernel andno filesystem (or
> probably devfs).  I would only have to boot the kernel from floppy.
> Then after the necessary kernel initializations, I would issue a
> prompt where I can either shutdown or reboot the system. That's the
> only functionality required.  As I've learned from the init program
> (and startup scripts), the init services and shutdown commands are
> called from /sbin. However, I do not require to mount the root fs
> anymore.  I also tried to search for the source code of the shutdown
> program but I can't find it.  Please help on the steps that I should
> do.

Your /sbin/init can be a simple script (or even just bash or another shell).

You can use statically compiled binaries against dietlibc from here:

ftp://foobar.math.fu-berlin.de:2121/pub/dietlibc/bin-i386/

If you use "ash" as /sbin/init and place busybox there with the 
appropriate symlinks, you get a small semi-functional shell for a mere 
120kb of executables.

If you're really desperate for space, you can build your own executable 
that asks for shutdown/reboot and calls reboot(2) with the appropriate 
parameters, and link against dietlibc (or ulibc).

This is not really kernel related and you should not mess with the 
kernel code for acomplishing this. If you really need to cut down extra 
space in the kernel you can check the patches from the "tiny" tree to 
build an incredibly small kernel.

I hope this helps,

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
