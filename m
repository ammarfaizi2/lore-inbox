Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287886AbSBIAZt>; Fri, 8 Feb 2002 19:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287872AbSBIAZl>; Fri, 8 Feb 2002 19:25:41 -0500
Received: from ns1.intercarve.net ([216.254.127.221]:37780 "HELO
	ceramicfrog.intercarve.net") by vger.kernel.org with SMTP
	id <S287279AbSBIAZc>; Fri, 8 Feb 2002 19:25:32 -0500
Date: Fri, 8 Feb 2002 19:21:50 -0500 (EST)
From: "Drew P. Vogel" <dvogel@intercarve.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linus' email account is full. - Fwd: Mail System Error -  Returned
 Mail
In-Reply-To: <5.1.0.14.2.20020208201734.038322c0@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.33.0202081921250.12986-100000@northface.intercarve.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the missing a in transmet.com intentional?

--Drew Vogel

On Fri, 8 Feb 2002, Anton Altaparmakov wrote:

>Linus' email account appears to be full if we can believe this returned email:
>
>>Envelope-to: aia21@cus.cam.ac.uk
>>To: aia21@cam.ac.uk
>>From: Mail Administrator <Postmaster@transmet.com>
>>Reply-To: Mail Administrator <Postmaster@transmet.com>
>>Subject: Mail System Error - Returned Mail
>>Date: Fri, 8 Feb 2002 15:14:23 -0500
>>
>>This Message was undeliverable due to the following reason:
>>
>>The user(s) account is temporarily over quota.
>>
>><usr3189@transmet.com>
>>
>>Please reply to Postmaster@transmet.com
>>if you feel this message to be in error.
>>Reporting-MTA: dns; imta04a2.registeredsite.com
>>Arrival-Date: Fri, 8 Feb 2002 15:14:23 -0500
>>Received-From-MTA: dns; orange.csi.cam.ac.uk (131.111.8.77)
>>
>>Final-Recipient: RFC822; <torvalds@transmet.com>
>>Action: failed
>>Status: 4.2.2
>>X-Actual-Recipient: RFC822; <usr3189@transmet.com>
>>Received: from orange.csi.cam.ac.uk ([131.111.8.77])
>>           by imta04a2.registeredsite.com with ESMTP
>>           id
>> <20020208201423.QUCD3217.imta04a2.registeredsite.com@orange.csi.cam.ac.uk>
>>           for <torvalds@transmet.com>; Fri, 8 Feb 2002 15:14:23 -0500
>>Received: from tmd.christs.cam.ac.uk ([131.111.219.75] helo=tmd.cam.ac.uk)
>>         by orange.csi.cam.ac.uk with esmtp (Exim 3.34 #1)
>>         id 16ZHOo-0007Tk-00; Fri, 08 Feb 2002 20:13:34 +0000
>>Message-Id: <5.1.0.14.2.20020208174632.00b0dad0@pop.cus.cam.ac.uk>
>>X-Sender: aia21@pop.cus.cam.ac.uk
>>X-Mailer: QUALCOMM Windows Eudora Version 5.1
>>Date: Fri, 08 Feb 2002 20:14:32 +0000
>>To: nigel@nrg.org
>>From: Anton Altaparmakov <aia21@cam.ac.uk>
>>Subject: Re: [RFC] New locking primitive for 2.5
>>Cc: Christoph Hellwig <hch@ns.caldera.de>,Ingo Molnar <mingo@elte.hu>,
>>  yodaiken <yodaiken@fsmlabs.com>,Martin Wirth <Martin.Wirth@dlr.de>,
>>  linux-kernel <linux-kernel@vger.kernel.org>,akpm <akpm@zip.com.au>,
>>  torvalds <torvalds@transmet.com>,rml <rml@tech9.net>
>>In-Reply-To: <Pine.LNX.4.40.0202080838230.3883-100000@cosmic.nrg.org>
>>References: <200202081231.g18CV7e31341@ns.caldera.de>
>>Mime-Version: 1.0
>>Content-Type: text/plain; charset="us-ascii"; format=flowed
>>
>>At 16:51 08/02/02, Nigel Gamble wrote:
>>> > No.  i_sem should be split into a spinlock for short-time accessed
>>> > fields that get written to even if the file content is only read (i.e.
>>> > atime) and a read-write semaphore.
>>>
>>>Read-write semaphores should never be used.  As others have pointed out,
>>>they cause really intractable priority inversion problems (because a
>>>high priority writer will often have to wait for an unbounded number of
>>>lower priority readers, some of which may have called a blocking
>>>function while holding the read lock).
>>>
>>>Note that I'm not talking about read-write spinlocks, which are (or
>>>should be) held for a short, bounded time and can't be held over a
>>>blocking call, so they are not quite so problematic.
>>
>>Read-write semaphores have their use and the current Linux implementation
>>(big reader/occasional writer) guarantees that the writer is not starved
>>as incoming read locks are put to sleep as soon as a write lock request
>>comes in, even if that is sleeping waiting for the old readlocks to be
>>released (unless the readers are holding the semaphore forever in which
>>case this is the programmers fault and not the rw semaphore
>>implementations fault). [I should add I only am familliar with the i386
>>implementation but I assume the others are the same.]
>>
>>The value of allowing multiple cpus to read the same data simultaneously
>>by far offsets the priority problems IMVHO. At least the way I am using rw
>>semaphores in ntfs it is. Readlocks are grabbed loads and loads of times
>>to serialize meta data access in the page cache while writelocks are a
>>minute number in comparison and because the data required to be accessed
>>may not be cached in memory (page cache page is not read in, is swapped
>>out, whatever) a disk access may be required which means a rw spin lock is
>>no good. In fact ntfs would be the perfect candidate for automatic rw
>>combi locks where the locking switches from spinning to sleeping if the
>>code path reaches a disk access. I can't use a manually controlled lock as
>>the page cache lookups are done via the mm/filemap.c access functions
>>which are the only ones who can know if a disk access is required or not
>>so ntfs would never know if it is going to sleep or not so unless the
>>locks had autodetection of whether to spin or sleep they would be useless.
>>
>>I guess the point I am trying to make is that both rw semaphores and combi
>>locks are not bad per se but, as all other locking mechanisms, they should
>>be used in situations appropriate for their locktype and their
>>implementation...
>>
>>Anton
>>
>>
>>--
>>   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
>>--
>>Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
>>Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
>>ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
>>
>
>--
>   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
>--
>Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
>Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
>ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



