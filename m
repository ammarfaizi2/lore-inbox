Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTKUTbw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 14:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTKUTbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 14:31:52 -0500
Received: from wiproecmx1.wipro.com ([164.164.31.5]:49793 "EHLO
	wiproecmx1.wipro.com") by vger.kernel.org with ESMTP
	id S261825AbTKUTbu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 14:31:50 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: DIRECT IO for ext3/ext2.
Date: Sat, 22 Nov 2003 01:00:01 +0530
Message-ID: <1E27FF611EBEFB4580387FCB5BEF00F3013DEF08@blr-ec-msg04.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: DIRECT IO for ext3/ext2.
Thread-Index: AcOwVYZVhta0cJP4RICPvJsL45czXgAD8HKw
From: <dhruv.anand@wipro.com>
To: <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Nov 2003 19:30:01.0561 (UTC) FILETIME=[DB665C90:01C3B065]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for your reply. I looked into the boundary alignment issue. 
Observed something strange happening;

I wrote my own kernel module and then;
1. retrieved the block size = 4096 using block_size(struct block_device
*bdev) 
2. in the user application i did a lseek by 4906 (block size seek) 
3. then found the address of the variable i wanted to read into, to be
block 
   size aligned.

However, the read still seems to fail with the O_DIRECT flag specified. 
The same check _passes if i do not specify the flag in open of the
device.

Boundary issues seem to be not the cause of failure here.
Would have any more kind suggestions on something that i should do or
could be missing on?

Regards
Dhruv

>>-----Original Message-----
>>From: Andrew Morton [mailto:akpm@osdl.org] 
>>Sent: Friday, November 21, 2003 11:11 PM
>>To: Dhruv Prem Anand (WT01 - EMBEDDED & PRODUCT ENGINEERING SOLUTIONS)
>>Cc: linux-kernel@vger.kernel.org; akpm@zip.com.au; 
>>janetinc@us.ibm.com; pbadari@us.ibm.com; nathans@sgi.com
>>Subject: Re: DIRECT IO for ext3/ext2.
>>
>>
>><dhruv.anand@wipro.com> wrote:
>>>
>>> 
>>> Hi,
>>> I am working on an application on linux-2.6 that needs to 
>>bypass the 
>>> buffer cache. In order to do so i use the direct IO functionality. 
>>> Although open to the device succeeds with the DIRECT_IO flag, read 
>>> from the device fails.
>>> 
>>> Following is the exceprt fromt he code to open and read;
>>> --------------------------------------------------------
>>> 
>>> if ((devf = open(dumpdev, O_RDONLY | O_DIRECT, 0)) < 0) {
>>>      fprintf(KL_ERRORFP, "Error: open failed!\n");
>>>      ...
>>> }
>>> 
>>> if(err = read(devf, &magic_nr, sizeof(magic_nr)) != 
>>sizeof(magic_nr)) {
>>>      fprintf(KL_ERRORFP, "Error: read() failed!\n");
>>>       ...
>>> }
>>> 
>>> ---------------------------------------------------------
>>> I am returned an errno=22, indicating 'Invalid argument'
>>> 
>>
>>O_DIRECT reads must be aligned to the filesystem blocksize.  
>>Both the memory address and the file offset must be thus aligned.
>>
>>
