Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRCKTVT>; Sun, 11 Mar 2001 14:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129106AbRCKTU7>; Sun, 11 Mar 2001 14:20:59 -0500
Received: from adsl-63-200-41-38.steelrain.org ([63.200.41.38]:64529 "EHLO
	thor.sbay.org") by vger.kernel.org with ESMTP id <S129066AbRCKTUt>;
	Sun, 11 Mar 2001 14:20:49 -0500
Date: Sun, 11 Mar 2001 11:17:10 -0800 (PST)
From: Dave Zarzycki <dave@zarzycki.org>
To: Anton Blanchard <anton@linuxcare.com.au>
cc: Davide Libenzi <davidel@xmailserver.org>, Andi Kleen <ak@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: sys_sched_yield fast path
In-Reply-To: <20010312005448.A5439@linuxcare.com>
Message-ID: <Pine.LNX.4.30.0103111038420.9486-100000@batman.zarzycki.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2001, Anton Blanchard wrote:

> Perhaps we need something like sched_yield that takes off some of
> tsk->counter so the task with the spinlock will run earlier.

Personally speaking, I wish sched_yield() API was like so:

int sched_yield(pid_t pid);

The pid argument would be advisory, of course, the kernel doesn't have to
honor it.

This would allow the thread wanting to acquire the spinlock to yield
specifically to the thread holding the lock (assuming the pid of the lock
holder was stored in the spinlock...) In fact, the the original lock owner
could in theory yield back to the threading wanting to acquire the lock.

Feedback from the scheduling gurus would be appreciated.

Thanks,

davez

-- 
Dave Zarzycki
http://thor.sbay.org/~dave/


