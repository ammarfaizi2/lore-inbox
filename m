Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291780AbSBAPZf>; Fri, 1 Feb 2002 10:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291788AbSBAPZY>; Fri, 1 Feb 2002 10:25:24 -0500
Received: from sun.fadata.bg ([80.72.64.67]:2323 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S291780AbSBAPZO>;
	Fri, 1 Feb 2002 10:25:14 -0500
To: <mingo@elte.hu>
Cc: Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>, John Stoffel <stoffel@casc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <Pine.LNX.4.33.0202011801260.11284-100000@localhost.localdomain>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.LNX.4.33.0202011801260.11284-100000@localhost.localdomain>
Date: 01 Feb 2002 17:26:42 +0200
Message-ID: <87y9idusst.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ingo" == Ingo Molnar <mingo@elte.hu> writes:

Ingo> On 1 Feb 2002, Momchil Velikov wrote:

Ingo> files are used. With one big file (or a few big files), the i_shared_lock
Ingo> will always bounce between CPUs wildly in read() workloads, degrading
>> 
>> Will there be difference between bounces of a rwlock in the radix tree
>> variant and the cache misses in hashed locks variant for the case of
>> concurrently accessed large file ?

Ingo> definitely, because in the case of page buckets there are many locks
Ingo> hashed in a mapping-neutral way. Ie. different parts of the same file will
Ingo> likely map to different spinlocks.

That's why it's likely to miss on each access.  

Ingo> In the radix tree case all pages in the inode will map to the
Ingo> same spinlock.

That's why it's likely to bounce on each access.

So, is there any difference ? :)

Regards,
-velco
