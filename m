Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318681AbSG0CbB>; Fri, 26 Jul 2002 22:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318682AbSG0CbB>; Fri, 26 Jul 2002 22:31:01 -0400
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:35081
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S318681AbSG0CbA>; Fri, 26 Jul 2002 22:31:00 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: riel@conectiva.com.br
X-Envelope-Sender: stevie@qrpff.net
Message-Id: <5.1.0.14.2.20020726221324.021ad588@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 26 Jul 2002 22:34:11 -0400
To: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>
From: Stevie O <stevie@qrpff.net>
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Cc: Cort Dougan <cort@fsmlabs.com>, Christoph Hellwig <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0207251941120.3086-100000@imladris.surriel.
 com>
References: <20020725205910.GR1180@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:41 PM 7/25/2002 -0300, Rik van Riel wrote:

>> valuable for what? you need the system.map or the .o disassembly of the
>> module anyways to take advantage of such symbol. I don't find it useful.
>
>If you're willing to teach all our users how to use ksymoops ... ;)

A story:

        I'm not an experienced kernel hacker -- most of my questions probably belong on the kernelnewbies list.  I am also, however, not afraid to muck around, which is why I run Slackware and a completely self-configured kernel.  It just so happens that I run Linux on my laptop, and thus my kernel is reiserfs-only (I didn't even build ext2 as a module, and I'm not going to count iso9660fs).

        About four months ago, I decided to try my very first 2.5 kernel ever, 2.5.7.  [As many of you know -- just as I do now -- Al Viro did some cleanups which caused an oops when your rootfs was reiserfs.]  I downloaded, I configured, I built, and I lilo'ed.  And when I booted 2.5.7 for the first time, I got my very first kernel oops -- woo!

        First thing I noted was that, since my rootfs didn't even get mounted at all, let alone read-write, I had no logfiles to work with. So I painstakingly copied the large pile of hex values down on paper and booted back to 2.5.7.  Lucky for me, the oops happened at boot time, so there were no modules to be mucked with :)  Having been on lkml for several months thus far,  I knew exactly what to do -- run ksymoops.  So I went to /usr/src/linux-2.5.7/scripts/ksymoops/, and the only file there was a README telling me that ksymoops was no longer distributed as part of the kernel, and that I needed to download it.

Great.

        I downloaded ksymoops, and it wouldn't compile.  I got some bizarre errors about undefined symbols (relating to libbfd), and googling for those errors gave people having those same problems, yet no responses.
After much grief I somehow finally determined that I needed new copies of libiberty and libbfd installed.
I downloaded and installed the new versions of libiberty and libbfd and was finally able to build ksymoops.

        Once ksymoops was built, I carefully reproduced the oops I had transcribed to paper into a file and ran
ksymoops against it.  At long last, I was rewarded with my decoded oops output, informing me that the crash had occurred in reiserfs code.  I posted an e-mail to the list and was immediatly replied to that this was a known problem and that a patch was already available :P

The Moral Of The Story

It took me several hours to get my oops decoded.  Most people don't have several hours to waste tracking down subtle bugs in userspace libraries and programs.  Requiring users to run ksymoops, if a working alternative (such as this patch) exists, is NOT a good idea.


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

