Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUAJKmh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 05:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUAJKmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 05:42:37 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:37587 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S265051AbUAJKme
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 05:42:34 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
Date: Sat, 10 Jan 2004 16:11:53 +0530
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, jim.houston@comcast.net, discuss@x86-64.org,
       ak@suse.de, shivaram.upadhyayula@wipro.com,
       lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <000e01c3d476$2ebe03a0$4008720a@shivram.wipro.com> <200401091031.41493.amitkale@emsyssoft.com> <3FFF2851.4060501@mvista.com>
In-Reply-To: <3FFF2851.4060501@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401101611.53510.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George,

Well said!

I have released kgdb 2.0.1 for kernel 2.6.1:
http://kgdb.sourceforge.net/linux-2.6.1-kgdb-2.0.1.tar.bz2

It doesn't contain any assert stuff. I have split it into multiple parts to 
make a merge easier. Please let me know if you want me to further split them 
or if you want something to be changed. The README file from this tarball is 
pasted below.

Here is two possible starting points:
1. SMP stuff -> Replace my old smp and nmi handling code.
2. Early boot -> Change 8250.patch to make configuration of serial port either 
through config options or through command line.

I'll attempt reading your patch and merging as much stuff as possible.
Thanks.

Patch:
------
Patch the kernel out of following patches.
core.patch -	KGDB architecture and interface independent code. Required.
i386.patch -	i386 architecture dependent part. Required only for that
		architecture.
x86_64.patch -	x86_64 architecture dependent part. Required only for that
		architecture.
8250.patch -	Generic serial port (8250 and 16550) interface for kgdb. This
		is the only working interface in this release. Hence required.
eth.patch -	Ethernet interface for kgdb. This is still under development.
		Use only if you plan to contribute to its development.

Build:
------
Enable following config options (in this order).

Kernel hacking ->
	KGDB: kernel debugging with remote gdb ->
		KGDB: Thread analysis
		KGDB: Console messages through gdb
Device drivers ->
	Character devices ->
		Serial drivers ->
			KGDB: On generic serial port (8250)
	
Boot:
-----
Supply command line options kgdbwait and kgdb8250 to the kernel.
Example:  kgdbwait kgdb8250=1,115200

On Saturday 10 Jan 2004 3:46 am, George Anzinger wrote:
> Amit,
>
> The base line kgdb code in the mm patches was offered by me.  It derives
> from (a long time ago) a kgdb I got from the RTIA (or was it the RTLINUX)
> folks.  Prio to that, well, your name is on it as well as others.
>
> As you may have noted there have been a lot of changes, mostly for the
> better, I hope.  I think we have slightly different objectives in our work.
>  I debug kernels, not drivers, so I am interested in getting into kgdb as
> early as possible.  To this end the current mm patch allows one to put a
> breakpoint() as the first line of C code in the kernel.  This required a
> few adjustments, such as configuring the I/O port at CONFIG time, for
> example.
>
> I would like for the two versions of kgdb to merge while keeping the
> features of both.  The work on seperating the common code is something I
> like and, while I never do modules, the automatic module stuff in gdb sound
> good.
>
> May I suggest that we compare and contrast the two versions and take a look
> at the differences and the overlaps and settle on one way of doing the
> various things.
>
> George

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

