Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277243AbRJIORG>; Tue, 9 Oct 2001 10:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277241AbRJIOQ5>; Tue, 9 Oct 2001 10:16:57 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:4601 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S277243AbRJIOQr>; Tue, 9 Oct 2001 10:16:47 -0400
Message-ID: <3BC30701.2060908@wipro.com>
Date: Tue, 09 Oct 2001 19:47:37 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: pre6 VM issues
In-Reply-To: <Pine.LNX.4.21.0110091031470.5604-100000@freak.distro.conectiva>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Most of the traditional unices maintained a pool for each subsystem
(this is really useful when u have the memory to spare), so not matter
what they use memory only from their pool (and if needed peek outside),
but nobody else used the memory from the pool.

I have seen cases where, I have run out of physical memory on my system,
so I try to log in using the serial console, but since the serial driver
does get_free_page (this most likely fails) and the driver complains back.
So, I had suggested a while back that important subsystems should maintain
their own pool (it will take a new thread to discuss the right size of
each pool).

Why can't Linux follow the same approach? especially on systems with a lot
of memory.


Balbir

Marcelo Tosatti wrote:

>Hi, 
>
>I've been testing pre6 (actually its pre5 a patch which Linus sent me
>named "prewith 16GB of RAM (thanks to OSDLabs for that), and I've found
>out some problems. First of all, we need to throttle normal allocators
>more often and/or update the low memory limits for normal allocators to a
>saner value. I already said I think allowing everybody to eat up to
>"freepages.min" is too low for a default.
>
>I've got atomic memory failures with _22GB_ of swap free (32GB total):
>
> eth0: can't fill rx buffer (force 0)!
>
>Another issue is the damn fork() special case. Its failing in practice:
>
>bash: fork: Cannot allocate memory
>
>Also with _LOTS_ of swap free. (gigs of them)
>
>Linus, we can introduce a "__GFP_FAIL" flag to be used by _everyone_ which
>wants to do higher order allocations as an optimization (eg allocate big
>scatter-gather tables or whatever). Or do you prefer to make the fork()
>allocation a separate case ?
>
>I'll take a closer look at the code now and make the throttling/limits to
>what I think is saner for a default.
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
