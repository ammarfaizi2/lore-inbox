Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278269AbRJWUwg>; Tue, 23 Oct 2001 16:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278295AbRJWUw0>; Tue, 23 Oct 2001 16:52:26 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:5392 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S278269AbRJWUwN>;
	Tue, 23 Oct 2001 16:52:13 -0400
Date: Tue, 23 Oct 2001 18:52:35 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Issue with max_threads (and other resources) and highmem
In-Reply-To: <72940000.1003868385@baldur>
Message-ID: <Pine.LNX.4.33L.0110231850100.3690-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2001, Dave McCracken wrote:

> A quick examination of fork_init() shows that max_threads is supposed
> to be limited so its stack/task_struct takes no more than half of
> physical memory.  This calculation ignores the fact that task_structs
> must be allocated from the normal pool and not the highmem pool, which
> is a clear bug.

It also ignores the fact that tasks need things like page
tables, VMAs, etc...  The total kernel memory demand of
the maximum number of tasks the kernel allows by default
is way higher than physical memory.

I submitted a patch a while ago to set the number way lower,
which was accepted by Alan and in the -ac kernels. A few months
later Linus followed and changed the limit in his kernels, too.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

