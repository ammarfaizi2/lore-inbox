Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUBDRlB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 12:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUBDRlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 12:41:01 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:29121 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262130AbUBDRk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 12:40:59 -0500
Date: Wed, 4 Feb 2004 12:40:48 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: VM patches (please review)
In-Reply-To: <402128D0.2020509@tmr.com>
Message-ID: <Pine.LNX.4.44.0402041239311.24515-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Feb 2004, Bill Davidsen wrote:

> Since this is broken down nicely, a line or two about what each patch 
> does or doesn't address would be useful. In particular, having just 
> gotten a working RSS I'm suspicious of the patch named vm-no-rss-limit 
> being desirable ;-)

The bug with the RSS limit patch is that I forgot to
change the exec() code, so when init is exec()d it
gets an RSS limit of zero, which is inherited by all
its children --> always over the RSS limit, no page
aging, etc.

I need to find the cleanest way to add the inheriting
of RSS limit at exec time and send a patchlet for that
to akpm...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

