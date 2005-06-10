Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVFJOjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVFJOjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 10:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbVFJOjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 10:39:52 -0400
Received: from easyspace.ezspl.net ([216.74.109.141]:7892 "EHLO
	easyspace.ezspl.net") by vger.kernel.org with ESMTP id S262565AbVFJOjD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 10:39:03 -0400
Message-ID: <20050610103900.f5is8molgox28c4o@www.nucleodyne.com>
Date: Fri, 10 Jun 2005 10:39:00 -0400
From: kallol@nucleodyne.com
To: kallol@nucleodyne.com
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Performance figure for sx8 driver
References: <20050608212425.8951j70kxbwpcs8c@www.nucleodyne.com>
	<42A7DD18.50004@pobox.com>
	<20050610103022.ajs6633qyv400sw4@www.nucleodyne.com>
In-Reply-To: <20050610103022.ajs6633qyv400sw4@www.nucleodyne.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - easyspace.ezspl.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32001 32003] / [47 12]
X-AntiAbuse: Sender Address Domain - nucleodyne.com
X-Source: /usr/local/cpanel/3rdparty/bin/php
X-Source-Args: /usr/local/cpanel/3rdparty/bin/php /usr/local/cpanel/base/horde/imp/compose.php 
X-Source-Dir: :/base/horde/imp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following steps have been used to reproduce the problem.
I am not sure how hdparm worked on non-scsi or non-ide device.

> $ cat /proc/diskstats
>    1    0 ram0 0 0 0 0 0 0 0 0 0 0 0
>    1    1 ram1 0 0 0 0 0 0 0 0 0 0 0
>    1    2 ram2 0 0 0 0 0 0 0 0 0 0 0
>    1    3 ram3 0 0 0 0 0 0 0 0 0 0 0
>    1    4 ram4 0 0 0 0 0 0 0 0 0 0 0
>    1    5 ram5 0 0 0 0 0 0 0 0 0 0 0
>    1    6 ram6 0 0 0 0 0 0 0 0 0 0 0
>    1    7 ram7 0 0 0 0 0 0 0 0 0 0 0
>    1    8 ram8 0 0 0 0 0 0 0 0 0 0 0
>    1    9 ram9 0 0 0 0 0 0 0 0 0 0 0
>    1   10 ram10 0 0 0 0 0 0 0 0 0 0 0
>    1   11 ram11 0 0 0 0 0 0 0 0 0 0 0
>    1   12 ram12 0 0 0 0 0 0 0 0 0 0 0
>    1   13 ram13 0 0 0 0 0 0 0 0 0 0 0
>    1   14 ram14 0 0 0 0 0 0 0 0 0 0 0
>    1   15 ram15 0 0 0 0 0 0 0 0 0 0 0
>  160   64 sx8/2 1 0 8 10 0 0 0 0 0 10 10
>  160   65 sx8/2p1 0 0 0 0
>  160  128 sx8/4 1 0 8 20 0 0 0 0 0 20 20
>  160  129 sx8/4p1 0 0 0 0
>  160  192 sx8/6 1 0 8 20 0 0 0 0 0 20 20
>  160  193 sx8/6p1 0 0 0 0
>    3    0 hda 1 0 8 0 0 0 0 0 0 0 0
>    3    1 hda1 0 0 0 0
>
>  $ mknod /dev/sda b 160 64
> $ mknod /dev/sdb b 160 128
> $ mknod /dev/sdc b 160 192
>  $ ./hdparm -t /dev/sda &
> $./hdparm -t /dev/sdb
................

Quoting kallol@nucleodyne.com:

> Hello Jeff,
>            Changing CARM_MAX_Q to 30 and upgrading the firmware to
> firmware(BIOS-1.00.0.37, Firmware-1.3.19) does not help.
>
> Anything else to try?
>
> Kallol
>
> Quoting Jeff Garzik <jgarzik@pobox.com>:
>
>> kallol@nucleodyne.com wrote:
>>> Does anyone have performace figure for sx8 driver which is for 
>>> promise SATAII150
>>> 8 port PCI-X adapter?
>>>
>>> Someone reports that on a platform with sx8 driver, multiple hdparms on
>>> different disks those are connected to the same adapter (there are 
>>> 8 ports) can
>>> not get more than 45MB/sec in total, whereas a SCSI based driver 
>>> for the same
>>> adapter gets around 150MB/sec.
>>>
>>> Any comment on this?
>>
>> Known.  Early firmwares for SX8 had problems that forced the driver to
>> limit the number of outstanding requests, for all ports, to _one_.
>>
>> Later firmwares have fixed this, but the driver has not been updated to
>> detect newer(fixed) firmwares.
>>
>> You may update drivers/block/sx8.c as such:
>>
>> - CARM_MAX_Q              = 1,               /* one command at a time */
>> + CARM_MAX_Q              = 30,              /* 30 commands at a time */
>>
>> if you have a newer firmware, to obtain much better performance.
>>
>> 	Jeff
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>
>
>



