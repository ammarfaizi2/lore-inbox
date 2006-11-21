Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031352AbWKUTpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031352AbWKUTpv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031353AbWKUTpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:45:51 -0500
Received: from smtp.osdl.org ([65.172.181.25]:20643 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031352AbWKUTpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:45:50 -0500
Date: Tue, 21 Nov 2006 11:45:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Raskin <a1d23ab4@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1+ memory problem
Message-Id: <20061121114543.817fc06e.akpm@osdl.org>
In-Reply-To: <4563485B.3050801@mail.ru>
References: <45614A95.6090102@mail.ru>
	<20061121003745.aeda4f7c.akpm@osdl.org>
	<4563485B.3050801@mail.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 21:41:31 +0300
Michael Raskin <a1d23ab4@mail.ru> wrote:

> Andrew Morton wrote:
> > On Mon, 20 Nov 2006 09:26:29 +0300
> > Michael Raskin <a1d23ab4@mail.ru> wrote:
> > 
> >> Short description: when X is loaded (maybe any heavy application is 
> >> sufficient, but I don't use anything heavy in console), 'free' says used 
> >> memory is growing.
> >>
> Thank you for reply.
> 
> > Monitor /proc/meminfo
> Thanks for advice. I didn't think of it. I should be ashamed.
> 
> Result: mysterious. All fields that grow can not account for even a 
> third part.
> 
> In top I found a situation when 2MB (~half a minute) go to nowhere and 
> no of first 50 processes changes resident memory usage at all. The rest 
> have less than a MB each.
> 
> > If the leak is slab, monitor /proc/slabinfo and /proc/slab_allocators.
> I hope no.
> > /proc/slab_allocators needs CONFIG_DEBUG_SLAB_LEAK.
> > 
> > Thanks.
> > 
> I did a few cat /proc/meminfo. Two of them are here:
> 
> MemTotal:       763532 kB     763532 kB
> MemFree:        445956 kB     430932 kB
> Buffers:         20908 kB      21048 kB
> Cached:          77008 kB      77212 kB
> SwapCached:          0 kB          0 kB
> Active:          65916 kB      66120 kB
> Inactive:        54748 kB      54884 kB
> SwapTotal:     1052216 kB    1052216 kB
> SwapFree:      1052216 kB    1052216 kB
> Dirty:             264 kB        324 kB
> Writeback:           0 kB          0 kB
> AnonPages:       22752 kB      22748 kB
> Mapped:          14616 kB      14628 kB
> Slab:            23108 kB      23088 kB
> SReclaimable:    15360 kB      15364 kB
> SUnreclaim:       7748 kB       7724 kB
> PageTables:       1216 kB       1216 kB
> NFS_Unstable:        0 kB          0 kB
> Bounce:              0 kB          0 kB
> CommitLimit:   1433980 kB    1433980 kB
> Committed_AS:   281456 kB     281448 kB
> VmallocTotal:   262104 kB     262104 kB
> VmallocUsed:      2876 kB       2876 kB
> VmallocChunk:   259028 kB     259028 kB

You lost 15MB and they didn't even turn up on the page LRU.

Can you try to determine exactly which activity causes this to happen?  In
particular, is it due to the X server?  If so, does any particular client
cause it to happen?  Things which use 3d?
