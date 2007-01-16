Return-Path: <linux-kernel-owner+w=401wt.eu-S1750975AbXAPS7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbXAPS7M (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbXAPS7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:59:10 -0500
Received: from mail.tmr.com ([64.65.253.246]:45966 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbXAPS7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:59:06 -0500
Message-ID: <45AD2100.9030900@tmr.com>
Date: Tue, 16 Jan 2007 14:01:20 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Linux Portal <linportal@gmail.com>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Simple utility to measure disk random access time
References: <ceccffee0701160649w5e401cf9i433f61beeb26e2b1@mail.gmail.com>
In-Reply-To: <ceccffee0701160649w5e401cf9i433f61beeb26e2b1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Portal wrote:
> And a few graphs here: http://linux.inet.hr/how_fast_is_your_disk.html
> 
> Comments welcome!

These results:

gaimboi:davidsen> ./da /dev/hdb
Seeker v2.0, 2007-01-15, http://linux.inet.hr/how_fast_is_your_disk.html
Benchmarking /dev/hdb [0MB], wait 30 seconds..............................
Results: 565841 seeks/second, 0.00 ms random access time
gaimboi:davidsen> ./da /dev/hda
Seeker v2.0, 2007-01-15, http://linux.inet.hr/how_fast_is_your_disk.html
Benchmarking /dev/hda [19092MB], wait 30 
seconds..............................
Results: 49 seeks/second, 20.20 ms random access time
gaimboi:davidsen> ./da /dev/hdc
Seeker v2.0, 2007-01-15, http://linux.inet.hr/how_fast_is_your_disk.html
Benchmarking /dev/hdc [57241MB], wait 30 
seconds..............................
Results: 64 seeks/second, 15.56 ms random access time


led to this patch:

RCS file: RCS/disk_access.c,v
retrieving revision 1.1
diff -r1.1 disk_access.c
67a68,72
 >       if (numblocks <= 0) {
 >               /* pretty small disk found here */
 >               printf("Disk too small, size: %d blocks\n", numblocks);
 >               exit(EXIT_FAILURE);
 >       }
69a75
 >

and this warning:

gaimboi:davidsen> ./da /dev/hdb
Seeker v2.0, 2007-01-15, http://linux.inet.hr/how_fast_is_your_disk.html
Disk too small, size: 0 blocks


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
