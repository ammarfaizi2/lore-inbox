Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274990AbRJJHUm>; Wed, 10 Oct 2001 03:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275021AbRJJHUc>; Wed, 10 Oct 2001 03:20:32 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:7850 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S274990AbRJJHUU>; Wed, 10 Oct 2001 03:20:20 -0400
Message-ID: <3BC3F6E1.4060309@wipro.com>
Date: Wed, 10 Oct 2001 12:51:05 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
In-Reply-To: <20011010123603.A17043@in.ibm.com>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dipankar Sarma wrote:

>In article <3BC3D9ED.6050901@wipro.com> BALBIR SINGH wrote:
>
>>What about cases like the pci device list or any other such list. Sometimes
>>you do not care if somebody added something, while you were looking through
>>the list as long as you do not get illegal addresses or data.
>>Wouldn't this be very useful there? Most of these lists come up
>>at system startup and change rearly, but we look through them often.
>>
>
>How often does the linux kernel need to go through the PCI device
>list ? Looking at only SCSI code, it seems that not very often.
>If that is the case in general, optimizing it for lockless
>lookup (assuming that you use RCU or something to support deletion),
>is probably an overkill.
>
Almost all pci drivers use the pci_find_slot or some functionality that
requires a scan of all the pci devices (to identify their device). I agree
that it is not very often. 

>
>One example of where it is useful is maintenance of route information
>in either storage or network. Route information changes infrequently but
>needs to be looked up for every I/O and being able to do lockless
>lookup here is a good gain.
>
I have a question, can this kind of locking used in cases where an interrupt
context may be involved. For example looking through the list of timers, we
disable interrupts and grab a lock using spin_lock_irqsave(&timerlist_lock, flags)

Should we just use __cli() with the RCU or something similar? or  can RCU
be used in such cases?

Thanks,
Balbir

>
>
>Thanks
>Dipankar
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
