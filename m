Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbRFBUCG>; Sat, 2 Jun 2001 16:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262684AbRFBUB4>; Sat, 2 Jun 2001 16:01:56 -0400
Received: from line93.ba.psg.sk ([195.80.179.93]:42112 "HELO ivan.doma")
	by vger.kernel.org with SMTP id <S262682AbRFBUBq>;
	Sat, 2 Jun 2001 16:01:46 -0400
Date: Sat, 2 Jun 2001 22:02:19 +0200
From: Ivan <pivo@pobox.sk>
To: linux-kernel@vger.kernel.org
Subject: Re: PID of init != 1 when initrd with pivot_root
Message-ID: <20010602220219.A1091@ivan.doma>
In-Reply-To: <20010601040627.A1335@ivan.doma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010601040627.A1335@ivan.doma>; from pivo@pobox.sk on Fri, Jun 01, 2001 at 04:06:27AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well, I upgraded and found pivot_root and the problem is that how do I make init
> > run with PID 1. My linuxrc gets PID 7.
> > 
> >     1 ?        00:03:05 swapper
> >     2 ?        00:00:00 keventd
> >     3 ?        00:00:00 kswapd
> >     4 ?        00:00:00 kreclaimd
> >     5 ?        00:00:00 bdflush
> >     6 ?        00:00:00 kupdated
> >     7 ?        00:00:00 linuxrc
> > 
> > init doesn't like running with any other PID than 1. I could probably revert to
> > the not so old way of doing things and exit linuxrc and let the kernel change
> > root. But then I wouldn't be able to mount root over samba :-(. ( not that I
> > have any samba shares :-)
>
> This is this way for backwards bug compatibility.  Use the following
> command line options to make it behave properly:
>
>         ram=/dev/ram0 init=/linuxrc

That's what I did, almost. I think you meant root=/dev/rd/0 init=/linuxrc ( with
devfs) though init parameter is made redundant by the new "root change
mechanism" pivot_root.

But the problem still remains. How do I make my /sbin/init run with PID 1 using
initial ramdisk under the new root change mechanism? I don't want to use the old
change_root mechanism since the Documentation/initrd.txt says:

Obsolete root change mechanism
------------------------------

The following mechanism was used before the introduction of pivot_root.
Current kernels still support it, but you should _not_ rely on its
continued availability.
...
This old, deprecated mechanism is commonly called "change_root", while
the new, supported mechanism is called "pivot_root".

--
Ivan Vadovic
