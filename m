Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWHATas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWHATas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWHATas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:30:48 -0400
Received: from palrel13.hp.com ([156.153.255.238]:5776 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S1751028AbWHATar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:30:47 -0400
Message-ID: <44CFABE0.8020501@hp.com>
Date: Tue, 01 Aug 2006 15:30:40 -0400
From: Mark Seger <Mark.Seger@hp.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Alan Brunelle <Alan.Brunelle@hp.com>
Subject: Re: Accuracy of disk statistics IO counter
References: <44CA3523.9020000@hp.com> <20060729104232.GD13095@suse.de>
In-Reply-To: <20060729104232.GD13095@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>Specifically, I wrote a 1GB file with a blocksize of 1MB, which would 
>>result in 1000 writes at the application level.  What I believe then 
>>happens is that each write turns into 8 128KB requests to the driver, 
>>which should result in 8000 actual writes.  Toss in metadata operations 
>>and who knows what else and the actual number should be a little 
>>higher.  What I've see after repeating the tests a number of times on 
>>2.6.16-27 is numbers ranging from 6800-7000 writes which feels like a 
>>big enough difference to at least point out.
>>    
>>
>
>Install http://brick.kernel.dk/snaps/blktrace-git-20060723022503.tar.gz
>and blktrace your disk for the duration of the test and compare the io
>numbers. Requires 2.6.17 or later, though.
>  
>
I had problems getting blktrace going and posted a note to 
linux-btrace@vger.kernel.org at Alan Brunelle's suggestion and he also 
said he'd take a closer look at it himself.  On the other hand he 
pointed me to 'stap' and I was able to use it to get the details I was 
looking for - SystemTAP really rocks for this type of analysis!  As it 
turns out my assumption about driver blocksize was wrong (sorry about 
that).  It turns out that the size of requests from the driver to the 
disk is 160mb and so the I/O count was smaller than I had anticipated.
-mark


