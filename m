Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUBMT0i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 14:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267181AbUBMT0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 14:26:38 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:33296 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S267180AbUBMT0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 14:26:34 -0500
Message-ID: <402D2687.2000005@techsource.com>
Date: Fri, 13 Feb 2004 14:33:27 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Maximizing and maintaining fragmentation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A colleague and I are doing some experiments, and we are attempting to 
model the layout of the filesystem on our server at work.  We're using 
that model because of certain challenges with the very deep directory 
structure.

We are copying about 30GB to one of our personal computers here on the 
LAN and in order to introduce file fragmentation (to simulate what is 
probably the case in the working environment), we are running 3 tar 
pipes at the same time.

(Interesting:  the combination of the disk access and the built-in NIC 
on the ABIT KV7 make the kernel use about 70% of the CPU, and user space 
is using all of the rest.  We're only doing 100 megabit ethernet, so 
what gives?)

Now, since the actual data is proprietary, we want to run a program on 
the data after we've copied it which will scramble the actual file 
contents before we remove it from the building (we are not concerned 
about compressibility).  But we do not want to alter the structure of 
the data on disk in any other way.  If the scrambler were to determine 
the file size of the original file, write out random data of that same 
size, and then copy the new file over the old one, that would likely 
reduce or eliminate the fragmentation.

My proposal is to open and mmap each file and scramble the data by 
writing to the file in virtual memory.  When the file is unmapped and 
closed, I am assuming that the new data will get written to the same 
physical locations on disk as the original file.


IMPORTANT QUESTION:  When writing to an mmap'ed file, will ext3 
rearrange blocks on disk in order to reduce fragmentation, or will it 
leave the blocks exactly where they are, just overwriting the data?


Thanks.

