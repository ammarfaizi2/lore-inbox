Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280012AbRK0Qpl>; Tue, 27 Nov 2001 11:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280817AbRK0Qpc>; Tue, 27 Nov 2001 11:45:32 -0500
Received: from mail.spylog.com ([194.67.35.220]:42452 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S280012AbRK0QpU>;
	Tue, 27 Nov 2001 11:45:20 -0500
Date: Tue, 27 Nov 2001 19:46:07 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: SpyLOG
X-Priority: 3 (Normal)
Message-ID: <183721898675.20011127194607@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: MMAP issues
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,

  I'm trying to write a program which uses mmap agressively to mmap
  files (really it's used as fail safe memory allocator to store data
  if application failed)
  I'm using the latest kernel 2.4.16.

  I've found a couple of problems.

  1) I can mmap only about 64K files (4K size ones) and I can't find there the limit
  is triggered. I can open huge number of files (tried 500K) or I can
  map ammoniums pages even  lager number.  May be this limit is
  compiled in kernel somehow so may be changed ?
  The error code returned is 12 -  Can not allocate memory

  2) I see the speed dramatically degrades over time with mapping
  segments:
zetta:/home/pz/mmap # ./a.out
 10000  Time: 7
 20000  Time: 22
 30000  Time: 38
 40000  Time: 61
 50000  Time: 78
 60000  Time: 90

 First 10000 of mmaps took only  7 second there  mapping 10000 of
 files after 50000 took 90 seconds.  I used the same file associated
 with many file descriptors to avoid disk related speed issues. Map
 ammoniums in the same case are runned much faster and with almost no
 speed penalty as well as open calls.  So the question is if this
 thing may be tuned somehow - hash increase or something.


 3) It looks like the speed degrades over the program runs:

 1st
 10000  Time: 7
 20000  Time: 22
 30000  Time: 38
 40000  Time: 61
 50000  Time: 78
 60000  Time: 90 

 2nd
 10000  Time: 7
 20000  Time: 28
 30000  Time: 49
 40000  Time: 71
 50000  Time: 92
 60000  Time: 104 

 3rd
 10000  Time: 9
 20000  Time: 31
 30000  Time: 52
 40000  Time: 68
 50000  Time: 87
 60000  Time: 107 





-- 
Best regards,
 Peter                          mailto:pz@spylog.ru

