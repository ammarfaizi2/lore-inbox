Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273733AbRIQWaI>; Mon, 17 Sep 2001 18:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273726AbRIQW31>; Mon, 17 Sep 2001 18:29:27 -0400
Received: from mail.courier-mta.com ([66.92.103.29]:47779 "EHLO
	mail.courier-mta.com") by vger.kernel.org with ESMTP
	id <S273722AbRIQW3S>; Mon, 17 Sep 2001 18:29:18 -0400
In-Reply-To: <Pine.LNX.4.10.10109171434550.9815-100000@forge.redmondlinux.org>
In-Reply-To: <Pine.LNX.4.10.10109171434550.9815-100000@forge.redmondlinux.org> 
From: "Sam Varshavchik" <mrsam@courier-mta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide zip 100 won't mount
Date: Mon, 17 Sep 2001 22:29:42 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.3BA67956.000049CF@ny.email-scan.com>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Cheek writes: 


> looks good, right?  but i put a disk in and i get: 
> 
> Sep 17 14:36:23 seattle kernel: ide-floppy: hdd: I/O error, pc =  0, key =
> 2, asc = 30, ascq =  0
> Sep 17 14:36:23 seattle kernel: ide-floppy: hdd: I/O error, pc = 1b, key =
> 2, asc = 30, ascq =  0
> Sep 17 14:36:23 seattle kernel: hdd: No disk in drive 
> 
> not hardware, as it works in windows on the same machine. 
> 
> any ideas?

The first packet is TEST_UNIT_READY, the second packet is START_STOP_UNIT. 
asc 30/asq 0 decodes to "Incompatible medium installed".  Doesn't sound too 
promising... 

Looking through the driver, it will not fail to open if either of these 
packets fail.  The driver open will fail if it can't decode the subsequent 
READ_FORMAT_CAPACITIES packet.  Try to enabling debugging by initializing 
the IDEFLOPPY_DEBUG macro.  Also, the output of hdparm -i would be useful. 

-- 
Sam 

