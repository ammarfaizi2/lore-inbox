Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUFRWHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUFRWHa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbUFRWGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:06:42 -0400
Received: from cantor.suse.de ([195.135.220.2]:8595 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263731AbUFRWD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 18:03:29 -0400
Date: Sat, 19 Jun 2004 00:03:26 +0200
From: Andi Kleen <ak@suse.de>
To: Brent Casavant <bcasavan@sgi.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] Add kallsyms_lookup() result cache
Message-Id: <20040619000326.067c3ff6.ak@suse.de>
In-Reply-To: <Pine.SGI.4.58.0406181435570.5029@kzerza.americas.sgi.com>
References: <Pine.SGI.4.58.0406181435570.5029@kzerza.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 15:03:00 -0500
Brent Casavant <bcasavan@sgi.com> wrote:

> On 2.6 based systems, the top command utilizes /proc/[pid]/wchan to
> determine WCHAN symbol name information.  This information is provided
> by the kernel function kallsyms_lookup(), which expands a stem-compressed

That sounds more like a bug in your top to me. /proc/*/wchan itself
does not access kallsyms, it just outputs a number. 

My top doesn't do that.

Are you saying your top reads /proc/kallsyms on each redisplay? 
That sounds completely wrong - it should only read the file once
and cache it and then look the numbers it is reading from wchan
in the cache.

Doing the cache in the kernel is the wrong place. This should be fixed
in user space.

As an unrelated comment: i would suggest to avoid rwlocks until
absolutely needed. They are a lot slower than regular spinlocks.

-Andi

