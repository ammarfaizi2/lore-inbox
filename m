Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289196AbSAQQMa>; Thu, 17 Jan 2002 11:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289202AbSAQQMU>; Thu, 17 Jan 2002 11:12:20 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:43752 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S289196AbSAQQMD>; Thu, 17 Jan 2002 11:12:03 -0500
From: Christoph Rohland <cr@sap.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: pte-highmem-5
In-Reply-To: <20020116185814.I22791@athlon.random> <m3u1tll6pb.fsf@linux.local>
	<20020117163021.L4847@athlon.random>
Organisation: SAP LinuxLab
In-Reply-To: <20020117163021.L4847@athlon.random> (Andrea Arcangeli's
 message of "Thu, 17 Jan 2002 16:30:21 +0100")
Message-ID: <m3bsft7ygd.fsf@linux.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
Date: Thu, 17 Jan 2002 17:11:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Thu, 17 Jan 2002, Andrea Arcangeli wrote:
> (btw, I suspect allocating one page at offset 4G in every shmfs file
> could make the overhead per page of shm to increase)

Nearly: A sparse file with the only page at 4G is the worst case: You
need three extra pages to hold the swap entry. The ratio goes fown as
soon as you add more pages somewhere.

> But in real life I really don't expect problems here, one left page
> of the vector holds 1024 swap entries, so the overhead is of the
> order of 1/1000. On the top of my head (without any precise
> calculation) 64G of shm would generate stuff of the order of some
> houndred mbytes of ram 

Ok, 64GB shm allocate roughly 64MB swap entries, so this case should
not bother too much. I was still at the 390x case where we have 512
entries per page. But they do not need highmem.

Another case are smaller machines with big tmpfs instances: They get
killed by the swap entries. But you cannot hinder that without
swapping the swap entries themselves.

Greetings
		Christoph


