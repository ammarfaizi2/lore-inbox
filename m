Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265552AbUFDCUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265552AbUFDCUs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 22:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265548AbUFDCUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 22:20:48 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:7672 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265554AbUFDCUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 22:20:42 -0400
Message-ID: <40BFDD4F.5080408@elegant-software.com>
Date: Thu, 03 Jun 2004 22:24:15 -0400
From: Russell Leighton <russ@elegant-software.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: F_SETSIG broken/changed in 2.6 for UDP and TCP sockets?
References: <20040531151843.7144dfce.akpm@osdl.org>
In-Reply-To: <20040531151843.7144dfce.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks to all that helped me troubleshoot.

Of the 2 issues I had with FedoraCore2, one problem is solved:

    * Multicast issues were solved by using another NIC. It seems that
      the driver for the NatSemi DP8381[56] does not receive mutlicast
      properly.
    * F_SETSIG still seems broken for TCP for me when my process sets up
      more than a few fd's...I will try the latest kernel to see if this
      goes away


Russ

Andrew Morton wrote:

>Begin forwarded message:
>
>Date: Mon, 31 May 2004 14:45:08 -0400
>From: Russell Leighton <russ@elegant-software.com>
>To: linux-kernel@vger.kernel.org
>Subject: F_SETSIG broken/changed in 2.6 for UDP and TCP sockets?
>
>
>
>I have a program that works fine under stock rh9 (2.4.2-8) but has 
>issues getting signaled under FedoraCore2 (2.6.5-1.358)
>using SETSIG to a Posix RT signal.
>
>The program does the standard:
>
>  /* hook to process */
>  if ( fcntl(fdcallback->fd, F_SETOWN, mon->handler_q.thread->pid) == -1 ) {
>    aw_log(fdcallback->handler->logger, AW_ERROR_LOG_LEVEL,
>       "cannot set owner on fd (%s)",
>       strerror(errno));
>  }/* end if */
>
>  /* make async */
>  if ( fcntl(fdcallback->fd, F_SETFL, (O_NONBLOCK | O_ASYNC) ) == -1 ) {
>    aw_log(fdcallback->handler->logger, AW_ERROR_LOG_LEVEL,
>       "cannot set async on fd (%s)",
>       strerror(errno));
>  }/* end if */
>
>  /* hook to signal */
>  if ( fcntl(fdcallback->fd, F_SETSIG, AW_SIG_FD) == -1 ) {
>    aw_log(fdcallback->handler->logger, AW_ERROR_LOG_LEVEL,
>       "cannot set signal on fd (%s)",
>       strerror(errno));
>  }/* end if */
>
>Under Fedora things work well for raw sockets (much lower latency than 
>in 2.4!) but are inconsistent with udp or tcp sockets.
>
>In the udp case, I when I listen for multicast packets my app only 
>receives them when I am running a tcpdump (bizarre!).
>
>In the tcp case, I don't get signaled if I do the F_SETSIG on more than 
>1 fd.
>
>Any tips on tracking this down would be much appreciated.
>
>Thx
>
>Russ
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

