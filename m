Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbSLISiY>; Mon, 9 Dec 2002 13:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265426AbSLISiY>; Mon, 9 Dec 2002 13:38:24 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:47366
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S265424AbSLISiX>; Mon, 9 Dec 2002 13:38:23 -0500
Message-ID: <3DF4E433.5010207@rackable.com>
Date: Mon, 09 Dec 2002 10:42:59 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Spacecake <lkml@spacecake.plus.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: HPT372 RAID controller
References: <20021208123134.4be342c7.lkml@spacecake.plus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2002 18:46:01.0366 (UTC) FILETIME=[38615360:01C29FB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spacecake wrote:

>Hi,
>
>I've been putting off posting to this mailing list, because i really
>didn't want to bother all you busy kernel development type peoples :),
>but after searching for about a week, i am no closer to the answer -
>maybe the author of the driver can help me, or something.
>
>Using the above raid controller, which is onboard the Abit KX7-333R
>motherboard.
>Using a single HDD to test it with, the HDD in question works fine using
>the VIA IDE controller on the same board.
>If this matters, i don't actually want RAID, i am just using it as
>another IDE controller.
>
>I'm using the 2.4.20 kernel, and i thought this controller had been
>supported since 2.4.18. I'll include the relevant part of my current
>.config below.
>  
>

   Things have been changing a lot in the 2.4 ide driver.  Try Alan's ac 
kernel.  That's where all of the ide bug fixing is being done.

1)Apply ac patch
- cd ~
- wget 
ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.20/patch-2.4.20-ac1.bz2
- cd /usr/src/
- cp -a linux-2.4.20 linux-2.4.20-ac1
- cd linux-2.4.20-ac1
- bzcat ~/patch-2.4.20-ac1.bz2|   patch -p1
2)Compile and install kernel
- cp .config 1
- make mrproper
- cp 1 .config
- make oldconfig
- make dep bzImage modules modules_install install
3)If you still have issues send an email to the list with 2.4.20-ac1 in 
the subject.  Include:
- ide section of dmesg
- output of "hdparm -vi <drive>"
- results of "hdparm -d 1 <drive>"  including any thing that shows up in 
dmesg afterwards.

>  
>


