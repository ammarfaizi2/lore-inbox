Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262202AbRFEPyo>; Tue, 5 Jun 2001 11:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264023AbRFEPye>; Tue, 5 Jun 2001 11:54:34 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:30724 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S262202AbRFEPy3>; Tue, 5 Jun 2001 11:54:29 -0400
Date: Tue, 5 Jun 2001 17:56:18 +0200
From: "W. Michael Petullo" <mike@flyn.org>
To: Ivan <pivo@pobox.sk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PID of init != 1 when initrd with pivot_root
Message-ID: <20010605175618.A2884@dragon.flyn.org>
In-Reply-To: <20010601040627.A1335@ivan.doma> <20010602220219.A1091@ivan.doma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010602220219.A1091@ivan.doma>; from pivo@pobox.sk on Sat, Jun 02, 2001 at 10:02:19PM +0200
X-Operating-System: Linux dragon.flyn.org 2.4.2-XFS 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Well, I upgraded and found pivot_root and the problem is that how do I make
>>> init run with PID 1. My linuxrc gets PID 7.
>>> 
>>>     1 ?        00:03:05 swapper
>>> ...
>>>     7 ?        00:00:00 linuxrc
>>> 
>>> init doesn't like running with any other PID than 1. I could probably revert
>>> to the not so old way of doing things and exit linuxrc and let the kernel 
>>> change root. But then I wouldn't be able to mount root over samba :-(.
>>>
>>> ...

>> This is this way for backwards bug compatibility.  Use the following
>> command line options to make it behave properly:
>>
>>         ram=/dev/ram0 init=/linuxrc

> ...
>
> But the problem still remains. How do I make my /sbin/init run with PID 1 
> using initial ramdisk under the new root change mechanism? I don't want to 
> use the old change_root mechanism...

I had the same problem when doing some development for mkCDrec.
This project uses busybox, whose init does not run if its PID != 1.
I asked the busybox folks same question you did and never got a response.

As a kludge, and after looking at the busybox source code, I renamed init
to linuxrc.  In this case the program is functionally equivalent to init,
except that it does not do the PID == 1 check.

An excerpt from my real linuxrc:

echo Pivot_root: my PID is $$
# exec /usr/sbin/chroot . /sbin/init < dev/console > dev/console 2>&1
# Okay, try this:
exec /usr/sbin/chroot . /sbin/linuxrc < /dev/console > /dev/console 2>&1

/sbin/linuxrc is actually init, renamed.

I am sure this is not the preferred method.  Please let me know if you
find the correct solution.

-- 
W. Michael Petullo

:wq
