Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291250AbSAaTlX>; Thu, 31 Jan 2002 14:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291249AbSAaTlN>; Thu, 31 Jan 2002 14:41:13 -0500
Received: from [63.204.6.12] ([63.204.6.12]:44020 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S291247AbSAaTlF>;
	Thu, 31 Jan 2002 14:41:05 -0500
Message-ID: <3C599DBC.2040802@somanetworks.com>
Date: Thu, 31 Jan 2002 14:40:44 -0500
From: "Deepinder Singh" <dsingh@somanetworks.com>
Organization: Somanetworks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: George Bonser <george@gator.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory leaks with GRE Tunnels
In-Reply-To: <CHEKKPICCNOGICGMDODJKEHPGDAA.george@gator.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the oversight - I am running 2.4.16

It probably is realted. Normally a physical interface really never needs 
to be deleted so maybe no one is thinking of reusing the freed up 
numbers and just grabbing the next unused one ( far less management 
issues ) .

-Deepinder

George Bonser wrote:

> I wonder if this also causes a different problem ... when using CIPE
> (which is a tunnel of a different sort) if I stop a tunnel, I can not
> restart it with the same cipe device number. I get a message that the
> device is in use.  I have to unload and reload the CIPE module to be
> able to use the device numbers configured in the config file. If I
> increment the device each time (e.g. cipcb0, then cipcb1, cipcb2) I
> restart the tunnel, it works.  I wonder if it is something in the way
> Linux handles tunnel interfaces in the generic sense and not just
> limited to GRE.
> 
> By the way, this behavior is on 2.2 kernels, I have no CIPE units
> running 2.4 and you did not mention which kernel version you are
> using.
> 
> 
> 
>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org
>>[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of
>>Deepinder Singh
>>Sent: Thursday, January 31, 2002 10:33 AM
>>To: linux-kernel@vger.kernel.org
>>Subject: Memory leaks with GRE Tunnels
>>
>>
>>Hi ,
>>
>>I have been doing some testing using GRE tunnels in Linux (
>>which btw
>>work great ). I found that creating and deleting a tunnel
>>results in a
>>memory leak.
>>
>>To test it out I wrote a small script that basically loops around
>>creating and then deleting 8000 tunnel interfaces at a time. On the
>>eighth iteration  the system hangs a whole with no error
>>messages. There
>>  was still enoungh virtual memory around even with the leaks so I
>>figured something else is wrong. It turns out that the
>>interface numbers
>>( as seen in ' ip link ls' )  do not seem to be reused when
>>an interface
>>is deleted and as such the system hangs when the number reaches 64K.
>>
>>I suspect the two issues are realted but am more of a cisco
>>guy and know
>>kernel internals. The total mem leak for the 64 K tunnels
>>is about 200 megs.
>>
>>Please cc me if you reply to this post as I am not on the list.
>>
>>thanks,
>>Deepinder Singh
>>Sr. Network Eng.
>>Soma Networks
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe
>>linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


