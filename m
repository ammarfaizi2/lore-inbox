Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292130AbSCWBYV>; Fri, 22 Mar 2002 20:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290983AbSCWBWt>; Fri, 22 Mar 2002 20:22:49 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41967 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S310441AbSCWBPR>;
	Fri, 22 Mar 2002 20:15:17 -0500
Message-ID: <3C9BB6E9.16D1C533@zip.com.au>
Date: Fri, 22 Mar 2002 14:57:45 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tony.P.Lee@nokia.com
CC: linux-kernel@vger.kernel.org
Subject: Re: mprotect() api overhead.
In-Reply-To: <4D7B558499107545BB45044C63822DDE3A2043@mvebe001.NOE.Nokia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony.P.Lee@nokia.com wrote:
> 
> ...
> What I like to do is to use the mprotect() api to turn on/off the
> memory read/write access to the globally share memory.  This
> way, the only possible memory corruption to the share table
> is from the APIs in the libForwardTableManager.so.  It makes
> debugging this kind of problem easier.  If the application
> corrupts the memory, it will cause a seg-fault which also
> makes debugging simple.
> 
> Questions for the linux kernel guru are:
> 
>         Is this reasonable to do in Linux?
> 
>         Any idea the overhead for such scheme in term of numbers of
>         micro-seconds added to each API call.  I like to see the
>         overhead in sub-microseconds range since the application
>         might call the api in libForwardTableManager.so  at the rate
>         of 100k api call per seconds.
> 
>         I used the TSC counter to profile the mprotect() overhead
>         in QNX (micro-kernel RTOS).  It has overhead is 130
>         milliseconds for 6 MB of share memory which is extremely high.
>         I think the reason is all of QNX APIs turns to IPC messages
>         to process manager task.  It cause context switch to
>         other tasks.

Seems that mprotect() against a 6 megabyte region takes five microseconds
in Linux.  Which is too expensive for you.

It would be better if you could map the same memory region
two times.  One with PROT_READ and the other with PROT_READ|PROT_WRITE.
Then just use the appropriate pointer at the appropriate time.

-
