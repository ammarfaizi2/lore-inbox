Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268191AbUHZKea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268191AbUHZKea (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 06:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268357AbUHZKeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:34:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:38120 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268191AbUHZKdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 06:33:22 -0400
Date: Thu, 26 Aug 2004 03:31:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Harry Edmon <harry@atmos.washington.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: page allocation or what in 2.6.8.1
Message-Id: <20040826033131.2cc153a9.akpm@osdl.org>
In-Reply-To: <200408251451.i7PEpQ7K020113@moist.atmos.washington.edu>
References: <200408251451.i7PEpQ7K020113@moist.atmos.washington.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harry Edmon <harry@atmos.washington.edu> wrote:
>
> I have had another crash on the same system as my message of 23 August:
> 
> Unable to handle kernel paging request at virtual address cf0b4e1c

hm.  Is the hardware known to be good?

> ...
> 
> Before the crash I see messages like the following:
> 
> oom-killer: gfp_mask=0xd0

That's because you've enabled CONFIG_DEBUG_PAGEALLOC.  It enormously
increases the size of slab objects, which seems to cause memory reclaim to
blow up.  (It shouldn't but it does.  It's a low-priority problem though).

It's unlikely that the oom-killing caused the oops, but it's possible I
guess.  There's supposed to be a dump_stack() in the out_of_memory() path,
which would help in searching for bugs, but that seems to have got lost.

