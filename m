Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278714AbRKMUQG>; Tue, 13 Nov 2001 15:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278732AbRKMUP5>; Tue, 13 Nov 2001 15:15:57 -0500
Received: from mw3.texas.net ([206.127.30.13]:62119 "EHLO mw3.texas.net")
	by vger.kernel.org with ESMTP id <S278714AbRKMUPu>;
	Tue, 13 Nov 2001 15:15:50 -0500
Message-ID: <3BF17F5F.1090704@btech.com>
Date: Tue, 13 Nov 2001 14:15:27 -0600
From: "Malcolm H. Teas" <mhteas@btech.com>
Organization: Blaze Technology, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Ramdisk ioctl bug fix, kernel 2.4.14
In-Reply-To: <200111131656.fADGuWn06695@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

>>Most disk devices can't change their size with a few commands as a ram disk can 
>>as it's a physical constant.  Ram disks are virtual so their size is whatever 
>>the user specifies, with a kernel configured upper limit.  I argue that the size 
>>is the allocated amount, not the upper limit.
>>
> 
> I think your problem is that you are querying the disk to ask it the file
> system size ? If so you asked the wrong code


I take your point.  The file system knows its right size.  However, it would 
still be useful to be able to tell what the ram disk allocated size actually is. 
  Currently there's no good mechanism I know of that returns the actual 
allocated size.

I'm using ram disks as a way of building a single floppy linux I'm working on (a 
variation on LRP and Tom's Root Boot).  Some of the time in this process I have 
ram disk(s) without filesystems to query for the size.  It's also possible to 
build a filesystem that's smaller than the allocated size.

Mypatch doesn't affect userland tools like "du" and "df" since they query the 
filesystem for the size.  It does fix lowel-level tools that look at the ramdisk 
and not the filesystem.

Having the ramdisk report the max possible size and not the allocated size is 
akin to having a physical hard disk report the theoretical max that could be 
achieved using current technology, not the actual blocks the device is built to 
hold.

-Malcolm

