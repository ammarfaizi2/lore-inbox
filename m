Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUEJWMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUEJWMN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUEJWMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:12:12 -0400
Received: from roadrunner.doc.ic.ac.uk ([146.169.1.193]:9169 "EHLO
	roadrunner.doc.ic.ac.uk") by vger.kernel.org with ESMTP
	id S261984AbUEJWLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:11:50 -0400
Message-ID: <409FFE22.4050508@bluetheta.com>
Date: Mon, 10 May 2004 23:11:46 +0100
From: Andre Ben Hamou <andre@bluetheta.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Multithread select() bug
References: <409FF38C.7080902@bluetheta.com> <409FFADD.7050204@cosmosbay.com>
In-Reply-To: <409FFADD.7050204@cosmosbay.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> Your program is racy and have undefined behavior.
> 
> A thread should not close a handle 'used by another thread blocked in a 
> sytemcall'
> 
> The race is : if a thread does a close(fd), then the fd value may be 
> reused by another thread during an open()/socket()/dup()... syscall, and 
> the first thread could issue the select() syscall (or 
> read()/write()/...) on the bad file.

Apologies, but I don't follow this.

It was my understanding that the (potentially) many threads of a single 
process all share a canonical file descriptor table. Hence as long as 
the various calls you mention are issued in a guaranteed order, 
maintaining state as you go (which is what the 1 second sleep in the 
test code was a very quick and dirty way to almost do), I don't see how 
a race condition arises.

If I were to replace the sleep (1) with, say a global semaphore or 
something similar, would your explanation still hold?

Cheers,

Andre Ben Hamou
Imperial College London

-- 

...and, on the seventh day, God switched off his Mac.
