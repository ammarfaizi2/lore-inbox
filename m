Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277194AbRJIN3g>; Tue, 9 Oct 2001 09:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277197AbRJIN30>; Tue, 9 Oct 2001 09:29:26 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:34526 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S277194AbRJIN3P>; Tue, 9 Oct 2001 09:29:15 -0400
Message-ID: <3BC2FBDD.7000703@wipro.com>
Date: Tue, 09 Oct 2001 19:00:05 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Kirill Ratkin <kratkin@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: No locking is needed ... why?
In-Reply-To: <20011009131357.60638.qmail@web11905.mail.yahoo.com>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Kirill Ratkin wrote:

>Hi.
>
>Could somebody explain me this comment?:
>/*
> * Incoming packets are placed on per-cpu queues so
>that
> * no locking is needed.
> */
>
>struct softnet_data
>{
>        int                     throttle;
>        int                     cng_level;
>        int                     avg_blog;
>        struct sk_buff_head     input_pkt_queue;
>        struct net_device       *output_queue;
>        struct sk_buff          *completion_queue;
>} __attribute__((__aligned__(SMP_CACHE_BYTES)));
>
>I didn't understand why packets are placed so and why
>locking isn't needed?
>

As I understand this, the only reason u lock is 

1) In an SMP or multiprocessor system, you suspect somebody else is running
   simultaneously with you, this can lead to two or more processors executing
   the same code simultaneously, this may lead to races.(which u do not want).
2) In a Multiprocessor or uniprocesor, data is shared among user processes in the kernel
   or
   between a user process in the kernel and an interrupt context
  (like an irq handler or a bottom half or a tasklet).

So if u have a situation where (2) does not hold and u have a multiprocessor system,
per CPU data need not be locked, since it is not visible/used by other processors.

Did I get it right?
Balbir

>
>__________________________________________________
>Do You Yahoo!?
>NEW from Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
>http://geocities.yahoo.com/ps/info1
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>




--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------


--------------InterScan_NT_MIME_Boundary--
