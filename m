Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135353AbRDLVxc>; Thu, 12 Apr 2001 17:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135354AbRDLVxV>; Thu, 12 Apr 2001 17:53:21 -0400
Received: from dfmail.f-secure.com ([194.252.6.39]:27330 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S135353AbRDLVxO>; Thu, 12 Apr 2001 17:53:14 -0400
Date: Fri, 13 Apr 2001 01:02:21 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
        <Valdis.Kletnieks@vt.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: scheduler went mad?
In-Reply-To: <Pine.LNX.4.21.0104121632330.18260-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.30.0104130009350.19377-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Apr 2001, Rik van Riel wrote:
> On Thu, 12 Apr 2001, Szabolcs Szakacsits wrote:
> > You mean without dropping out_of_memory() test in kswapd and calling
> > oom_kill() in page fault [i.e. without additional patch]?
> No.  I think it's ok for __alloc_pages() to call oom_kill()
> IF we turn out to be out of memory, but that should not even
> be needed.

Not __alloc_pages() calls oom_kill() however do_page_fault(). Not the
same. After the system tried *really* hard to get *one* free page and
couldn't managed why loop forever? To eat CPU and waiting for
out_of_memory() to *guess* when system is in OOM? I don't think so, if
processes can't progress because system can't page in any of their
pages, somebody must go.

> Also, when a task in __alloc_pages() is OOM-killed, it will
> have PF_MEMALLOC set and will immediately break out of the
> loop. The rest of the system will spin around in the loop
> until the victim has exited and then their allocations will
> succeed.

Yes, I think this is a problem. In page fault if OOM, "bad" process
selected, scheduled, killed and everybody runs happily even without to
notice system is low on memory. Fast and gracious process killing
instead of slow, painful death IF out_of_memory() correctly detects OOM.

	Szaka

