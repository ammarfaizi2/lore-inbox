Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130200AbRBZIk3>; Mon, 26 Feb 2001 03:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130199AbRBZIkU>; Mon, 26 Feb 2001 03:40:20 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:38649 "EHLO
	mail.plan9.de") by vger.kernel.org with ESMTP id <S130200AbRBZIkL>;
	Mon, 26 Feb 2001 03:40:11 -0500
Date: Mon, 26 Feb 2001 09:40:00 +0100
From: Marc Lehmann <pcg@goof.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux swap freeze STILL in 2.4.x
Message-ID: <20010226094000.A4228@fuji.laendle>
Mail-Followup-To: Mike Galbraith <mikeg@wen-online.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010225202526.B8890@cerebro.laendle> <Pine.LNX.4.33.0102260801240.1408-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0102260801240.1408-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Mon, Feb 26, 2001 at 08:11:55AM +0100
X-Operating-System: Linux version 2.4.2 (root@fuji) (gcc version 2.95.2.1 19991024 (release)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2001 at 08:11:55AM +0100, Mike Galbraith <mikeg@wen-online.de> wrote:
> Hmm.. I remember having this problem and it was a problem with strace.

Well, I obviously strace'd it to find out why I get a memory fault without
one (I would be happy if it worked without strace ;->)

> Anyway, it works fine here with virgin 2.4.2, so it seems unlikely it's
> a kernel problem.

> 259   execve("/sbin/losetup", ["losetup", "/dev/loop0", "/dev/hda5"], [/* 47 vars */]) = 0

The -e switch is causing the memory fault and subsequent breakage:

743   open("/dev/hdd", O_RDWR)          = 4
743   open("/dev/loop0", O_RDWR)        = 5
743   mlockall(0x3, 0x804c272)          = 0
743   ioctl(5, LOOP_SET_FD, 0x4)        = -1 ENOSYS (Function not implemented)
743   ioctl(5, LOOP_SET_FD, 0x4)        = 0
743   ioctl(5, LOOP_SET_STATUS, 0xbffff5d8) = -1 ENOSYS (Function not implemented)
743   ioctl(5, LOOP_SET_STATUS, 0xbffff5d8) = -1 ENOSYS (Function not implemented)
743   ioctl(5, LOOP_SET_STATUS, 0xbffff5d8) = -1 ENOSYS (Function not implemented)
743   ioctl(5, LOOP_SET_STATUS, 0xbffff5d8) = -1 ENOSYS (Function not implemented)
743   ioctl(5, LOOP_SET_STATUS <unfinished ...>
743   +++ killed by SIGSEGV +++

(which is a strange strace anyway...)

However, I just need to wait until there is a new crypto patch (and, if
not, I'll eventually have to hack it myself to gte my data. After all it's
source... ...)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
