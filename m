Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbVKHVHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbVKHVHK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbVKHVHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:07:10 -0500
Received: from sccrmhc13.comcast.net ([63.240.77.83]:5594 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1030353AbVKHVHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:07:07 -0500
In-Reply-To: <b6c5339f0511081139y7ab57ea9y498d9cf4aae9692b@mail.gmail.com>
References: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com> <3587A59B-14FA-4E0F-A598-577E944FCF36@comcast.net> <20051108172244.GR7992@ftp.linux.org.uk> <23F8E4C6-3141-4ECB-B3FF-E9BE6D261EE1@comcast.net> <Pine.LNX.4.61.0511081308360.4837@chaos.analogic.com> <C65925DE-0F6F-401E-8D47-2EE3F8D5191C@comcast.net> <Pine.LNX.4.61.0511081316390.4913@chaos.analogic.com> <b6c5339f0511081139y7ab57ea9y498d9cf4aae9692b@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FC49A7EB-A267-4C94-8739-2321C4DC1A1B@comcast.net>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Al Viro <viro@ftp.linux.org.uk>,
       Linux kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: Compatible fstat()
Date: Tue, 8 Nov 2005 16:06:51 -0500
To: Bob Copeland <email@bobcopeland.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 8, 2005, at 2:39 PM, Bob Copeland wrote:

> Isn't this just because the device size is > 2**32?  What if you  
> use fseeko(3)
> and #define _FILE_OFFSET_BITS 64?
>

Yep. I got it to return the correct hard disk size (17Gb) using  
lseek64 and
#define _LARGEFILE64_SOURCE
#define _FILE_OFFSET_BITS 64

Here is what I did
-------------------------------------------------
#define _LARGEFILE64_SOURCE
#define _FILE_OFFSET_BITS 64
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main()
{
         int f;
         off64_t off=0;
         f = open("/dev/hda", O_RDONLY );
         if(f <= 0){
                 perror("open");
                 exit(0);
         }
         off = lseek64(f, 0, SEEK_SET);
         off = lseek64(f, 0, SEEK_END);
         perror("llseek");
         printf ("Size %lld\n", off);
         close(f);
         return 0;
}



> Okay, still not portable and there is probably a better way that  
> doesn't rely
> on such nonsense.  For example, since you have a minimum size in mind,
> just seek that much and see if it works - you don't really need to  
> know the
> whole disk size for that.  Or figure out the best way on all of  
> your platforms
> and abstract it.

Now this gives me a clue what Ted was referring to as binary search  
in e2fsprogs.
If nothing works this should work portably I guess.

Thanks
Parag 
