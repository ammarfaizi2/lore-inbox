Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262818AbVAFN3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbVAFN3H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 08:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbVAFN3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 08:29:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34448 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262818AbVAFN3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 08:29:04 -0500
Date: Thu, 6 Jan 2005 08:28:43 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, nickpiggin@yahoo.com.au,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][5/?] count writeback pages in nr_scanned
In-Reply-To: <20050105213704.0282316f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0501060827200.11550@chimarrao.boston.redhat.com>
References: <20050105173624.5c3189b9.akpm@osdl.org>
 <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com>
 <41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org>
 <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org>
 <20050106045932.GN4597@dualathlon.random> <20050105210539.19807337.akpm@osdl.org>
 <20050106051707.GP4597@dualathlon.random> <41DCCA68.3020100@yahoo.com.au>
 <20050106052507.GR4597@dualathlon.random> <20050105213704.0282316f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005, Andrew Morton wrote:

> The timeouts are for:
>
> a) A fallback for backing stores which don't wake up waiters in
>   blk_congestion_wait() (eg: NFS).

This is buggy, btw.  NFS has a "fun" deadlock where it can
send so many writes over the wire at once that the PF_MEMALLOC
allocations eat up all memory and there's no memory left to
receive ACKs from the NFS server ...

NFS will need to act congested when memory is low and there
are already some writeouts underway.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
