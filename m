Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbVHDQtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbVHDQtB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 12:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVHDQql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 12:46:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47605 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262629AbVHDQp3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 12:45:29 -0400
Message-ID: <42F245FF.1050006@mvista.com>
Date: Thu, 04 Aug 2005 09:44:47 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] IDE disks show invalid geometries in /proc/ide/hd*/geometry
References: <42EFE547.3010206@mvista.com>  <Pine.LNX.4.10.10508030018390.21865-100000@master.linux-ide.org>  <58cb370e05080310195c244f72@mail.gmail.com>  <42F100C8.8040700@mvista.com>  <58cb370e05080311056a9276c0@mail.gmail.com>  <42F10DB8.4020601@mvista.com> <58cb370e05080311517e6c02a8@mail.gmail.com> <Pine.LNX.4.61.0508040800130.22272@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0508040800130.22272@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>Simple: do not use BIOS values.
>>[ Yes, there should be some warning from kernel. ]
>>    
>>
>
>On that matter, I get a warning from LILO wrt cyls and stuff:
>
>07:47 spectre:~ # cat /proc/ide/hda/geometry 
>physical     16383/16/63
>logical      65535/16/63
>07:58 spectre:~ # lilo
>Warning: Kernel & BIOS return differing head/sector geometries for device 0x80
>    Kernel: 65535 cylinders, 16 heads, 63 sectors
>      BIOS: 1023 cylinders, 255 heads, 63 sectors
>Added linux *
>07:59 spectre:~ # fdisk -l
>
>Disk /dev/hda: 40.9 GB, 40982151168 bytes
>255 heads, 63 sectors/track, 4982 cylinders
>
>
>All of these numbers are virtual, since CHS is not really used anymore, as 
>we know. But, which of these fake CHS values (16383/16/63 | 65535/16/63 | 
>1023/255/63) is the right one? 255/63/4982 is another matter, since it 
>[almost] matches the actual size of the disk while the other three are just 
>"for the bios".
>  
>
This is exactly the case that my patch was attempting to fix (and 
apparently didn't get quite right).

Certain drive returns cause strange numbers to slip through often when 
LBA 28 is involved.

mark

