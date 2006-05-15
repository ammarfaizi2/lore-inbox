Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965098AbWEOScR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbWEOScR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWEOScR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:32:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24707 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965098AbWEOScQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:32:16 -0400
Date: Mon, 15 May 2006 11:34:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: mingo@elte.hu, apw@shadowen.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 NUMA panic compile error
Message-Id: <20060515113439.457f5809.akpm@osdl.org>
In-Reply-To: <200605152013.53728.ak@suse.de>
References: <20060515005637.00b54560.akpm@osdl.org>
	<20060515175306.GA18185@elte.hu>
	<20060515110814.11c74d70.akpm@osdl.org>
	<200605152013.53728.ak@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> > 
> > I'll be darned.  I never knew it was even possible to run x86 numa kernels
> > on non-numa boxen.  I'd have tested about 1000000 of Christoph Lameter's
> > patches if someone had told me.  Yes, it's useful.
> 
> If you want to use it for that I would suggest to port the numa emulation
> code at least - two or four nodes tends to find more problems than a single
> node.
> 
> But testing on a 64bit box - even with numa emulation - would be much
> better because on 32bit ZONE_NORMAL often is node 0 only and you won't 
> get much numaness for kernel objects.

That's an excellent point - most developers who are likely to want to test
NUMA have x86_64 boxes and x86_64 has NUMA-emulation-on-SMP.  I'd
semi-forgotten that it existed.

This rather weakens the reasons for retaining support for
NUMA-on-non-summit-x86.  Ingo?

> > I guess the concern here is that we don't want people building these
> > frankenkernels and then sending us bug reports against them.
> 
> Well it will still increase the bug numbers you care so much about.

Not really.  If a bug affects something we don't care about (like this)
I'll just ignore it.  I care about the number of busted machines out there,
not the bug counts...

> Another reason I don't like it is that it's ugly and reimplements
> parts of ACPI on its own for no reason.

So shouldn't such a patch remove that code rather than panicing?

