Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUFEPK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUFEPK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 11:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUFEPK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 11:10:26 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:48293 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261179AbUFEPKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 11:10:19 -0400
Message-ID: <40C1E343.8080105@elegant-software.com>
Date: Sat, 05 Jun 2004 11:14:11 -0400
From: Russell Leighton <russ@elegant-software.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: F_SETSIG broken/changed in 2.6 for UDP and TCP sockets?
References: <20040531151843.7144dfce.akpm@osdl.org> <40BFDD4F.5080408@elegant-software.com>
In-Reply-To: <40BFDD4F.5080408@elegant-software.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last issue resolved. I am posting so there is a complete thread for 
anyone that stumbles on this in the future.

F_SETSIG IS working...what is NOT working (as it did in 2.4) is the 
interaction between clone() and getpid() in child processes.
This issue altered the control of my program and made it look like I was 
not receiving signals.

I'll send another email to the kernel mailing list w/a test program that 
demonstrates this.

Russell Leighton wrote:

>
> Thanks to all that helped me troubleshoot.
>
> Of the 2 issues I had with FedoraCore2, one problem is solved:
>
>    * Multicast issues were solved by using another NIC. It seems that
>      the driver for the NatSemi DP8381[56] does not receive mutlicast
>      properly.
>    * F_SETSIG still seems broken for TCP for me when my process sets up
>      more than a few fd's...I will try the latest kernel to see if this
>      goes away
>
>
> Russ
>
> Andrew Morton wrote:
>
>> Begin forwarded message:
>>
>> Date: Mon, 31 May 2004 14:45:08 -0400
>> From: Russell Leighton <russ@elegant-software.com>
>> To: linux-kernel@vger.kernel.org
>> Subject: F_SETSIG broken/changed in 2.6 for UDP and TCP sockets?
>>
>>
>>
>> I have a program that works fine under stock rh9 (2.4.2-8) but has 
>> issues getting signaled under FedoraCore2 (2.6.5-1.358)
>> using SETSIG to a Posix RT signal.
>>
>> The program does the standard:
>>
>>  /* hook to process */
>>  if ( fcntl(fdcallback->fd, F_SETOWN, mon->handler_q.thread->pid) == 
>> -1 ) {
>>    aw_log(fdcallback->handler->logger, AW_ERROR_LOG_LEVEL,
>>       "cannot set owner on fd (%s)",
>>       strerror(errno));
>>  }/* end if */
>>
>>  /* make async */
>>  if ( fcntl(fdcallback->fd, F_SETFL, (O_NONBLOCK | O_ASYNC) ) == -1 ) {
>>    aw_log(fdcallback->handler->logger, AW_ERROR_LOG_LEVEL,
>>       "cannot set async on fd (%s)",
>>       strerror(errno));
>>  }/* end if */
>>
>>  /* hook to signal */
>>  if ( fcntl(fdcallback->fd, F_SETSIG, AW_SIG_FD) == -1 ) {
>>    aw_log(fdcallback->handler->logger, AW_ERROR_LOG_LEVEL,
>>       "cannot set signal on fd (%s)",
>>       strerror(errno));
>>  }/* end if */
>>
>> Under Fedora things work well for raw sockets (much lower latency 
>> than in 2.4!) but are inconsistent with udp or tcp sockets.
>>
>> In the udp case, I when I listen for multicast packets my app only 
>> receives them when I am running a tcpdump (bizarre!).
>>
>> In the tcp case, I don't get signaled if I do the F_SETSIG on more 
>> than 1 fd.
>>
>> Any tips on tracking this down would be much appreciated.
>>
>> Thx
>>
>> Russ
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>>  
>>
>
>

