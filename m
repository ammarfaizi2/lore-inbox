Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWJHCdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWJHCdj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 22:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWJHCdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 22:33:39 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:25077 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750755AbWJHCdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 22:33:38 -0400
Message-ID: <45286380.1060809@comcast.net>
Date: Sat, 07 Oct 2006 22:33:36 -0400
From: Ed Sweetman <safemode2@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: Casey Dahlin <cjdahlin@ncsu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unable to find root fs with libata only 2.6.18-mm3
References: <45284BE0.7030600@comcast.net> <1160270544.10398.3.camel@localhost.localdomain>
In-Reply-To: <1160270544.10398.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Dahlin wrote:
>> My question is, do I still need to compile in scsi disk/cdrom/generic 
>> support into my kernel to get libata devices to work or is there some 
>> other syntax i'm missing?
>>     
>
> The initrd image provides the ramdisk image which contains modules not
> compiled into the kernel which are necessary to access the root
> filesystem. Man mkinitrd should explain how to set it up.
>
> Casey Dahlin
>
>   

I'm not using initrd. All my drivers are compiled in that are needed at 
boot. My question was in regards to the vagueness of just what the 
Libata drivers require to actually work in a system.  The libata drivers 
will load and detect devices just fine without scsi compiled into the 
kernel, they will however be completely useless since they wont be 
assigning the drives detected on the busses to anything. 

If libata is to be considered an alternative to scsi and ide (as it 
should be, and as it is by it's location in the config now) then why is 
it still treated as a subset of scsi in the config, requiring you to 
compile in scsi drivers just like you would have had to do anyway if 
libata was back in it's normal position under SCSI to make any actual 
use of libata devices?  

It seems like the move out of the scsi tree was pointless, and just adds 
confusion since the driver tree isn't ready and hasn't got the makefiles 
and kernel config scripts written to reuse the scsi drivers it requires 
when someone wants a libata disk or cdrom or whatever device 
transparently.   If libata is to be on the same level as ide and scsi in 
the config, then I shouldn't need to go into scsi to get a libata drive 
to work.

It should be a matter of adding some config options under the libata 
section for "disk support" and "cdrom support", etc  and kconfig should 
auto enable the scsi device options required.    Maybe just move those 
top level scsi drivers into some shared block layer directory since 
eventually we'll be left with usb/libata/scsi and they'll all use those 
top level drivers to do their device access. 



