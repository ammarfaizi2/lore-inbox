Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269132AbUIRFpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269132AbUIRFpX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 01:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269135AbUIRFpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 01:45:23 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:37581 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S269132AbUIRFpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 01:45:19 -0400
Message-ID: <414BCB5B.8020507@colorfullife.com>
Date: Sat, 18 Sep 2004 07:44:59 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tony Lee <tony.p.lee@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony wrote:

>I coded a IPC system before use atomic add + share memory.  
>It works very well (fast) on 4 CPU SMP system, since it doesn't use 
>any locking API at all.    Very good for resource allocation for 
>SMP.     I implemented speciall malloc/free use by ISR, different
>prority process completely without any lock.
>
Without any lock or without any common cacheline that are accessed by 
atomic operations?
I usually consider the costs of
    atomic_inc(&global_atomic_var);
and
    spin_lock(&global_lock);
    global_var++;
    spin_unlock(&global_lock);
as nearly identical (assuming that global_var and global_lock are in the 
same cacheline): one cachline transfer per run. The 5 instructions under 
the spinlock and the theoretical chance that spin_lock() blocks are 
noise compared to the cost of the line transfer.
And that's without thinking about smb_mb__{before,after}_atomic_inc().

Btw, Ingo forgot to mention sequence locks and percpu_counter as two 
high-scalability locking primitives.

--
    Manfred
