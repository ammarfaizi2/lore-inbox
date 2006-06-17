Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWFQJcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWFQJcs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 05:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWFQJcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 05:32:48 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:28067 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751135AbWFQJcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 05:32:47 -0400
Date: Sat, 17 Jun 2006 11:32:09 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       aviro@www.linux.org.uk, axboe@suse.de, nigel@suspend2.net
Subject: Re: Sparse minor space in ub
In-Reply-To: <20060616230929.GB31626@kroah.com>
Message-ID: <Pine.LNX.4.61.0606171126040.15799@yvahk01.tjqt.qr>
References: <20060614235404.31b70e00.zaitcev@redhat.com> <20060616230929.GB31626@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Jun 14, 2006 at 11:54:04PM -0700, Pete Zaitcev wrote:
>> --- linux-2.6.17-rc5/Documentation/devices.txt	2006-05-25 14:02:59.000000000 -0700
>> +++ linux-2.6.17-rc5-lem/Documentation/devices.txt	2006-05-25 15:45:34.000000000 -0700
>> @@ -2552,10 +2552,10 @@ Your cooperation is appreciated.
>>  		 66 = /dev/usb/cpad0	Synaptics cPad (mouse/LCD)
>>  
>>  180 block	USB block devices
>> -		0 = /dev/uba		First USB block device
>> -		8 = /dev/ubb		Second USB block device
>> -		16 = /dev/ubc		Thrid USB block device
>> -		...
>> +		  0 = /dev/uba		First USB block device
>> +		 16 = /dev/ubb		Second USB block device
>> +		 32 = /dev/ubc		Third USB block device
>> +		    ...
>
>I don't think that distros that have a static /dev will like this change
>at all :(
>
>Anyway to put the extra partitions some where else in the minor range?

(a)
  come with something up like glibc's compatibility scheme for high device 
  numbers, ie.

    minor = ((ubdisk & 0x1F)  << 4) | (ubpart & 0x03) |
            ((ubdisk & ~0x1F) << 9) | ((ubpart & 0x08) << 8)

  bits 10 09 08 | 07 06 05 04 03 02 01 00
  old              d  d  d  d  d  p  p  p
  new ..d  d  p |  d  d  d  d  d  p  p  p

  Would give the usual 16 partitions. But see (b).


(b)
  "181 block" seems free.
  Suggestion: have block-major-180 be ub disks with 8 parts max (and marked 
  as deprecated)
  and block-major-181 be ub disks with 16 parts max



Jan Engelhardt
-- 
