Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285203AbRL2Sq3>; Sat, 29 Dec 2001 13:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285186AbRL2SqT>; Sat, 29 Dec 2001 13:46:19 -0500
Received: from conx.aracnet.com ([216.99.200.135]:46536 "HELO cj90.in.cjcj.com")
	by vger.kernel.org with SMTP id <S285250AbRL2SqQ>;
	Sat, 29 Dec 2001 13:46:16 -0500
Message-ID: <3C2E0F6C.30608@cjcj.com>
Date: Sat, 29 Dec 2001 10:46:04 -0800
From: CJ <cj@cjcj.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Dave Jones <davej@codemonkey.org.uk>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Dave Jones <davej@suse.de>, Chuck Lever <cel@monkey.org>
Subject: Re: Possible O_DIRECT problems ?
In-Reply-To: <20011221000806.A26849@suse.de> <shssna58lpq.fsf@charged.uio.no> <20011221003942.B26268@codemonkey.org.uk> <20011229162542.G1356@athlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't O_DIRECT's requirements come from the hardware?  If we can 
ASPI or CAM DMA SCSI devices to odd addresses and lengths, why not 
O_DIRECT?  Do ape drives DMA to user buffers?  Are O_DIRECT's 
current limits gratuitous?


Andrea Arcangeli wrote:

>On Fri, Dec 21, 2001 at 12:39:42AM +0000, Dave Jones wrote:
>
>>On Fri, Dec 21, 2001 at 01:23:45AM +0100, Trond Myklebust wrote:
>>
>> >    O_DIRECT for NFS isn't yet merged into the kernel. Are these Chuck
>> > Lever's NFS patches you've been testing?
>>
>>Nope, stock 2.4.17rc2 & 2.5.1. 
>>I thought NFS might just ignore the O_DIRECT flag if it didn't
>>understand it yet, I wasn't expecting such a dramatic failure.
>>
>
>The point of O_DIRECT is to do DMA directly into the userspace memory
>(and to avoid the VM overhead but that's a secondary issue and with data
>journaling we may need to put an anchor into the VM to serialize the
>direct I/O with the pagecache I/O in a secondary - slower - direct_IO
>callback for the data journaling fs).
>
>But to avoid the mem copies you're required to use strict alignment and
>size of the userspace buffers, just like rawio.
>
>If you don't you will get -EINVAL. This ensures people will use O_DIRECT
>correctly in their apps. In short every single bugreport like this about
>this -EINVAL strict behaviour is the proof we need to be strict and to
>return -EINVAL :)
>
>Andrea
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>.
>


