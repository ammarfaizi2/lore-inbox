Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315261AbSDWQ6Z>; Tue, 23 Apr 2002 12:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315263AbSDWQ6Y>; Tue, 23 Apr 2002 12:58:24 -0400
Received: from dsl3-63-249-88-76.cruzio.com ([63.249.88.76]:31383 "EHLO
	athlon.cichlid.com") by vger.kernel.org with ESMTP
	id <S315261AbSDWQ6X>; Tue, 23 Apr 2002 12:58:23 -0400
Date: Tue, 23 Apr 2002 09:58:14 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200204231658.g3NGwE203196@athlon.cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: dnotify oddity in 2.4.19pre6aa1
Cc: sfr@canb.auug.org.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing something very strange with the dnotify feature in kernel
2.4.19pre6aa1. I'm developing a file copy daemon that makes backups of
files as soon as they change so I run dnotify on every directory in my
system (essentially). I based my program on the example in dnotify.txt
in the Documentation directory.

I notice that after a while two things happen:

1) In my copyd process I start getting signals for directories that are not
changing. Even stranger, I get signals for fd that I've never opened.

2) Other processes, like sendmail, start exiting with the same signal
(RTMIN+5). (I use +5 because I started seeing the problem with +0 and I
took a wild guess that RTMIN+0 was being used for something else).

This does not seem to happen if I reboot and do not restart my copyd process.

My system does cycle through process descriptors every few minutes (lots of
short lived server processes) and sendmail also runs through pids rapidly.

I'm wondering if something isn't being properly reset or cleared when a process
exits so when the same process or fd data structure (or whatever) is reused inside
the kernel the signals are still active somehow? This is a SMP Athlon, perhaps
an SMP race?

Do I need to configure something more in my kernel? I don't see any config
options for realtime or rt or anything like that. And it does work fine after
a reboot.

I can't use ordinary signals for this because they miss dnotifys when activity
is high.

Thanks very much
Andrew

