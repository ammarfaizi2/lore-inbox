Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269829AbRHIO4P>; Thu, 9 Aug 2001 10:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269831AbRHIO4G>; Thu, 9 Aug 2001 10:56:06 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:43268 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S269829AbRHIOz5>; Thu, 9 Aug 2001 10:55:57 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Thu, 9 Aug 2001 16:55:46 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.4.4: thread dumping core
Message-ID: <3B72C08E.3800.1F80245@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.9/3.47+2.4+2.03.072+02 July 2001+64930@20010809.144439Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wonder whether the kernel does the right thing if a thread causes a 
segmentation violation: Currently it seems the other LWPs just 
continue. However in practice this means that the application does not 
work reliable when one thread went away.

I suggest to terminate all LWPs if one receives a fatal signal.

I wasn't successful debugging the beast:

Program terminated with signal 11, Segmentation fault.
Reading symbols from /lib/libpthread.so.0...done.
rw_common (): write: Success.

warning: unable to set global thread event mask
[New Thread 1024 (LWP 10566)]
Error while reading shared library symbols:
attach_thread: No such process.
Reading symbols from /lib/libc.so.6...done.
Loaded symbols for /lib/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
#0  0x4005e0a6 in sigsuspend () from /lib/libc.so.6
(gdb) bt
#0  0x4005e0a6 in sigsuspend () from /lib/libc.so.6
#1  0x4002496c in sigwait () from /lib/libpthread.so.0
#2  0x804da47 in mi_signal_thread ()
#3  0x40021ba3 in pthread_start_thread () from /lib/libpthread.so.0


Opinions?

Ulrich

