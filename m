Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbTEGJL7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 05:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbTEGJL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 05:11:59 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:18585 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263018AbTEGJL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 05:11:58 -0400
Date: Wed, 7 May 2003 11:23:29 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@transmeta.com, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix .altinstructions linking failures
Message-ID: <20030507092329.GA2389@wohnheim.fh-wedel.de>
References: <20030506063055.GA15424@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030506063055.GA15424@averell>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003 08:30:55 +0200, Andi Kleen wrote:
> 
> Some configs didn't link anymore because they got references from
> .altinstructions to __exit functions. Fixing it at the linker level
> is not easily possible. This patch just discards .text.exit at runtime
> instead of link time to avoid this.
> 
> Idea from Andrew Morton.
> 
> It will also fix a related problem with .eh_frame in modern gcc (so far 
> only observed on x86-64, but could happen on i386 too) 

But it sure won't make any embedded people happy. This adds .text.exit
(and .data.exit?) to the kernel image, which is nothing but
unnecessary bloat. Nothing inside those sections is ever used, yet
their footprint does hurt on small systems.

I've been a bit sceptical of the whole .altinstructions idea,
self-modifying code opens a can of worms for anyone trying to do code
analysis (coverage, verification,...). But with this followup, I
personally pay money to get that stuff ripped out again.

Jörn

-- 
The cost of changing business rules is much more expensive for software
than for a secretaty.
-- unknown
