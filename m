Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbUKCXfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbUKCXfP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbUKCXcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:32:43 -0500
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:9899 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S261890AbUKCX37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:29:59 -0500
From: Russell Miller <rmiller@duskglow.com>
To: Doug McNaught <doug@mcnaught.org>
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 3 Nov 2004 18:33:30 -0500
User-Agent: KMail/1.7
Cc: Jim Nelson <james4765@verizon.net>, DervishD <lkml@dervishd.net>,
       Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
References: <200411030751.39578.gene.heskett@verizon.net> <200411031644.58979.rmiller@duskglow.com> <87k6t24jsr.fsf@asmodeus.mcnaught.org>
In-Reply-To: <87k6t24jsr.fsf@asmodeus.mcnaught.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411031733.30469.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 17:03, Doug McNaught wrote:

> It was already mentioned in this thread that the bookkeeping required
> to clean up properly from such an abort would add a lot of overhead
> and slow down the normal, non-buggy case.
>
I am going to continue pursuing this at the risk of making a bigger fool of 
myself than I already am, but I want to make sure that I understand the 
issues - and I did read the message you are referring to.

I think what you are saying is that there is kind of a race condition here.  
When something is on the wait queue, it has to be followed through to 
completion.  An interrupt could be received at any time, and if it's taken 
off of the wait queue prematurely, it'll crash the kernel, because the 
interrupt has no way of telling that.

That's fine as it goes, I understand that.  But I submit that this is a 
horrible design.  I've been bitten by this more than once - usually regarding 
broken NFS connections.

But what I don't understand is why the bookkeeping would be so inefficient.  
It seems to me that all that would be required is a bitfield of some sort.  
If that position in the qait queue becomes invalid, when the interrupt is 
received to process it, the kernel notes that a flag is set invalidating that 
part of the wait queue, dumps the output to dave null, and goes on to the 
next.  This doesn't seem inefficient to me, unless I'm missing something.
A little more inefficient, yes, but not to near the cost that seems to be 
implied.

And I also have to ask this question:  what is more inefficient, slowing down 
processing of output waiting on the queue, or having to reboot when a process 
gets stuck due to faulty drivers?  At the very least, a compile option seems 
like it would be worthwhile for those that would like this behavior.

And I probably am.  Missing something, that is.

--Russell

> -Doug

-- 

Russell Miller - rmiller@duskglow.com - Le Mars, IA
Duskglow Consulting - Helping companies just like you to succeed for ~ 10 yrs.
http://www.duskglow.com - 712-546-5886
