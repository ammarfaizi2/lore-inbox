Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293132AbSDIPem>; Tue, 9 Apr 2002 11:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293175AbSDIPel>; Tue, 9 Apr 2002 11:34:41 -0400
Received: from hera.cwi.nl ([192.16.191.8]:60413 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S293132AbSDIPel>;
	Tue, 9 Apr 2002 11:34:41 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 9 Apr 2002 15:34:34 GMT
Message-Id: <UTC200204091534.PAA574373.aeb@cwi.nl>
To: axboe@suse.de, dalecki@evision-ventures.com
Subject: Re: [PATCH][CFT] IDE TCQ #2
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    On Tue, Apr 09 2002, Martin Dalecki wrote:
    > >  echo "using_tcq:0" > /proc/ide/hdX/setting
    > >
    > >  will disable TCQ and revert to DMA,
    > >
    > >  echo "using_tcq:32" > /proc/ide/hdX/setting
    > >
    > >  will set queue depth to 32, any value in between the two are of course
    > >  also allowed. The driver will print enable/disable info to the kernel
    > >  log.
    > 
    > Well this belongs to an ioctl or sysctl... However most
    > of the /proc/ide stuff if not all will go to the sysctl quite soon.

    Put it wherever you want it, I'm just making it easier for myself not
    having to pass patches to hdparm around as well for people to enable
    taggged queueing.

Yes, for IDE purposes it does not matter much what one does.

But one needs communication between user or user space
and kernel to interact with hundreds of drivers, in a rather
messy way.

In my opinion sysctl() is worthless. It uses an array of numbers
where ioctl() uses a single number. Especially since the names are
already in the kernel it is much clearer and cleaner to use a
pathname. I wouldn't mind if sysctl() disappeared entirely.

Also ioctl() has its problems. First of all, nobody knows what the
prototype is. Secondly, it is too rigid - the moment one needs a
larger structure one needs a different ioctl.

A text based interface is much more flexible. If the number of
cylinders of a disk no longer fits in a short, well doesn't matter,
then the number of digits may increase but the interface remains
unchanged. Of course the price is that one has to parse, but
typically that is not a problem.

[Not that I want to revive old threads on this topic. This is
just a direct reaction to
    > Well this belongs to an ioctl or sysctl... However most
    > of the /proc/ide stuff if not all will go to the sysctl quite soon.
I do not think going to sysctl is an improvement.]

Andries
