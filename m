Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWDNSsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWDNSsh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 14:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWDNSsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 14:48:37 -0400
Received: from terminus.zytor.com ([192.83.249.54]:2466 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751405AbWDNSsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 14:48:36 -0400
Message-ID: <443FEDF9.6050203@zytor.com>
Date: Fri, 14 Apr 2006 11:46:17 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [PATCH][TAKE 3] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256
 limit
References: <443EE4C3.5040409@gmail.com> <443FE1AF.8050507@zytor.com> <443FE560.6010805@gmail.com>
In-Reply-To: <443FE560.6010805@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
> 
> Hello,
> 
> The problem is that boot loader developers did not understand the old 
> statement: "A string that is too long will be automatically truncated by 
> the kernel, a boot loader may allow a longer command line to be passed 
> to permit future kernels to extend this limit."
> 
> Most of them handed the same buffer to < 2.02 protocols and >= 2.0.2 
> protocols. When I've opened bugs against that they claimed that they 
> follow instructions since the 256 limit was explicitly mentioned. I've 
> ended up in patching GRUB my-self to allow this.
> 
> I thought that this should be made clearer... But maybe I did not write 
> it too well.
> 
> I've removed the 255+1 limitation from the boot protocol main 
> description, so there will be no known limit there... And moved it to 
> the <2.02 section notes.
> 
> Can you please suggest a different phrasing? Or maybe you think that it 
> is not needed at all... But then I have a problem of making boot loader 
> fix their code.
> 

Well, obviously, since apparently LILO doesn't properly null-terminate 
long command line.

Thinking about it a bit, the way to deal with the LILO problem is 
probably to actually *usw* the boot loader ID byte we've had in there 
since the 2.00 protocol.  In other words, if the boot loader ID is 0x1X 
where X <= current version (I don't know how LILO manages this ID) then 
truncate the command line to 255 bytes; when this is fixed in LILO then 
LILO gets to bump its boot loader ID version number.

	-hpa

