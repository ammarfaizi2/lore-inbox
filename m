Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263441AbVBCPvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbVBCPvL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 10:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbVBCPvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 10:51:10 -0500
Received: from 34.67-18-129.reverse.theplanet.com ([67.18.129.34]:13283 "EHLO
	krish.dnshostnetwork.net") by vger.kernel.org with ESMTP
	id S263061AbVBCPqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 10:46:00 -0500
Message-ID: <015901c50a07$721f2620$8d00150a@dreammac>
From: "Pankaj Agarwal" <pankaj@toughguy.net>
To: <linux-os@analogic.com>
Cc: <linux-kernel@vger.kernel.org>, "Linux Net" <linux-net@vger.kernel.org>
References: <001501c509ff$d4be02e0$8d00150a@dreammac> <Pine.LNX.4.61.0502031017430.9404@chaos.analogic.com>
Subject: Re: Query - Regarding strange behaviour.
Date: Thu, 3 Feb 2005 21:15:33 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-PopBeforeSMTPSenders: pankaj@pnpexports.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - krish.dnshostnetwork.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - toughguy.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

its not even allowing me to copy it ...then surely it wont allow me mv as 
well... what else can i try...

[root@test root]# mount
/dev/hda2 on / type ext3 (rw)
none on /proc type proc (rw)
usbdevfs on /proc/bus/usb type usbdevfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /dev/shm type tmpfs (rw)

[root@test /]# cd /usr
[root@test usr]# cp bin testbin
cp: omitting directory `bin'
[root@test usr]# ls
bin   etc    include  kerberos  libexec  sbin   src   test121212  X11R6
dict  games  java     lib       local    share  test  tmp
[root@test usr]#

----- Original Message ----- 
From: "linux-os" <linux-os@analogic.com>
To: "Pankaj Agarwal" <pankaj@toughguy.net>
Cc: <linux-kernel@vger.kernel.org>; "Linux Net" <linux-net@vger.kernel.org>
Sent: Thursday, February 03, 2005 9:05 PM
Subject: Re: Query - Regarding strange behaviour.


> On Thu, 3 Feb 2005, Pankaj Agarwal wrote:
>
>> Hi,
>>
>> In my system there's a strange behaviour.... its not allowing me to 
>> create any file in /usr/bin even as root. Its chmod is set to 755. Its 
>> even not allowing me to change the chmod value of /usr/bin. The strangest 
>> part which i felt is ...its shows the owner and group as root when i 
>> issue command "ls -ld /usr/bin" and not allowing root to create any file 
>> or directory under /usr/bin and not even allowing to change the chmod 
>> value. The error is access permission denied... I can change the chmod 
>> value of /usr and other directories under /usr/...but not of bin....
>>
>> I need your help/support. kindly let me know what all can i try to 
>> resolve this problem.
>>
>> Thanks and Regards,
>>
>> Pankaj Agarwal
>
> See if your file-system has gotten hurt. Boot with init=/bin/bash
> and execute `/sbin/fsck -f /` to force a check of the root file-system.
>
> The next check is to see if you can fix the protections when
> you are the only one accessing the file-system:
>
> # mount -n -o remount / # re-mount root r/w
> # cd /usr
> # chmod 755 bin
> # ls -la # See if it worked
> # unmount /
>
> The next check is to replace the /usr/bin directory. Since `mv`
> and `mkdir` are in /bin, the following should work.
>
> # mount -n -o remount /  # re-mount root r/w
> # cd /usr
> # mv bin foo # Rename 'strange' directory
> # mkdir bin # Make a new one
> # cd foo # Change to original
> # mv * ../bin # Rename all contents to new
> # cd .. # rmdir foo # Remove bad directory
> # chmod 755 bin # Fix protection
> # umount /
>
> After you have fixed things, you don't have to re-boot.
> Just execute:
>
> # exec /sbin/init auto
>
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached for review by Dictator Bush.
>                  98.36% of all statistics are fiction. 

