Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284424AbRLEOgs>; Wed, 5 Dec 2001 09:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284425AbRLEOgh>; Wed, 5 Dec 2001 09:36:37 -0500
Received: from mail.spylog.com ([194.67.35.220]:22400 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S284424AbRLEOgW>;
	Wed, 5 Dec 2001 09:36:22 -0500
Date: Wed, 5 Dec 2001 17:36:45 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: SpyLOG
X-Priority: 3 (Normal)
Message-ID: <19181290892.20011205173645@spylog.ru>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        theowl@freemail.c3.hu, <theowl@freemail.hu>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re[3]: your mail on mmap() to the kernel list
In-Reply-To: <Pine.LNX.4.33L.0112041439210.4079-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0112041439210.4079-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rik,

Tuesday, December 04, 2001, 7:42:28 PM, you wrote:


>> Well. Really you can't do this, because you can not really track all of
>> the mappings in user program as glibc and probably other libraries
>> use mmap for their purposes.

RvR> There's no reason we couldn't do this hint in kernel space.

Yes. This cache will probably give a good hit rate. It of course does
not decrease mathematical complexity but speeding the things up couple
of times is good anyway :)

RvR> In arch_get_unmapped_area we can simply keep track of the
RvR> lowest address where we found free space, while on munmap()
RvR> we can adjust this hint if needed.

RvR> OTOH, I doubt it would help real-world workloads where the
RvR> application maps and unmaps areas of different sizes and
RvR> actually does something with the memory instead of just
RvR> mapping and unmapping it ;)))


Well this is quite simple I think. Database may use mmap to access the
data in files, as you can't map everything to 32bit address space you
will have to map just parts of the files, therefore as you can't have
to much mapped chunks you will have different chunk sizes to merge
continuos mmaped areas. Other thing some databases support different
physical page sizes so this will be true even without merging.

One more thing: fread at least in some cases does mmap of the file -
so if you use it aggressively you will get in the problem.

Anyway in most cases even then mmaped chunks are different sizes most
of them should be around the same size in the most cases.





-- 
Best regards,
 Peter                            mailto:pz@spylog.ru

