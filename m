Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAFDNe>; Fri, 5 Jan 2001 22:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbRAFDNY>; Fri, 5 Jan 2001 22:13:24 -0500
Received: from ha1.rdc2.nsw.optushome.com.au ([203.164.2.50]:27788 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S129324AbRAFDNQ>; Fri, 5 Jan 2001 22:13:16 -0500
Message-Id: <4.3.2.7.2.20010106140627.00b06c60@mail>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 06 Jan 2001 14:22:35 +1100
To: Gregor Essers <gregor.essers@web.de>, linux-kernel@vger.kernel.org
From: Cefiar <cefiar1@optushome.com.au>
Subject: Re: bug of Nvidia (0.9.5) Drivers in 2.4 Kernel Enviroment
In-Reply-To: <01010522072100.03671@saintx.saintx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:07 PM 5/01/01 +0100, Gregor Essers wrote:
> From the pre9 relaese to the final of the 2.4 Kernel i become this Errors,
>can someone help me or have someone an idea what this mean ??.
>
>I will build this with the src.rpm from Nvidia with the spec file
>
>In file included from nv.c:52:
>nv.h:131: warning: #warning This driver is not officially supported on
>post-2.2
>kernels
>nv.c: In function `nv_lock_pages':
>nv.c:556: warning: implicit declaration of function `mem_map_inc_count'
>nv.c: In function `nv_unlock_pages':
>nv.c:583: warning: implicit declaration of function `mem_map_dec_count'
>nv.c: At top level:
>nv.c:853: unknown field `unmap' specified in initializer
>nv.c:853: warning: initialization from incompatible pointer type
>make: *** [nv.o] Fehler 1
>Bad exit status from /var/tmp/rpm-tmp.37085 (%build)

You need to patch the Nvidia kernel driver to handle changes made in the 
2.4 tree. You can either:

1> Get on irc (Server: irc.openprojects.net, Channel #nvidia) and request 
the patch from there. (You need to be able to do DCC transfers for this to 
work). There is patches for 2.4.0-test1[0-3] and for 
2.4.0-[prerelease/final], so get what you need that way. The bot to request 
from is usually iCE-DCC, and you can request a list using '/msg iCE-DCC 
xdcc list' and request a file using eg: '/msg iCE-DCC xdcc send #10' (if 
you wanted file 10 that is).

2> Alternatively, if you e-mail me, I could probably forward you the patch 
or, if people don't mind too much, I could post it to the list (I'll wait 
for comments on this first!).

The patch is about 1k for test10, and about 3k for prerelease/final. 
Remember, this patches Nvidia's driver shim source code, and not the 
kernel. You could unpack the .src.rpm and add the patch to the compile 
process if you were really game, but I did it from the .tar.gz and it works 
fine for me. YMMV of course.

BTW: Common problem is that people complain that the make still gets 
includes wrong. Make sure you compile the kernel and it's modules 
completely. I compiled the kernel and modules, rebooted into the new 
kernel, and then compiled the Nvidia driver. The last step of Nvidia's make 
process (for the .tar.gz) is to actually insmod the driver to make sure it 
worked, which will probably fail on any other version of the kernel.

Of note: Nvidia have a new driver in the works, that should be much nicer 
re: kernel interface.

--
  -=[ Stuart Young (Aka Cefiar) ]=-------------------------------
  | http://amarok.glasswings.com.au/ | cefiar1@optushome.com.au |
  ---------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
