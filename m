Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbVHTESr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbVHTESr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 00:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbVHTESr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 00:18:47 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:40882 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030214AbVHTESq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 00:18:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=GnY3UteFtCU63dhiOQAccSCMKW2re5S1HZu0TApf7AaTESu57damwUDS2JfyKT8R/zAvJ7uHLCnxshdt0d2eLsoC0hnvVMrQeOkzU9urVxH8kNoRhnrEglFlkOkNwiGx/blmKaDe+Cd03o2fz62Kbp6CObwTOx9BnERQRQUsdcs=  ;
Message-ID: <4306AF26.3030106@yahoo.com.au>
Date: Sat, 20 Aug 2005 14:18:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched_yield() makes OpenLDAP slow
References: <4D8eT-4rg-31@gated-at.bofh.it> <4306A176.3090907@shaw.ca>
In-Reply-To: <4306A176.3090907@shaw.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:

> 
> I fail to see how sched_yield is going to be very helpful in this 
> situation. Since that call can sleep from a range of time ranging from 
> zero to a long time, it's going to give unpredictable results.
> 

Well, not sleep technically, but yield the CPU for some undefined
amount of time.

> It seems to me that this sort of thing is why we have POSIX pthread 
> synchronization primitives.. sched_yield is basically there for a 
> process to indicate that "what I'm doing doesn't matter much, let other 
> stuff run". Any other use of it generally constitutes some kind of hack.
> 

In SCHED_OTHER mode, you're right, sched_yield is basically meaningless.

In a realtime system, there is a very well defined and probably useful
behaviour.

Eg. If 2 SCHED_FIFO processes are running at the same priority, One can
call sched_yield to deterministically give the CPU to the other guy.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
