Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277776AbRJIPhK>; Tue, 9 Oct 2001 11:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277778AbRJIPg5>; Tue, 9 Oct 2001 11:36:57 -0400
Received: from smtp-out.student.liu.se ([130.236.230.80]:49215 "EHLO elysium")
	by vger.kernel.org with ESMTP id <S277776AbRJIPg2> convert rfc822-to-8bit;
	Tue, 9 Oct 2001 11:36:28 -0400
Date: Tue, 09 Oct 2001 17:38:14 +0200 (CEST)
From: paran213@student.liu.se
Subject: ISSUE: vm bug? in 2.4.10
In-Reply-To: <Pine.LNX.4.40.0110091001250.114-100000@rc.priv.hereintown.net>
X-X-Sender: per@p114.ryd.student.liu.se
To: linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.40.0110091652060.629-100000@p114.ryd.student.liu.se>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I am having serious problems with the vm in 2.4.10.
Here is my bugrepport:

System configuration:
Debian GNU/Linux 2.2 potato, bunks .deb files for kernel 2.4
gcc version 2.95.2 20000220 (Debian GNU/Linux)
600M swap

Hardware:
AMD K6-2 400MHz (66*6)
AOpen AP5T motherboard
160M SDRAM
580M swap

Tested kernel versions:
2.4.9        ok
2.4.10       crashes
2.4.10-ac4   ok
2.4.10-ac10  ok
I also compiled 2.4.10 with only a minimum of options selected in my
kernel config. No modules, no network, no k6 optimisations (used i386),
nothing that isn't neccessary to start the system. But I still got the
same problem with 2.4.10


Problem desciption (On 2.4.10):
When I run a command that use up all the main memory my console immediately fills upp with
lots of messages like this:

"__alloc_pages: 0-order allocation failed (gpf=0x1d2/0) from c01232ee"
and then
"VM: killing process X"

where X is any process that happens to be running, from bash to syslogd and even init.
This kills all my processes in a couple of seconds.
Then everything but my login is killed. But when I try
to log in (even if I wait a long time) I immediately gets the errors. I
cant reboot by ctrl+alt+del either since VM kills shutdown.. So I have to
manually reboot the machine.


How to replicate the problem:
When I tested the various kernels I made a 200M file with:
"dd if=/dev/zero bs=10k of=/tmp/bigfile count=20k"
And then ran "md5sum /tmp/bigfile"
It works fine on 2.4.10 untill the main memory is full, then the problem
occurs. The command executes fine on all the other tested kernels.

Acctually, this was how I discovered the problem. After having upgraded to
2.4.10 I was going to check the md5sum of a linux-mandrake .iso i
downloaded for my brother. But thats of-topic ;)


Best Regards
Pär Andersson




















