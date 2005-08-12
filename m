Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVHLQfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVHLQfN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 12:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVHLQfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 12:35:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48335 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750704AbVHLQfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 12:35:12 -0400
Date: Fri, 12 Aug 2005 09:35:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference
 between /dev/kmem and /dev/mem)
In-Reply-To: <1123809302.17269.139.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
References: <1123796188.17269.127.camel@localhost.localdomain>
 <1123809302.17269.139.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Aug 2005, Steven Rostedt wrote:
> 
> Found the problem.  It is a bug with mmap_kmem.  The order of checks is
> wrong, so here's the patch.  Attached is a little program that reads the
> System map looking for the variable modprobe_path.  If it finds it, then
> it opens /dev/kmem for read only and mmaping it to read the contents of
> modprobe_path.

I'm actually more inclined to try to deprecate /dev/kmem.. I don't think 
anybody has ever really used it except for some rootkits. It only exists 
in the first place because it's historical.

We do need to support /dev/mem for X, but even that might go away some 
day. 

So I'd be perfectly happy to fix this, but I'd be even happier if we made 
the whole kmem thing a config variable (maybe even default it to "off").

		Linus
