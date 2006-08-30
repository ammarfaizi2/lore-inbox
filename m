Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWH3ToX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWH3ToX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWH3ToX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:44:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62629 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751398AbWH3ToV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:44:21 -0400
Date: Wed, 30 Aug 2006 12:44:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] BLOCK: Make it possible to disable the block
 layer [try #6]
Message-Id: <20060830124400.23ca9b38.akpm@osdl.org>
In-Reply-To: <20060829180634.32596.4507.stgit@warthog.cambridge.redhat.com>
References: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
	<20060829180634.32596.4507.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think I'll just slam all this in at the first opportunity.  Stuff will
break, but it will be easy to fix.

If you try to upissue this patchset I shall be seeking an IP-routable hand
grenade.

On Tue, 29 Aug 2006 19:06:34 +0100
David Howells <dhowells@redhat.com> wrote:

> +static inline long blk_congestion_wait(int rw, long timeout)
> +{
> +	return timeout;
> +}

This function is misnamed and is implemented in the wrong place.  It's not
really a block thing at all.  If/when/soon NFS starts to implement it and
call it, things will need to be renamed and reshuffled.

Simply stubbing it out like this will cause general mayhem and CPU meltdown
all over the writeback and page-reclaim code.

So...  for now, I'll replace it with a simple io_schedule_timeout(timeout),
which is equivalent to what we do now for network filesystems.

