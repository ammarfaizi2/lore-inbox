Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263192AbREWSCy>; Wed, 23 May 2001 14:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263194AbREWSCo>; Wed, 23 May 2001 14:02:44 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:60000 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263192AbREWSCf>; Wed, 23 May 2001 14:02:35 -0400
Date: Wed, 23 May 2001 18:34:19 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: DVD blockdevice buffers
Message-ID: <20010523183419.I27177@redhat.com>
In-Reply-To: <20010518210226.A7147@moserv.hasi> <20010518212531.A6763@suse.de> <9e7ain$lis$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9e7ain$lis$1@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, May 19, 2001 at 07:36:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 19, 2001 at 07:36:07PM -0700, Linus Torvalds wrote:

> Right now we don't try to aggressively drop streaming pages, but it's
> possible. Using raw devices is a silly work-around that should not be
> needed, and this load shows a real problem in current Linux (one soon to
> be fixed, I think - Andrea already has some experimental patches for the
> page-cache thing).

Right.  I'd like to see buffered IO able to work well --- apart from
the VM issues, it's the easiest way to allow the application to take
advantage of readahead.  However, there's one sticking point we
encountered, which is applications which write to block devices in
units smaller than a page.  Small block writes get magically
transformed into read/modify/write cycles if you shift the block
devices into the page cache.

Of course, we could just say "then don't do that" and be done with it
--- after all, we already have this behaviour when writing to regular
files.

--Stephen
