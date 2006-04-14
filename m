Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWDNTHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWDNTHK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 15:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWDNTHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 15:07:10 -0400
Received: from terminus.zytor.com ([192.83.249.54]:55481 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751392AbWDNTHH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 15:07:07 -0400
Message-ID: <443FF23B.8020209@zytor.com>
Date: Fri, 14 Apr 2006 12:04:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [PATCH][TAKE 3] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256
 limit
References: <443EE4C3.5040409@gmail.com> <443FE1AF.8050507@zytor.com> <443FE560.6010805@gmail.com> <443FEDF9.6050203@zytor.com> <443FF181.6000004@gmail.com>
In-Reply-To: <443FF181.6000004@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
> H. Peter Anvin wrote:
>>
>> Well, obviously, since apparently LILO doesn't properly null-terminate 
>> long command line.
>>
>> Thinking about it a bit, the way to deal with the LILO problem is 
>> probably to actually *usw* the boot loader ID byte we've had in there 
>> since the 2.00 protocol.  In other words, if the boot loader ID is 
>> 0x1X where X <= current version (I don't know how LILO manages this 
>> ID) then truncate the command line to 255 bytes; when this is fixed in 
>> LILO then LILO gets to bump its boot loader ID version number.
>>
>>     -hpa
> 
> I don't understand...
> 
> If LILO worked until now, it should continue to work after applying this 
> patch, since nothing was changed from its perspective. It will continue 
> to provide 255 characters + null command line, so even if you have 1024 
> max command-line, then you will still receive truncated to 255 chars.
> 

Does anyone know the actual details of the LILO breakage?  If the 
problem is that LILO doesn't null-terminate the string when it's too 
long, then we can deal with this automatically, without introducing 
compile-time options (which were already once rejected.)

If the problem is with LILO booting *old* kernels, then that's going to 
have to require some LILO changes, and probably a boot revision bump.

	-hpa
