Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbUKXHxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbUKXHxi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbUKXHve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:51:34 -0500
Received: from waste.org ([209.173.204.2]:24470 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262547AbUKXHuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:50:54 -0500
Date: Tue, 23 Nov 2004 23:50:39 -0800
From: Matt Mackall <mpm@selenic.com>
To: Colin Leroy <colin@colino.net>
Cc: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
Message-ID: <20041124075038.GG2460@waste.org>
References: <20041118194959.3f1a3c8e.colin@colino.net> <20041124031726.GF8040@waste.org> <20041124083430.5cf5d621@pirandello>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124083430.5cf5d621@pirandello>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 08:34:30AM +0100, Colin Leroy wrote:
> On 23 Nov 2004 at 19h11, Matt Mackall wrote:
> 
> Hi, 
> 
> > BUG_ON(!bh);
> > sync_dirty_buffer(bh);
> > brelse(bh);
> 
> I wasn't sure sync_dirty_buffer and brelse checked for nullity :)

It may, that wasn't my point. Your original patch had BUG_ON(1) which
by itself was weird (use BUG() instead). But then it was in the else
part of an if statement. So it read like:

if (bh) {
   ...
} else {
  if (1)
     BUG(); /* stop kernel */
}

BUG is for reporting things that should never happen (otherwise you'd
actually handle them) and so should be used in such a way that they
don't complicate the code flow.

> > Concept seems good, and the implementation otherwise looks good at
> > first glance.
> 
> Cool :) Should I submit an updated patch to Andrew for -mm ?

Probably ought to go through Ogawa, if he can be convinced to take it.
Please take a look at adding -o sync and -o async options to override
the superblock flag first.

-- 
Mathematics is the supreme nostalgia of our time.
