Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129329AbRBXNn3>; Sat, 24 Feb 2001 08:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129341AbRBXNnT>; Sat, 24 Feb 2001 08:43:19 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:5899 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129329AbRBXNnH>; Sat, 24 Feb 2001 08:43:07 -0500
Date: Sat, 24 Feb 2001 08:44:26 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Burton Windle <burton@fint.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Detecting SMP
In-Reply-To: <Pine.LNX.4.21.0102201912150.16545-100000@fint.staticky.com>
Message-ID: <Pine.LNX.4.33.0102240804040.2548-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001, Burton Windle wrote:

>Hello. Is there a way, when running a non-SMP kernel, to detect or
>otherwise tell (software only; the machine is 2400 miles away) if the
>system has SMP capibilties? Would /proc/cpuinfo show two CPUs if the
>kernel is non-SMP?  Thanks!
>
>(btw, the kernel in question is a stock RH6.2 kernel 2.2.14-5, and yes, I
>know I should update it anyways and that a SMP kernel will run on a UP
>system)

Yes, there are several ways.  How do you want to know how to do
it, in C, or a bash script?  sysconf is one way, parsing
/proc/cpuinfo and /proc/stat is another.  Beware though, if you
parse /proc/cpuinfo or stat, it is very different on different
architectures, particularly sparc.

Here is some code which should do it more or less correctly on
any arch:

ncpus=$(egrep -c ^cpu[0-9]+ /proc/stat || :)
[ "$ncpus" = "0" ] && ncpus=1


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
if (argc > 1 && strcmp(argv[1], "-advice") == 0) {
    printf("Don't Panic!\n");
    exit(42);
}

