Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbTIUC4l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 22:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbTIUC4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 22:56:41 -0400
Received: from mail.g-housing.de ([62.75.136.201]:63206 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262282AbTIUC4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 22:56:38 -0400
Message-ID: <3F6D134E.2080505@g-house.de>
Date: Sun, 21 Sep 2003 04:56:14 +0200
From: evil <evil@g-house.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030901
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: lockups with 2.4.2x
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi y'all,

i am in the need of some help tracing down mysterious lock-ups of my
machine. with any vanilla kernel above 2.4.19 the machine boots, the it
will take 1 to 3 minutes and the machine freezes. no Oops on the
console, no warnings (e.g. no high load or mem-pressure), even SysReq is
not working.

i've already setup a script, writing

/proc/modules|locks|ksyms

to the disk every 2 seconds, because i suspected some 3rd party module i
usually load to be the reason for the freezes. but it was not. please
tell me, if other files are more interesting for this or what else i can
do to get to the source to the problem.

the machine:
Dual Athlon, 1GB RAM (HighMem enabled), gcc 3.3.1, libc 2.3.2,
(Debian/Testing) some more infos are on:

http://nerdbynature.de/bits/freeze/config|cpuinfo|dmesg|lspci

(directory listing follows...)

I really appreciate some help here, i don't know where to start
searching since no errors are shown :-(

below are some further infos, but i don't know if they are related to
this issue.

Thank you for your time,
Christian.

before this whole mess i was using 2.4.19, but i wanted to upgrade to
2.4.20, 2.4.21, did not make it, due to lack of time or need. 2.4.19 was
running fine. but i need netfilter now, so i had to recompile
modules+kernel!  but, mysteriously, i fail to recompile my 2.4.19. i did
"make mrproper", then even untar'ed a new archive, took the old config,
"make oldconfig" went ok. then
"make dep bzImage modules modules_install" stops within "bzImage":

net/network.o(.text+0xf125): In function `rtnetlink_rcv':
: undefined reference to `rtnetlink_rcv_skb'
make: *** [vmlinux] Error 1

there was another issue with a vanilla 2.4.19, but i tried to fix it:

http://nerdbynature.de/bits/freeze/semaphore.c.patch

hm, is this gcc related? it did not like some missing "" terminations.
ok, after fixing this, the error above showed up.

so, i thought it was time to try 2.4.2x (now 2.4.22), but am somehow
stuck now. on some completely other machines (PPC32 + single
AMD/Athlon), 2.4.2x are running very fine.



