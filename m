Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129257AbQKYXKG>; Sat, 25 Nov 2000 18:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131856AbQKYXJ4>; Sat, 25 Nov 2000 18:09:56 -0500
Received: from mx1.eskimo.com ([204.122.16.48]:64016 "EHLO mx1.eskimo.com")
        by vger.kernel.org with ESMTP id <S129257AbQKYXJn>;
        Sat, 25 Nov 2000 18:09:43 -0500
Date: Sat, 25 Nov 2000 14:39:35 -0800 (PST)
From: Clayton Weaver <cgweav@eskimo.com>
To: linux-kernel@vger.kernel.org
Subject: reproducible 2.2.1x nethangs
Message-ID: <Pine.SUN.3.96.1001125135348.2443A-100000@eskimo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel versions 2.2.17 and 2.2.18-pre23 (same behavior)
monolithic kernel
i21143 tulip card (may or may not be significant, stock kernel driver)
egcs-1.1.2, glibc-2.1.3, binutils-2.9.1.0.25

I can reliably hang either 2.2.17 or 2.2.18-pre23 (same way, same
circumstances) with httpd over eth0. It is not a particularly exotic
kernel config (ethernet, tulip, dummy, ppp, aha154x, scsi hd/cd/tape,
pio ide, i486, generic pci driving an sis496 pci 2.0 bus, no pci bridge 
optimization, firewall enabled, no masq, no proxy, no adv routing). All of
this hardware and the network are stable on 2.0.38 (ie the tcp/ip over
ethernet hang never happens there). It happens without any ipchains
rules installed (the support is there, but it's not configured).

It doesn't seem to do it on ftp (although that may simply be not having
pushed it hard enough). It can handle 100s of mbs in a single ftp session
without falling over, but a rapid sequence of httpd requests will knock
it over every time.

Minor points of evidence:

* on one test, "strace -ff ..." showed the second argument to accept()
  scribbled over (6-7 lines of "^@^@..." in the child) about three forks
  before it deadlocked. I saw the same thing at the bottom of the
  httpd server's log after an earlier hang.

* It doesn't simply stop, it suddenly gets really slow on the connect
  where it is going to hang. The last html page downloaded on one test
  ended up with a partial document, so it sometimes starts the data
  transfer, it simply can't complete it (the kernel/network_stack is
  already on it's way to the twilight zone when the download starts, it
  simply manages to squeeze out a few packets before it gets there).

* When it happens, it takes the keyboard with it, and you can't ping it.

* It's not the hd filesystems. I can html browse the same files that it
  hangs on over eth0 via lynx on the same host where the httpd server is
  running for hours without reproducing the kernel hang. I can move gbs
  of data around on those filesystems without errors and without
  filesystem corruption.

Since the error can be reproduced so reliably, it should be possible to
debug it, if I know where/how to enable verbose logging.

Suggestions?

Regards,

Clayton Weaver
<mailto:cgweav@eskimo.com>
(Seattle)

"Everybody's ignorant, just in different subjects."  Will Rogers



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
