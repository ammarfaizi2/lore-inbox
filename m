Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132651AbQKZTmn>; Sun, 26 Nov 2000 14:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132686AbQKZTmd>; Sun, 26 Nov 2000 14:42:33 -0500
Received: from www.ylenurme.ee ([193.40.6.1]:39930 "EHLO ylenurme.ee")
        by vger.kernel.org with ESMTP id <S132651AbQKZTmS>;
        Sun, 26 Nov 2000 14:42:18 -0500
Date: Sun, 26 Nov 2000 21:11:59 +0200 (GMT-2)
From: Elmer Joandi <elmer@ylenurme.ee>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <Pine.GSO.4.21.0011261321580.3258-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10011262049480.11180-100000@yle-server.ylenurme.sise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 Nov 2000, Alexander Viro wrote:

> I would suggest you to read through the following book and files:
> 	* Kernighan & Pike, "The Practice of Programming"
> 	* Documentation/CodingStyle
> 	* drivers/net/aironet4500_proc.c
> and consider, erm, discrepancies. On the second thought, reading K&R
> might also be useful. IOW, no offense, but your C is bad beyond belief.

Yep, very true.
aironet4500_proc.c is ugly. And is because there is quickly handwirtten
something that should have been generic for kernel for some long time, not
for every driver-writer to reinvent a wheel.
Note that there is something that virtually elliminates need for
exact user<->kernel level interfaces and userlevel kerneldata manipulation 
programs and lots of other maintenance pains.
And it does it in quite short sentences. Plus, half of that file is direct
repeating of some non-exported kernel functions. But, if you think you can
do better, then look into aironet4500_rid.c and handcode it (like real K&R
people do), instead of using aironet4500_proc.c to operate on it.
Also, pcmcia/aironet4500_cs.c has lots of ugly parts. Those which are
related to stupid masohistic code repetitions due to pcmcia package
interface being "cutting edge optimal stupid"

The same true is that 2.4 kernel is, in commercial production sense, late
for 6 months. And reason being that the codebase and testing becomes
unmanageable. And it becomes unmanageable, because some people only read
K&R and try to optimize last bit out of it with using and old book.

I'd really propose again:
1. universal debug macros
2. universalt user-kernelspace configuration interface via proc/sys

I'd really like C++, but it can be done with C and macros.
Some years ago I even managed to write something like stl container 
withing C and with macros. That was really screwy thing.

elmer.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
