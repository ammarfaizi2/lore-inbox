Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbSJWCmu>; Tue, 22 Oct 2002 22:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262776AbSJWCmt>; Tue, 22 Oct 2002 22:42:49 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:14033 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262722AbSJWCmr>;
	Tue, 22 Oct 2002 22:42:47 -0400
Message-ID: <3DB60E16.2060401@candelatech.com>
Date: Tue, 22 Oct 2002 19:48:54 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lk Overrun <lkoverrun@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Brust data send problem on gigabit NIC on Linux
References: <20021023015905.63415.qmail@web21501.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lk Overrun wrote:
> Hi, I am seeking advice on how to best send out huge
> number of packets on a gigabit ethernet interface.  I
> am using kernel 2.4.19.  I try to send out as many as
> possible 15Kbyte-long ethernet packets to try to
> utilize the giga-bit/sec bandwidth.  My CPU is really
> fast (2 GHz) amd I dump the packets to the interface
> in a  tight loop in user space.  However, I can only
> reach around 400 Mbits/sec before the packets get
> dropped.  The queue discipline (qdisc) seems to be
> responsible because the queue length (txqueuelen) is
> only 100 by default, and the queue just cannot store
> so many packets at once.  I can eliminate the packet
> drop by raising the queue length to somewhere like
> 60000 but that is not practical because it uses too
> much memory. It seems I need some delay between
> sending packets but I cannot sleep for less than 10 ms
> (1/Hz) in user space and 10 ms is too long.
> 
> I am using raw socket bypassing the IP stack and my
> NIC is the Intel Pro1000 (using the e1000.o driver).
> 
> What is the best way to send raw ethernet packets,
> reaching gigabit range withuut packet drop on Linux? 
> Thanks for any advice.

Make sure the e1000 driver is tuned, try insmodding it with:
TxDescriptors=1024 RxDescriptors=4096

Also, in your user-space app, check the return code of your
packet-sending call.  That can let you know that the kernel
dropped it, and that you need to re-send.

How do you know you are dropping packets?  (Ie, are you also
reading on another machine?)  Usually it's read that drops
more packets than write.

Good luck,
Ben

> 
>  
> 
> __________________________________________________
> Do you Yahoo!?
> Y! Web Hosting - Let the expert host your web site
> http://webhosting.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


