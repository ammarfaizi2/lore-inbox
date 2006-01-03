Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWACWON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWACWON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 17:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWACWON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 17:14:13 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:47717 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S964897AbWACWOM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 17:14:12 -0500
Message-ID: <43BAF72C.2030608@cosmosbay.com>
Date: Tue, 03 Jan 2006 23:14:04 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] Optimize select/poll by putting small data sets
 on the stack
References: <200601032158.14057.ak@suse.de>
In-Reply-To: <200601032158.14057.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen a écrit :
> This is a RFC for now. I would be interested in testing
> feedback. Patch is for 2.6.15.
> 
> Optimize select and poll by a using stack space for small fd sets
> 
> This brings back an old optimization from Linux 2.0. Using
> the stack is faster than kmalloc. On a Intel P4 system
> it speeds up a select of a single pty fd by about 13%
> (~4000 cycles -> ~3500)

Was this result on UP or SMP kernel ? Preempt or not ?

I think we might play in do_pollfd() and use fget_light()/fput_light() instead 
of fget()/fput() that are somewhat expensive because of atomic inc/dec on SMP.

(I believe that select()/poll() based daemons are mostly non multi-threaded, 
since high performance multi-threaded programs should be using epoll...)

Eric

