Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWIUMzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWIUMzz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 08:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWIUMzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 08:55:55 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:2323 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751172AbWIUMzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 08:55:54 -0400
Message-ID: <45128BB5.2040004@shadowen.org>
Date: Thu, 21 Sep 2006 13:55:17 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-mm1
References: <20060919012848.4482666d.akpm@osdl.org>	<45100272.505@mbligh.org> <20060919093122.d8923263.akpm@osdl.org>
In-Reply-To: <20060919093122.d8923263.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 19 Sep 2006 07:45:06 -0700
> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> 
>>> - It took maybe ten hours solid work to get this dogpile vaguely
>>>   compiling and limping to a login prompt on x86, x86_64 and powerpc. 
>>>   I guess it's worth briefly testing if you're keen.
>> PPC64 blades shit themselves in a strange way. Possibly the udev
>> breakage you mentioned? Hard to tell really if people are going to
>> go around breaking userspace compatibility ;-(
> 
> What version of udev is it running?

Ok, this is not a blade, but a ppc lpar.  Its running the following
version of udev:

udevinfo, version 021_bk

(Assuming of course the help for udev info -V is not lying when it says
"-V       print udev version".)

>> http://test.kernel.org/abat/48127/debug/console.log
>>
>> ..
>>
>> sda: Write Protect is off
>> sda: cache data unavailable
>> sda: assuming drive cache: write through
>> SCSI device sda: 143374000 512-byte hdwr sectors (73407 MB)
>> sda: Write Protect is off
>> sda: cache data unavailable
>> sda: assuming drive cache: write through
>>   sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
>> sd 0:0:1:0: Attached scsi disk sda
>> creating device nodes .[: [0-9]*: bad number

I was assuming this message was from udev?  I can't find it in the
kernel anyhow.  Might just be noise on the initrd.

>> 0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
>> 0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
>> [: [0-9]*: bad number
>> 0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
>> 0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
>> [: [0-9]*: bad number
>> 0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
>> 0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
>> [: [0-9]*: bad number
>> 0:0:1:0: sg_io failed status 0x8 0x0 0x0 0x2
>> 0:0:1:0: sense key 0x5 ASC 0x24 ASCQ 0x0
>> [: [0-9]*: bad number
>>
>>
> 
> That all looks rather bad.
> 
>> ReiserFS: sda2: Using r5 hash to sort names
>> looking for init ...
>> found /sbin/init
>> /init: cannot open .//dev//console: no such file
> 
> Bizarrely-formed pathname.  Does it always do that?
> 
>> Kernel panic - not syncing: Attempted to kill init!
>>   <0>Rebooting in 180 seconds..-- 0:conmux-control -- time-stamp -- 
>> Sep/19/06  4:18:52 --
>> (bot:conmon-payload) disconnected
> 
> Has udev actually attempted to do anything by this stage?
> 
> I wasn't seeing anything that spectacular.  It used to be the case that
> udev simply hung.  But in rc7-mm1 the symptoms are that incoming ssh
> sessions hang, but most other things work OK.
> 
> Oh well - Greg has split that tree apart and I shall not be pulling the
> more problematic bits henceforth.

/me pins his hopes on rc7-mm2.

-apw
