Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277262AbRJIOg4>; Tue, 9 Oct 2001 10:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277376AbRJIOgh>; Tue, 9 Oct 2001 10:36:37 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:35204 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S277262AbRJIOg3>; Tue, 9 Oct 2001 10:36:29 -0400
Message-ID: <3BC30B9F.9060609@wipro.com>
Date: Tue, 09 Oct 2001 20:07:19 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: pre6 VM issues
In-Reply-To: <Pine.LNX.4.21.0110091057470.5604-100000@freak.distro.conectiva>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:

>
>On Tue, 9 Oct 2001, BALBIR SINGH wrote:
>
>>Most of the traditional unices maintained a pool for each subsystem
>>(this is really useful when u have the memory to spare), so not matter
>>what they use memory only from their pool (and if needed peek outside),
>>but nobody else used the memory from the pool.
>>
>>I have seen cases where, I have run out of physical memory on my system,
>>so I try to log in using the serial console, but since the serial driver
>>does get_free_page (this most likely fails) and the driver complains back.
>>So, I had suggested a while back that important subsystems should maintain
>>their own pool (it will take a new thread to discuss the right size of
>>each pool).
>>
>>Why can't Linux follow the same approach? especially on systems with a lot
>>of memory.
>>
>
>There is nothing which avoids us from doing that (there is one reserved
>pool I remeber right now: the highmem bounce buffering pool, but that one
>is a special case due to the way Linux does IO in high memory and its only
>needed on _real_ emergencies --- it will be removed in 2.5, I hope).
>
>In general, its a better approach to share the memory and have a unified
>pool. If a given subsystem is not using its own "reversed" memory, another
>subsystems can use it.
>
>The problem we are seeing now can be fixed even without the reserved
>pools.
>
I agree that is the fair and nice thing to do, but I was talking about reserving
memory for device vs sharing it with a user process, user processes can wait,
their pages can even be swapped out if needed. But for a device that is not willing
to wait (GFP_ATOMIC) say in an interrupt context, this might be a issue.


Anyway, how do you plan to solve this ?
Balbir

>
>
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
