Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751624AbWEETD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbWEETD7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 15:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWEETD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 15:03:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18588 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751532AbWEETD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 15:03:58 -0400
Date: Wed, 3 May 2006 18:20:29 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
In-Reply-To: <Pine.LNX.4.64.0605020832570.4086@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0605031816480.13777@cuia.boston.redhat.com>
References: <346556235.24875@ustc.edu.cn> <Pine.LNX.4.64.0605020832570.4086@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2006, Linus Torvalds wrote:
> On Tue, 2 May 2006, Wu Fengguang wrote:
> >
> >  4 files changed, 48 insertions(+), 2 deletions(-)
> 
> So I would _seriously_ claim that the place to do all the statistics 
> allocation is in anything that ends up having to call "->readpage()", and 
> do it all on a virtual mapping level.

Why not simply read everything in a whole file at a time
at boot time, while we still have enough free memory ?

We can have a small modification to the readahead code
to read in the whole file on the first read or fault,
or maybe even on open.

Once the system is done booting, it can switch this
bootup readahead mode off through a tunable in /proc.
If the system is booting on a system with not enough
memory to load everything file-at-a-time, the bootup
scripts can switch this off earlier (or not switch
it on).

The kernel modifications needed to make this work
are minimal.  It might need some tweaking so we don't
try to read in truly enormous files, but that is easy.

Does this sound reasonable ?

-- 
All Rights Reversed
