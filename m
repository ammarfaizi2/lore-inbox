Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbUKEP2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUKEP2Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 10:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbUKEP2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 10:28:23 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:42374 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261273AbUKEP1P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 10:27:15 -0500
Message-ID: <418AA16D.40002@tmr.com>
Date: Thu, 04 Nov 2004 16:38:53 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mark slutz <mystuff.mark@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: mmap going to wrong physical address
References: <6707bb6404110313514013794e@mail.gmail.com>
In-Reply-To: <6707bb6404110313514013794e@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mark slutz wrote:
> I am writting an application that needs control over large (1gig+)
> portions of contiguous memory. I am currently doing this by using
> mem=1024m during boot. My system is a dual opteron with 5 gig of
> memory. In my program I have
> 
> if ((fd=open("/dev/mem", O_RDWR))<0)
> {
> perror("open");
> exit(-1);
> }
> 
> 
> PtrMemoryBase = (void *) mmap64(
> NULL,
> size,
> PROT_READ | PROT_WRITE,
> MAP_FILE | MAP_SHARED,
> fd,
> base );
> 
> size = 1MB
> 
> I also have -D_FILE_OFFSET_BITS=64.
> 
> If base is between 1 and 3 gig the process works fine. When base is 4
> gig + the mmap64 works but the memory does not seem to be mapped to
> the base location. I write a pattern to PtrMemoryBase then have my
> hardware start doing DMA transfers from the base address but I do not
> get the data I wrote to PtrMemoryBase.
> 
> Thanks for any help

I'm not sure it will help, but have you tried the MAP_FIXED option, and 
is your address which doesn't work a multiple of the page size?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

