Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283443AbRLEQMD>; Wed, 5 Dec 2001 11:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283724AbRLEQLx>; Wed, 5 Dec 2001 11:11:53 -0500
Received: from mail.spylog.com ([194.67.35.220]:17814 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S283443AbRLEQLn>;
	Wed, 5 Dec 2001 11:11:43 -0500
Date: Wed, 5 Dec 2001 19:12:03 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: SpyLOG
X-Priority: 3 (Normal)
Message-ID: <41187009255.20011205191203@spylog.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, theowl@freemail.c3.hu, theowl@freemail.hu,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re[2]: your mail on mmap() to the kernel list
In-Reply-To: <20011204174824.D3447@athlon.random>
In-Reply-To: <3C082244.8587.80EF082@localhost>,
 <3C082244.8587.80EF082@localhost> <61437219298.20011201113130@spylog.ru>
 <3C08A4BD.1F737E36@zip.com.au> <20011204151549.U3447@athlon.random>
 <16498470022.20011204183624@spylog.ru> <20011204174824.D3447@athlon.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

Tuesday, December 04, 2001, 7:48:24 PM, you wrote:

>> AA> You can fix the problem in userspace by using a meaningful 'addr' as
>> AA> hint to mmap(2), or by using MAP_FIXED from userspace, then the kernel
>> AA> won't waste time searching the first available mapping over
>> AA> TASK_UNMAPPED_BASE.
>> Well. Really you can't do this, because you can not really track all of

AA> I can do this sometime, I did it in the patch I posted for example.
Well. You're really easy may do this only in such dumb test example
then you do something real between mmaps even memory allocation in
multi threaded program you will not able to track it.

AA>  If
AA> you want transparency and genericity you can still do it in userspace
AA> with an LD_LIBRARY_PATH that loads a libc that builds the hole-lookup
AA> data structure (tree?) internally, and then passes the hint to the
AA> kernel if the program suggests 0.

Well but it's not really easy and right thing to do as you will also
need to write your own memory allocator (as standard one uses mmap so
you can get in recursive loop).  And also it will be really
platform/kernel dependent as different kernels may use different
addresses there user part of address space available for mmaping
starts.

AA> OTOH I prefer those kind of algorithms (if needed) to be in the kernel
AA> so they're faster/cleaner and also a lib would need some magic knowledge
AA> about kernel internals virtual addresses to do it right.
Yes. I'm quite agree with that.  Also if you have one tree implemented
it should not be too hard to have a second tree indexed by other
field.

>> AA> the common case should matter more I guess, and of course userspace can
>> AA> just fix this without any kernel modification by passing an helpful
>> AA> "addr", to the mmap syscall with very very little effort.  Untested
>> AA> patch follows:
>> 
>> Could you please explain a bit how this the hint works ? Does it tries

AA> man 2 mmap, then search for 'start'

I've read it of course :)

>> only specified address or also tries to look up the free space from
>> this point ?

AA> in short it checks if there's 'len' free space at address 'start', and
AA> if there is, it maps it there, without having to search for the first
AA> large enough hole in the heap.

I understand it but does it start so search standard way from the low
addresses or it looks it above the hint address before looking at
lower addresses ?


-- 
Best regards,
 Peter                            mailto:pz@spylog.ru

