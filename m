Return-Path: <linux-kernel-owner+w=401wt.eu-S932990AbWL0QZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932990AbWL0QZl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 11:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932993AbWL0QZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 11:25:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56060 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932990AbWL0QZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 11:25:40 -0500
Date: Wed, 27 Dec 2006 16:25:30 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: Re: [RFC] Heads up on a series of AIO patchsets
Message-ID: <20061227162530.GA23000@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>, linux-aio@kvack.org,
	akpm@osdl.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
References: <20061227153855.GA25898@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227153855.GA25898@in.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 09:08:56PM +0530, Suparna Bhattacharya wrote:
> (2) Most of these other applications need the ability to process both
>     network events (epoll) and disk file AIO in the same loop. With POSIX AIO
>     they could at least sort of do this using signals (yeah, and all associated
>     issues). The IO_CMD_EPOLL_WAIT patch (originally from Zach Brown with
>     modifications from Jeff Moyer and me) addresses this problem for native
>     linux aio in a simple manner. Tridge has written a test harness to 
>     try out the Samba4 event library modifications to use this. Jeff Moyer
>     has a modified version of pipetest for comparison.

The real question here is which interface we want people to use for these
"combined" applications.  Evgeny is heavily pushing kevent for this while
other seem to prefer integration epoll into the aio interface. (1)

I must admit that kevent seems to be the cleaner way to support this,
although I see some advantages for the aio variant.  I do think however
that we should not actively promote two differnt interfaces long term.


(1) note that there is another problem with the current kevent interface,
	and that is that it duplicates the event infrastructure for it's
	underlying subsystems instead of reusing existing code (e.g.
	inotify, epoll, dio-aio).  If we want kevent to be _the_ unified
	event system for Linux we need people to help out with straightening
	out these even provides as Evgeny seems to be unwilling/unable to
	do the work himself and the duplication is simply not acceptable.

