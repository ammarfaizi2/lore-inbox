Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbTIYErG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 00:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbTIYErG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 00:47:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:724 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261690AbTIYErE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 00:47:04 -0400
Date: Wed, 24 Sep 2003 21:47:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: rfc: test whether a device has a partition table
In-Reply-To: <20030924235041.GA21416@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0309242137090.1729-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Sep 2003, Andries Brouwer wrote:
> 
> My post implicitly suggested the minimal thing to do.
> It will not be enough - heuristics are never enough -
> but it probably helps in most cases.

I don't mind the 0x00/0x80 "boot flag" checks - those look fairly obvious
and look reasonably safe to add to the partitioning code.

There are other checks that can be done - verifying that the start/end
sector values are at all sensible. We do _some_ of that, but only for
partitions 3 and 4, for example. We could do more - like checking the
actual sector numbers (but I think some formatters leave them as zero).

Which actually makes me really nervous - it implies that we've probably 
seen partitions 1&2 contain garbage there, and the problem is that if 
you'r etoo careful in checking, you will make a system unusable.

This is why it is so much nicer to be overly permissive ratehr than being 
a stickler for having all the values right.

And your random byte checks for power-of-2 make no sense. What are they
based on?

		Linus

