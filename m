Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282832AbRK0HQc>; Tue, 27 Nov 2001 02:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282833AbRK0HQN>; Tue, 27 Nov 2001 02:16:13 -0500
Received: from ns.suse.de ([213.95.15.193]:63759 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282832AbRK0HQE>;
	Tue, 27 Nov 2001 02:16:04 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: Fix knfsd readahead cache in 2.4.15
In-Reply-To: <15362.18626.303009.379772@charged.uio.no.suse.lists.linux.kernel> <15362.53694.192797.275363@esther.cse.unsw.edu.au.suse.lists.linux.kernel> <20011126.155347.45872112.davem@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Nov 2001 08:16:03 +0100
In-Reply-To: "David S. Miller"'s message of "27 Nov 2001 00:58:40 +0100"
Message-ID: <p73r8qksmz0.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:
> 
> There are other problems remaining, this function is a logical
> mess.

It is also broken by design. It forces file systems that need more
state to maintain read/write ahead to maintain their own cache (e.g. XFS
which needs to cache extent allocations) 
Better would be to just fix nfsd to cache open file handles, then all
this mess would be done by the VFS. In addition it would be faster
because it wouldn't need to execute an "open()" for every rpc operation.

-Andi
