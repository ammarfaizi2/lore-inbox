Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbUAHHnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 02:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbUAHHnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 02:43:09 -0500
Received: from scan.ji-net.com ([203.130.156.4]:42650 "EHLO scan.ji-net.com")
	by vger.kernel.org with ESMTP id S262782AbUAHHnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 02:43:01 -0500
Message-ID: <3FFD09F1.2020702@ji-net.com>
Date: Thu, 08 Jan 2004 14:42:41 +0700
From: Maetee Maitri <new@ji-net.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030716
X-Accept-Language: th
MIME-Version: 1.0
To: deian@blue-edge.bg
CC: tsd@asus.com, linux-kernel@vger.kernel.org
Subject: Re:  P4P800-VM - ASUS - HIGH MEMORY extremely slow under some circumstaces
 - LOG FILES - added
Content-Type: text/plain; charset=TIS-620; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just upgrade from P4 1.8G on GIGABYTE GA-8IGX (Intel 845G) to P4 2.4c on ASUS P4P800-VM and have the similar problem. My system runing RedHat 7.3 kernel 2.4.18-26.7.x. My system have only 1G RAM (2x512M DDR400). both of them set to use only 1M video ram.

I notice that the setting of difference video RAM and AGP aperture size in BIOS affected speed of system.
I see that /proc/mtrr on P4P800-VM has 6 lines and GA-8IGX has 2 lines.

GA-8IGX:
reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0x3ff00000 (1023MB), size=   1MB: uncachable, count=1

P4P800-VM:
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0x20000000 ( 512MB), size= 256MB: write-back, count=1
reg02: base=0x30000000 ( 768MB), size= 128MB: write-back, count=1
reg03: base=0x38000000 ( 896MB), size=  64MB: write-back, count=1
reg04: base=0x3c000000 ( 960MB), size=  32MB: write-back, count=1
reg05: base=0x3e000000 ( 992MB), size=  16MB: write-back, count=1

Why a lot of region???
I try to clear all mtrr on P4P800-VM and set the new one base on GA-8IGX:

[root /]# echo "disable=5" >| /proc/mtrr
[root /]# echo "disable=4" >| /proc/mtrr
[root /]# echo "disable=3" >| /proc/mtrr
[root /]# echo "disable=2" >| /proc/mtrr
[root /]# echo "disable=1" >| /proc/mtrr
[root /]# echo "disable=0" >| /proc/mtrr
[root /]# echo "base=0x00000000 size=0x40000000 type=write-back" > /proc/mtrr
[root /]# echo "base=0x3ff00000 size=0x00100000 type=uncachable" > /proc/mtrr

Yes!! It work, My system come fast again. the new /proc/mtrr show below:
[root /]# cat /proc/mtrr 
reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0x3ff00000 (1023MB), size=   1MB: uncachable, count=1

For your 2G RAM machine. You may change size of first region from 0x40000000 (1G) to 0x80000000 (2G). The value of base and size of second region base on your video RAM setting in BIOS.

Hope this solution will work on your system too.

Maetee Maitri


>Hi,
>
>I have ASUS P4P800-VM mother board.
>Chipset:     Intel 865G GMCH
>                 Intel ICH5   - 800MHz FSB
>
>BIOS  Revision: 1007
>
>Embedded LAN  : Intel 82562EZ
>Embedded Graphics: Intel Extreme Graphics 2
>
>RAM  2G    4x512M  DDR400 Samsung
>HDD IDE  Seagate Barracuda  120G
>Processor:  P4 - 2.6 GHz   HyperThreading
>
>OS: Slackware Linux 9.1
>
>Description of the problem:
>
>I have installed 2 GB memory 4x512M
>The embedded video uses system memory. If i set it to use only 1 MB or
>32MB of system RAM everything seems ok. The system boots normally and
>working normally.
>If i set it to use 4,8 or 16 MB of the system memory the system boots
>much slower and despite it has no errors or something wrong it works
>slow. I mean the difference between fast and slow working is really HUGE.
>I have made the following test: in a 600MB text file  replace some text
>with sed. The line looks like this:
>
>sed s/deian/test/g  testfile > /dev/null
>
>when the system is working normally this is done for ~ 30sec. When the
>system is working slowly it takes ~ 9 min and 30 sec.
>I have tested this with kernel 2.4.23 from kernel.org. High memory
>support is enabled - 4GB. If i have no high memory support enabled the
>thing are ok but the kernel see only 900MB of my memory.
>The other strange thing is that with kernel 2.6 the system works
>normally ONLY IF video card uses 32MB. It is not like with 2.4.23 when 1
>and 32M but only with 32MB.
>
>I dont think this is normal behavior. And i hope that the problem is not
>the chipset or hardware. I have searched the news groups and other
>people has the same problem too but no solution yet.
>I have attached some logs which may help u find what is wrong. If u need
>me to do something more just mail me i shall respond as fast as i can.
>Regards,
>
>Deian Chepishev
>

Maetee Maitri


