Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWEMO43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWEMO43 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 10:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWEMO43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 10:56:29 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:63331 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751195AbWEMO42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 10:56:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ojhoFyfEVReE3gm7r2epUttJnwQ5Qv/jnlgdO40UehHmem8qQssIVNPyRj56td7i3gWr59ErgwNhZjhwl0rFHF6E57FAD4RmX8/qSy0KU1IbJzZt0Jfz6CpWU97f7CaxRzTPMvyf8ieTMQ68j5tO46XoIImmy8kk+qsA65CWyVs=  ;
Message-ID: <4465F392.60102@yahoo.com.au>
Date: Sun, 14 May 2006 00:56:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Silly bitmap size accounting fix
References: <Pine.LNX.4.58.0605120403540.28581@gandalf.stny.rr.com> <20060512091451.GA18145@elte.hu> <4465386B.9090804@yahoo.com.au> <Pine.LNX.4.58.0605131010110.27003@gandalf.stny.rr.com> <4465EF80.6010106@yahoo.com.au> <Pine.LNX.4.58.0605131051160.27751@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0605131051160.27751@gandalf.stny.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> 
>>>+/*
>>>+ * Calculate BITMAP_SIZE.
>>>+ *  The bitmask holds MAX_PRIO bits + 1 for the delimiter.
>>
>>+ * Calculation is to find the minimum number of longs that holds MAX_PRIO+1 bits:
>>+ *  size-in-chars = ceiling((MAX_PRIO+1) / CHAR_BITS)
>>+ *  size-in-longs = ceiling(size-in-chars / sizeof(long))
>>
>>
>>>+ */
>>> #define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
>>>
>>
> 
> What do you think of the following comment, better?

Cool, thanks.

> 
> -- Steve
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Index: linux-2.6.17-rc3-mm1/kernel/sched.c
> ===================================================================
> --- linux-2.6.17-rc3-mm1.orig/kernel/sched.c	2006-05-12 04:02:32.000000000 -0400
> +++ linux-2.6.17-rc3-mm1/kernel/sched.c	2006-05-13 10:50:44.000000000 -0400
> @@ -192,6 +192,13 @@ static inline unsigned int task_timeslic
>   * These are the runqueue data structures:
>   */
> 
> +/*
> + * Calculate BITMAP_SIZE.
> + *  The bitmask holds MAX_PRIO bits + 1 for the delimiter.
> + *  BITMAP_SIZE is the minimum number of longs that holds MAX_PRIO+1 bits:
> + *   size-in-bytes = ceiling((MAX_PRIO+1) / BITS_PER_BYTE)
> + *   size-in-longs = ceiling(size-in-bytes / sizeof(long))
> + */
>  #define BITMAP_SIZE ((((MAX_PRIO+1+7)/8)+sizeof(long)-1)/sizeof(long))
> 
>  typedef struct runqueue runqueue_t;
> 


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
