Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267921AbUJOOOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267921AbUJOOOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 10:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUJOOOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 10:14:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45265 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267777AbUJOOJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 10:09:59 -0400
Message-ID: <416FDA2C.1080007@redhat.com>
Date: Fri, 15 Oct 2004 10:09:48 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Tasklet usage?
References: <416FCD3E.8010605@drzeus.cx> <416FD177.1050404@redhat.com> <416FD4C0.3090403@drzeus.cx>
In-Reply-To: <416FD4C0.3090403@drzeus.cx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Neil Horman wrote:
> 
>> Pierre Ossman wrote:
> 
> 
>>> * Can tasklets be preempted?
>>
>>
>> A tasklet can get preempted by a hard interrupt, but tasklets run in 
>> interrupt context, so don't do anything in a tasklet that can call 
>> schedule.
> 
> 
> Being preempted by hard interrupts is sort of the point of moving the 
> stuff to a tasklet. Just as long as other tasklets and user space cannot 
> preempt it.
> 
> Are there any concerns when it comes to locking and tasklets? I've tried 
> finding kernel-locking-HOWTO referenced in kernel-docs.txt but the link 
> is dead and I can't find a mirror.
> 
Locking in tasklets needs to be done the same way locking in interrupt 
handlers is done.  The only caveat that I can think of is that in the 
event that you are accessing data shared with code that runs outisde of 
the tasklet, you probably need to use spin_lock_bh to disable softirqs 
in the latter code.  In your environment, it would typically replace the 
use of spin_lock_irq[save|restore].

HTH
Neil

> Rgds
> Pierre
> 


-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
