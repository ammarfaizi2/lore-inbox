Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVAXVJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVAXVJa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVAXVHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:07:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25317 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261661AbVAXVFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:05:49 -0500
Date: Mon, 24 Jan 2005 22:05:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: alexn@dsv.su.se, kas@fi.muni.cz, linux-kernel@vger.kernel.org,
       lennert.vanalboom@ugent.be, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050124210538.GD19242@suse.de>
References: <20050121161959.GO3922@fi.muni.cz> <1106360639.15804.1.camel@boxen> <20050123091154.GC16648@suse.de> <20050123011918.295db8e8.akpm@osdl.org> <20050123095608.GD16648@suse.de> <20050123023248.263daca9.akpm@osdl.org> <1106528219.867.22.camel@boxen> <20050124204659.GB19242@suse.de> <20050124125649.35f3dafd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124125649.35f3dafd.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2005, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> >  Here is the output of your program (somewhat modified, I cut the runtime
> >  by 19/20 killing the 1-byte reads :-) after 10 hours of use with
> >  bk-current as of this morning.
> 
> hmm..
> 
> 62130 times: Page allocated via order 0
> [0xffffffff80173d6e] pipe_writev+574
> [0xffffffff8017402a] pipe_write+26
> [0xffffffff80168b47] vfs_write+199
> [0xffffffff80168cb3] sys_write+83
> [0xffffffff8011e4f3] cstar_do_call+27
> 
> 55552 times: Page allocated via order 0
> [0xffffffff80173d6e] pipe_writev+574
> [0xffffffff8017402a] pipe_write+26
> [0xffffffff8038b88d] thread_return+41
> [0xffffffff80168b47] vfs_write+199
> [0xffffffff80168cb3] sys_write+83
> [0xffffffff8011e4f3] cstar_do_call+27
> 
> Would indicate that the new pipe code is leaking.

I suspected that, I even tried backing out the new pipe patches but it
still seemed to leak. And the test cases I tried to come up with could
not provoke a pipe leak. But yeah, it certainly is the most likely
culprit and the leak did start in the period when it was introduced.

-- 
Jens Axboe

