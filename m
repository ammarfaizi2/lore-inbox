Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSHBReM>; Fri, 2 Aug 2002 13:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSHBReM>; Fri, 2 Aug 2002 13:34:12 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:53396 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313113AbSHBReM>; Fri, 2 Aug 2002 13:34:12 -0400
Message-ID: <3D4AC352.70702@us.ibm.com>
Date: Fri, 02 Aug 2002 10:37:22 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020728
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
CC: Kasper Dupont <kasperd@daimi.au.dk>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Race condition?
References: <3D4A8D45.49226E2B@daimi.au.dk> <200208021700.g72H0bm02654@fachschaft.cup.uni-muenchen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> Am Freitag, 2. August 2002 15:46 schrieb Kasper Dupont:
> 
>>Is there a race condition in this piece of code from do_fork in
> 
> It would seem so. Perhaps the BKL was taken previously.
> 

Even if it was, I doubt the code ever knowingly relied upon it.  If I 
know that I'm protected under a lock, I rarely go to the trouble of 
atomic operations.

The root of the problem is that the reference count is being relied on 
for the wrong thing.  There is a race on p->user between the
dup_task_struct() and whenever the atomic_inc(&p->user->__count) 
occcurs.   The user reference count needs to be incremented in 
dup_task_struct(), before the copy occurs.
-- 
Dave Hansen
haveblue@us.ibm.com

