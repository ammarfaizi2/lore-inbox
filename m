Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267693AbRGPTgA>; Mon, 16 Jul 2001 15:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267691AbRGPTfv>; Mon, 16 Jul 2001 15:35:51 -0400
Received: from james.kalifornia.com ([208.179.59.2]:55340 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S267686AbRGPTfj>; Mon, 16 Jul 2001 15:35:39 -0400
Message-ID: <3B5341E0.7010006@blue-labs.org>
Date: Mon, 16 Jul 2001 15:34:56 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010716
X-Accept-Language: en-us
MIME-Version: 1.0
To: Josh Logan <josh@wcug.wwu.edu>
CC: Andrea Arcangeli <andrea@suse.de>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Andrew Morton <andrewm@uow.edu.au>,
        Klaus Dittrich <kladit@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7p6 hang
In-Reply-To: <Pine.BSO.4.21.0107161214160.11198-100000@sloth.wcug.wwu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chances are that you have TEQL as one of your packet schedulers?

Try the patch Dave M posted this morning, let me fetch it...

--- net/core/dev.c.~1~	Mon Jul  9 22:19:33 2001
+++ net/core/dev.c	Sat Jul 14 17:25:51 2001
@@ -2654,10 +2654,6 @@
 	if (!dev_boot_phase)
 		return 0;
 
-#ifdef CONFIG_NET_SCHED
-	pktsched_init();
-#endif
-
 #ifdef CONFIG_NET_DIVERT
 	dv_init();
 #endif /* CONFIG_NET_DIVERT */
@@ -2771,6 +2767,10 @@
 
 	dst_init();
 	dev_mcast_init();
+
+#ifdef CONFIG_NET_SCHED
+	pktsched_init();
+#endif
 
 	/*
 	 *	Initialise network devices


David

Josh Logan wrote:

>I just tried 2.4.6-ac5 and I had the same problem.  I'll go try 2.4.7-pre4
>next.
>
>							Later, JOSH
>
>
>On Wed, 11 Jul 2001, Josh Logan wrote:
>
>>
>>On Wed, 11 Jul 2001, Andrea Arcangeli wrote:
>>
>>>On Wed, Jul 11, 2001 at 11:33:40AM -0700, Josh Logan wrote:
>>>
>>>>I'm having a hang right after the floppy is initialised with pre5 and pre6
>>>>(2.4.3 works fine)  I tried this patch, but it did not make any
>>>>
>>>is the problem introduced in pre5? Can you reproduce under 2.4.7pre4?
>>>
>>I'll have to go try it...
>>
>>>>improvments.  The machine still has SysRq commands available.  Please let
>>>>me know what other information you would like to debug this problem.
>>>>
>>>SYSRQ+T
>>>
>>Floppy Drives(s): fd0 is 1.44M
>>FDC 0 is a post-1991 82077
>>SysRq: Show State
>>
>>  task		     PC    stack    pid father child younger older
>>swapper		D C03EDEC0  4980      1      0     7               (L-TLB)
>>keventd		S C1234560  6624      2      1             3       (L-TLB)
>>ksoftirqd_CPU   S C1232000  6468      3      1             4     2 (L-TLB)
>>kswapd		S C1231FA8  6588      4      1             5     3 (L-TLB)
>>kreclaimd	S 00000286  6656      5      1             6     4 (L-TLB)
>>bdflush		S 00000286  6652      6      1             7     5 (L-TLB)
>>kupdated	S C7F9BFC8  6620      7      1                   6 (L-TLB)
>>
>>I can add Call Traces if needed, this is done by hand.
>>
>>>>BTW, I also tried to disable the floppy in the BIOS and got:
>>>>...
>>>>Floppy OK
>>>>task queue still active
>>>><HANG>
>>>>
>>>I'll soon have a look at this message.
>>>
>>>Andrea
>>>
>>							Later, JOSH
>>
>>
>>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


