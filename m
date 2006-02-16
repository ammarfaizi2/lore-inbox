Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWBPUY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWBPUY0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 15:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWBPUY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 15:24:26 -0500
Received: from zcars04f.nortel.com ([47.129.242.57]:25255 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP id S964896AbWBPUYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 15:24:25 -0500
Message-ID: <43F4DF54.6030303@nortel.com>
Date: Thu, 16 Feb 2006 14:23:48 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
CC: Arjan van de Ven <arjan@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V3 - Why in userspace?
References: <Pine.OSF.4.05.10602162057040.20911-100000@da410>
In-Reply-To: <Pine.OSF.4.05.10602162057040.20911-100000@da410>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Feb 2006 20:23:50.0374 (UTC) FILETIME=[E5D3A060:01C63336]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Nielsen wrote:
> On Thu, 16 Feb 2006, Arjan van de Ven wrote:
> 
> 
>>On Thu, 2006-02-16 at 20:06 +0100, Esben Nielsen wrote:

>>>Why does the list have to be in userspace?
>>
>>because it's faster ;)

> Faster??? 
> As I see it, extra manipulations have to be done even in the non-congested
> case: Every time the lock is taken the locking thread has to add the lock
> to a the list, and reversely remove the lock from the list. I.e.
> instructions are _added_ to the fast path where you stay purely in
> userspace.
> 
> I am ofcourse comparing to a solution where you do a syscall on everytime
> you do a lock.


The whole *point* of futexes is that on uncontested operations you don't 
have to do a syscall.  Thus, if you can avoid taking a syscall while 
still getting reliability, you'll be faster.

Dropping to kernelspace isn't free.

Chris

