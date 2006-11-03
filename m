Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753211AbWKCLEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbWKCLEr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 06:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbWKCLEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 06:04:47 -0500
Received: from mta.songnetworks.no ([62.73.241.54]:54738 "EHLO
	pebbles.fastcom.no") by vger.kernel.org with ESMTP id S1753211AbWKCLEq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 06:04:46 -0500
Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <45474FF3.2010200@cfl.rr.com>
References: <C5C787DB-6791-462E-9907-F3A0438E6B9C@karlsbakk.net> <453960B3.6040006@gmail.com> <D3D931E5-0EA7-4CC4-A59D-364C65335DBA@karlsbakk.net> <A9AF211A-08C8-4FC4-8280-D3AA3136FF3B@karlsbakk.net> <45474FF3.2010200@cfl.rr.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6B0A1554-ADEE-47C2-83B1-A3E0A94C7484@karlsbakk.net>
Content-Transfer-Encoding: 7bit
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Re: Debugging I/O errors further?
Date: Fri, 3 Nov 2006 12:04:42 +0100
To: Phillip Susi <psusi@cfl.rr.com>, LKML <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Sorry for stressing this, but is there a way I can debug this  
>> further? it's a seagate drive connected to a sata_sil controller.  
>> I only get ext3 errors, and it fails after a while whatever I do
>
> Only idea I have is to unmount the drive ( or remount r/o ) and  
> repeatedly md5sum the block device and see if it ever fails to  
> correctly read the data, and if you get any errors in your syslog.   
> If you get no error messages in your syslog and md5sum completes  
> without error but does not get the same hash each time, then there  
> is definitely something very fubar with the hardware or deep in the  
> kernel.

md5sum has now been running in a loop for some 22 hours and completed  
11 sums of the drive (md5summing 400 gigs takes a little while). the  
md5sum is identical for each test,  and the syslog has no error  
indications. Then, starting harddisk stresstest, I get this error  
again after about an hour testing:

Nov  3 11:33:17 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks: Freeing blocks not in datazone - block =  
1349004846, count = 1
Nov  3 11:33:20 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks: Freeing blocks not in datazone - block =  
1449605700, count = 1
Nov  3 11:33:23 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks: Freeing blocks not in datazone - block = 629024587,  
count = 1
Nov  3 11:33:24 ganske kernel: EXT3-fs error (device sda1):  
ext3_free_blocks: Freeing blocks not in datazone - block =  
1059741014, count = 1
...

So, error only occurs on filesystem usage, not with direct  
blockdevice access.

Any ideas?

roy
--
Roy Sigurd Karlsbakk
roy@karlsbakk.net
-------------------------------
MICROSOFT: Acronym for "Most Intelligent Customers Realise Our  
Software Only Fools Teenagers"

