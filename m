Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318529AbSIKIVK>; Wed, 11 Sep 2002 04:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318536AbSIKIVK>; Wed, 11 Sep 2002 04:21:10 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:8135 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S318529AbSIKIVJ>;
	Wed, 11 Sep 2002 04:21:09 -0400
Date: Wed, 11 Sep 2002 10:25:56 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200209110825.KAA06080@harpo.it.uu.se>
To: tmolina@cox.net
Subject: Re: 2.5.34-bk floppy weirdness
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2002 20:38:47 -0500 (CDT), Thomas Molina wrote:
>The following appeared with the latest bk updated kernel.  It was not 
>present with the 2.5.33 version, nor with a 2.4 kernel version.
>
>I cannot dd to the floppy until either it has been mounted, or until the 
>superuser has dd'd to the floppy.  The following is from a fresh boot:
>
>[tmolina@dad testfloppystable]$ ls
>floppy  floppyimage
>[tmolina@dad testfloppystable]$ ls -l /dev/fd0
>brw-rw----    1 tmolina  floppy     2,   0 Apr 11 09:25 /dev/fd0
>[tmolina@dad testfloppystable]$ ls -l
>total 1448
>drwxr-xr-x    2 tmolina  tmolina      4096 Dec 31  1969 floppy
>-rw-rw-r--    1 tmolina  tmolina   1474560 Sep  1 09:49 floppyimage
>[tmolina@dad testfloppystable]$ dd if=floppyimage of=/dev/fd0
>dd: opening `/dev/fd0': No such device or address
>[tmolina@dad testfloppystable]$ su
>Password:
>[root@dad testfloppystable]# dd if=floppyimage of=/dev/fd0
>2880+0 records in
>2880+0 records out

My 2.5.34 (proper, not bk) doesn't have this misbehaviour.

Are you building the floppy driver as a module and relying
on kmod+modutils to insert it on demand? If so, you may be
seeing the same problem I was when I upgraded my user-space
to RedHat 7.3: dd of=/dev/fd0 as a user won't load floppy.o.
See RedHat bug id 65685 for details.

/Mikael
