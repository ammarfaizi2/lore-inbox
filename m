Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277805AbRJIQOW>; Tue, 9 Oct 2001 12:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277808AbRJIQOC>; Tue, 9 Oct 2001 12:14:02 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:27653 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S277805AbRJIQNx>; Tue, 9 Oct 2001 12:13:53 -0400
Message-ID: <3BC3223E.902FB7E@zip.com.au>
Date: Tue, 09 Oct 2001 09:13:50 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: BALBIR SINGH <balbir.singh@wipro.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: is reparent_to_init a good thing to do?
In-Reply-To: <3BC3118B.8050001@wipro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BALBIR SINGH wrote:
> 
> I was looking at the driver under drivers/net/8139too.c, a kernel
> thread rtl8139_thread is created, it calls daemonize() and soon
> afterwards calls reparent_to_init(). Looking at reparent_to_init(),
> it looks like all kernel threads should do this. But, I feel I am missing
> something, since not everybody does this.
> 
> Is this a good thing to do? or are there special cases when we need this.
> 

I think yes, more kernel threads need to use this function.  Most
particularly, threads which are parented by a userspace application
and which can terminate.  For example, the nfsd threads.

Right now, it's probably the case that nfsd threads will turn
into zombies when they terminate, *if* their parent is still
running.   But of course, most kernel threads are parented
by very short-lived userspace applications, so nobody has
ever noticed.
